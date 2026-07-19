using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using Hasad.Domain.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Infrastructure.Persistence.Seed;

/// <summary>
/// Seeds the role catalogue and, when explicitly configured, an initial administrator.
/// </summary>
public static class DbInitializer
{
    /// <summary>
    /// Ensures all application roles exist.
    /// </summary>
    /// <param name="roleManager">Identity role manager.</param>
    public static async Task SeedRolesAsync(RoleManager<IdentityRole> roleManager)
    {
        foreach (var roleName in AppRoles.All())
        {
            if (!await roleManager.RoleExistsAsync(roleName))
            {
                await roleManager.CreateAsync(new IdentityRole(roleName));
            }
        }
    }

    /// <summary>
    /// Creates the initial SuperAdmin account using externally supplied credentials.
    /// Does nothing when the account already exists.
    /// </summary>
    /// <param name="userManager">Identity user manager.</param>
    /// <param name="email">Administrator email address.</param>
    /// <param name="password">Administrator password; must satisfy the configured password policy.</param>
    /// <returns>The Identity result of the create operation, or null when the user already existed.</returns>
    public static async Task<IdentityResult?> SeedSuperAdminAsync(
        UserManager<ApplicationUser> userManager, string email, string password)
    {
        var existing = await userManager.FindByEmailAsync(email);
        if (existing is not null)
        {
            return null;
        }

        var user = new ApplicationUser
        {
            UserName = email,
            Email = email,
            FullName = "Super Admin",
            EmailConfirmed = true,
            CreatedAt = DateTime.UtcNow
        };

        var result = await userManager.CreateAsync(user, password);
        if (result.Succeeded)
        {
            await userManager.AddToRoleAsync(user, "SuperAdmin");
        }

        return result;
    }

    /// <summary>
    /// Seeds default compensation rules if none exist.
    /// </summary>
    public static async Task SeedCompensationRulesAsync(ApplicationDbContext context)
    {
        if (await context.CompensationRules.AnyAsync())
        {
            return;
        }

        context.CompensationRules.Add(new CompensationRule
        {
            Id = Guid.NewGuid(),
            Name = "Standard 80% Rule",
            Description = "Standard compensation rule covering 80% of estimated losses.",
            Multiplier = 0.8m,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        });

        await context.SaveChangesAsync();
    }

