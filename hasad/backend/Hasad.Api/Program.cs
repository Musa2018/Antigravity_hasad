using System.Text;
using System.Threading.RateLimiting;
using Asp.Versioning;
using FluentValidation;
using Hasad.Api.Middleware;
using Hasad.Application.Common.Behaviors;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Options;
using Hasad.Domain.Identity;
using Hasad.Infrastructure.Persistence;
using Hasad.Infrastructure.Persistence.Seed;
using Hasad.Infrastructure.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Add Serilog
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .CreateLogger();

builder.Host.UseSerilog();

// Add Database
var useInMemory = builder.Configuration.GetValue<bool>("UseInMemoryDatabase");
if (useInMemory)
{
    Log.Information("Using In-Memory Database for development/testing.");
    builder.Services.AddDbContext<ApplicationDbContext>(options =>
    {
        options.UseInMemoryDatabase("HasadDb");
    });
}
else
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
    Log.Information("Connecting to database: {ConnectionString}", connectionString);

    builder.Services.AddDbContext<ApplicationDbContext>(options =>
    {
        options.UseSqlServer(connectionString,
            b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName));
    });
}

builder.Services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<ApplicationDbContext>());

// Add Identity with lockout and password policy
builder.Services.AddIdentity<ApplicationUser, IdentityRole>(options =>
{
    options.Password.RequiredLength = 12;
    options.Password.RequireDigit = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireNonAlphanumeric = true;
    options.Lockout.AllowedForNewUsers = true;
    options.Lockout.MaxFailedAccessAttempts = 5;
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(15);
    options.User.RequireUniqueEmail = true;
})
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

// Bind and validate JWT options (key comes from environment variables or user secrets, never the repo)
builder.Services.AddOptions<JwtOptions>()
    .Bind(builder.Configuration.GetSection(JwtOptions.SectionName))
    .Validate(o => !string.IsNullOrWhiteSpace(o.Key) && o.Key.Length >= JwtOptions.MinimumKeyLength,
        $"JwtSettings:Key is missing or shorter than {JwtOptions.MinimumKeyLength} characters. " +
        "Provide it via the JwtSettings__Key environment variable or 'dotnet user-secrets'.")
    .Validate(o => !string.IsNullOrWhiteSpace(o.Issuer), "JwtSettings:Issuer is required.")
    .Validate(o => !string.IsNullOrWhiteSpace(o.Audience), "JwtSettings:Audience is required.")
    .Validate(o => o.AccessTokenMinutes > 0, "JwtSettings:AccessTokenMinutes must be positive.")
    .Validate(o => o.RefreshTokenDays > 0, "JwtSettings:RefreshTokenDays must be positive.")
    .ValidateOnStart();

var jwtOptions = builder.Configuration.GetSection(JwtOptions.SectionName).Get<JwtOptions>() ?? new JwtOptions();
if (string.IsNullOrWhiteSpace(jwtOptions.Key) || jwtOptions.Key.Length < JwtOptions.MinimumKeyLength)
{
    throw new InvalidOperationException(
        $"JwtSettings:Key is missing or shorter than {JwtOptions.MinimumKeyLength} characters. " +
        "Provide it via the JwtSettings__Key environment variable or 'dotnet user-secrets'.");
}

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = !builder.Environment.IsDevelopment();
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtOptions.Key)),
        ValidateIssuer = true,
        ValidIssuer = jwtOptions.Issuer,
        ValidateAudience = true,
        ValidAudience = jwtOptions.Audience,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.FromMinutes(1)
    };
});

// Rate limiting for authentication endpoints (per client IP)
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddPolicy("auth", httpContext =>
        RateLimitPartition.GetFixedWindowLimiter(
            httpContext.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            _ => new FixedWindowRateLimiterOptions
            {
                PermitLimit = 10,
                Window = TimeSpan.FromMinutes(1),
                QueueLimit = 0
            }));
});

// Add API Versioning
builder.Services.AddApiVersioning(options =>
{
    options.DefaultApiVersion = new ApiVersion(1, 0);
    options.AssumeDefaultVersionWhenUnspecified = true;
    options.ReportApiVersions = true;
});

builder.Services.AddMediatR(cfg =>
{
    cfg.RegisterServicesFromAssembly(typeof(Hasad.Application.Features.Accounts.Commands.Login.LoginCommand).Assembly);
    cfg.AddOpenBehavior(typeof(ValidationBehavior<,>));
});
builder.Services.AddValidatorsFromAssembly(typeof(Hasad.Application.Features.Accounts.Commands.Login.LoginCommandValidator).Assembly);

builder.Services.AddSingleton(TimeProvider.System);
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IRefreshTokenStore, RefreshTokenStore>();
builder.Services.AddScoped<IFileStorageService, LocalFileStorageService>();
builder.Services.AddScoped<IEmailService, SmtpEmailService>();
builder.Services.AddScoped<ICompensationService, CompensationService>();
builder.Services.AddScoped<ICurrentUserService, CurrentUserService>();
builder.Services.AddHttpContextAccessor();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "HASAD API", Version = "v1" });
    options.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Bearer {token}\""
    });
    options.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
    options.CustomSchemaIds(type => type.FullName);
});

var app = builder.Build();

// Seed Database
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var context = services.GetRequiredService<ApplicationDbContext>();
        if (context.Database.IsRelational())
        {
            var pending = (await context.Database.GetPendingMigrationsAsync()).ToList();
            await context.Database.MigrateAsync();
            Log.Information("Database schema is up to date; applied {Count} pending migration(s).", pending.Count);
        }
        else
        {
            await context.Database.EnsureCreatedAsync();
            Log.Information("Non-relational provider detected; database created via EnsureCreatedAsync.");
        }

        var roleManager = services.GetRequiredService<RoleManager<IdentityRole>>();
        await DbInitializer.SeedRolesAsync(roleManager);
        await DbInitializer.SeedCompensationRulesAsync(context);
        await DbInitializer.SeedGeographicsAsync(context);

        var seedAdminEmail = app.Configuration["SeedAdmin:Email"];
        var seedAdminPassword = app.Configuration["SeedAdmin:Password"];
        Log.Information("Attempting to seed SuperAdmin: {Email}", seedAdminEmail ?? "MISSING");

        if (!string.IsNullOrWhiteSpace(seedAdminEmail) && !string.IsNullOrWhiteSpace(seedAdminPassword))
        {
            var userManager = services.GetRequiredService<UserManager<ApplicationUser>>();
            var result = await DbInitializer.SeedSuperAdminAsync(userManager, seedAdminEmail, seedAdminPassword);
            if (result is { Succeeded: false })
            {
                throw new InvalidOperationException(
                    $"Seeding the SuperAdmin failed: {string.Join("; ", result.Errors.Select(e => e.Description))}");
            }

            if (result is null)
            {
                Log.Information("SuperAdmin account already exists; seeding skipped.");
            }
            else
            {
                Log.Information("SuperAdmin account seeded successfully.");
            }
        }
        else
        {
            Log.Information("SeedAdmin credentials not configured; skipping SuperAdmin seeding.");
        }
    }
    catch (Exception ex)
    {
        Log.Fatal(ex, "An error occurred during database migration or seeding.");
        throw;
    }
}

// Middleware
app.UseMiddleware<ExceptionMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseSerilogRequestLogging();
app.UseHttpsRedirection();
app.UseRateLimiter();
app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/health", () => Results.Ok(new { status = "Healthy", timestamp = DateTime.UtcNow }));
app.MapControllers();

app.Run();