    /// <summary>
    /// Seeds the official Palestinian geographic dataset (Governorates and Directorates).
    /// </summary>
    public static async Task SeedGeographicsAsync(ApplicationDbContext context)
    {
        var geographics = new List<(string Code, string NameAr, string NameEn, (string NameAr, string NameEn)[] Directorates, (string NameAr, string NameEn)[] Localities)>
        {
            ("JN", "جنين", "Jenin", new[] { ("مديرية جنين", "Jenin Directorate") }, new[] { ("مدينة جنين", "Jenin City"), ("قباطية", "Qabatiya"), ("اليامون", "Ya'bad") }),
            ("TB", "طوباس", "Tubas", new[] { ("مديرية طوباس", "Tubas Directorate") }, new[] { ("طوباس", "Tubas"), ("طمون", "Tammun"), ("عقابا", "Aqqaba") }),
            ("TK", "طولكرم", "Tulkarm", new[] { ("مديرية طولكرم", "Tulkarm Directorate") }, new[] { ("طولكرم", "Tulkarm City"), ("عتيل", "Attil"), ("دير الغصون", "Deir al-Ghusun") }),
            ("NB", "نابلس", "Nablus", new[] { ("مديرية نابلس", "Nablus Directorate") }, new[] { ("مدينة نابلس", "Nablus City"), ("عصيرة الشمالية", "Asira al-Shamaliya"), ("بيتا", "Beita") }),
            ("QL", "قلقيلية", "Qalqilya", new[] { ("مديرية قلقيلية", "Qalqilya Directorate") }, new[] { ("قلقيلية", "Qalqilya City"), ("عزون", "Azzun"), ("حبلة", "Habla") }),
            ("SL", "سلفيت", "Salfit", new[] { ("مديرية سلفيت", "Salfit Directorate") }, new[] { ("سلفيت", "Salfit City"), ("بديا", "Biddya"), ("الزاوية", "Zawiya") }),
            ("RM", "رام الله والبيرة", "Ramallah & Al-Bireh", new[] { ("مديرية رام الله", "Ramallah Directorate") }, new[] { ("رام الله", "Ramallah City"), ("البيرة", "Al-Bireh"), ("بيتونيا", "Beituniya") }),
            ("JR", "أريحا", "Jericho", new[] { ("مديرية أريحا", "Jericho Directorate") }, new[] { ("أريحا", "Jericho City"), ("العوجا", "Al-Auja"), ("الجفتلك", "Al-Jiftlik") }),
            ("JS", "القدس", "Jerusalem", new[] { ("مديرية القدس", "Jerusalem Directorate") }, new[] { ("القدس", "Jerusalem City"), ("العيزرية", "Al-Eizariya"), ("أبو ديس", "Abu Dis") }),
            ("BT", "بيت لحم", "Bethlehem", new[] { ("مديرية بيت لحم", "Bethlehem Directorate") }, new[] { ("بيت لحم", "Bethlehem City"), ("بيت جالا", "Beit Jala"), ("بيت ساحور", "Beit Sahour") }),
            ("HB", "الخليل", "Hebron", new[] { ("مديرية شمال الخليل", "North Hebron"), ("مديرية جنوب الخليل", "South Hebron"), ("مديرية الخليل", "Hebron Directorate") }, new[] { ("مدينة الخليل", "Hebron City"), ("حلحول", "Halhul"), ("دورا", "Dura"), ("يطا", "Yatta") }),
            ("NG", "شمال غزة", "North Gaza", new[] { ("مديرية شمال غزة", "North Gaza Directorate") }, new[] { ("جباليا", "Jabalia"), ("بيت لاهيا", "Beit Lahiya"), ("بيت حانون", "Beit Hanoun") }),
            ("GZ", "غزة", "Gaza", new[] { ("مديرية غزة", "Gaza Directorate") }, new[] { ("مدينة غزة", "Gaza City"), ("المغراقة", "Al-Mughraqa") }),
            ("DB", "دير البلح", "Deir al-Balah", new[] { ("مديرية الوسطى", "Central Directorate") }, new[] { ("دير البلح", "Deir al-Balah City"), ("النصيرات", "Nuseirat"), ("البريج", "Maghazi") }),
            ("KY", "خانيونس", "Khan Yunis", new[] { ("مديرية خانيونس", "Khan Yunis Directorate") }, new[] { ("خانيونس", "Khan Yunis City"), ("بني سهيلا", "Bani Suheila"), ("عبسان الكبيرة", "Abasan al-Kabira") }),
            ("RF", "رفح", "Rafah", new[] { ("مديرية رفح", "Rafah Directorate") }, new[] { ("رفح", "Rafah City"), ("شوكة الصوفي", "Al-Shoka") })
        };

        var existingGovernorates = await context.Governorates
            .Include(g => g.Directorates)
            .Include(g => g.Localities)
            .ToDictionaryAsync(g => g.Code);

        foreach (var (code, nameAr, nameEn, directorates, localities) in geographics)
        {
            if (!existingGovernorates.TryGetValue(code, out var governorate))
            {
                governorate = new Governorate
                {
                    Id = Guid.NewGuid(),
                    Code = code,
                    NameAr = nameAr,
                    NameEn = nameEn,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };
                context.Governorates.Add(governorate);
            }
            else
            {
                governorate.NameAr = nameAr;
                governorate.NameEn = nameEn;
            }

            foreach (var (dirNameAr, dirNameEn) in directorates)
            {
                var existingDir = governorate.Directorates
                    .FirstOrDefault(d => d.NameEn == dirNameEn);

                if (existingDir == null)
                {
                    context.Directorates.Add(new Directorate
                    {
                        Id = Guid.NewGuid(),
                        NameAr = dirNameAr,
                        NameEn = dirNameEn,
                        GovernorateId = governorate.Id,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    });
                }
                else
                {
                    existingDir.NameAr = dirNameAr;
                }
            }

            foreach (var (locNameAr, locNameEn) in localities)
            {
                var existingLoc = governorate.Localities
                    .FirstOrDefault(l => l.NameEn == locNameEn);

                if (existingLoc == null)
                {
                    context.Localities.Add(new Locality
                    {
                        Id = Guid.NewGuid(),
                        NameAr = locNameAr,
                        NameEn = locNameEn,
                        GovernorateId = governorate.Id,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    });
                }
                else
                {
                    existingLoc.NameAr = locNameAr;
                }
            }
        }

        await context.SaveChangesAsync();
    }
}
