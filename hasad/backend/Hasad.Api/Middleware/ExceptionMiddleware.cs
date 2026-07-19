using System.Net;
using System.Text.Json;
using FluentValidation;
using Hasad.Application.Common.Models;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Middleware;

public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionMiddleware> _logger;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (ValidationException ex)
        {
            _logger.LogInformation("Request validation failed: {Errors}",
                string.Join("; ", ex.Errors.Select(e => e.ErrorMessage)));
            await WriteResultAsync(context, HttpStatusCode.BadRequest,
                Result<object>.Failure(ex.Errors.Select(e => e.ErrorMessage).ToArray()));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An unhandled exception has occurred.");
            await WriteResultAsync(context, HttpStatusCode.InternalServerError,
                Result<object>.Failure(new[] { "An unexpected error occurred." }));
        }
    }

    private static Task WriteResultAsync(HttpContext context, HttpStatusCode statusCode, Result<object> result)
    {
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)statusCode;

        var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
        return context.Response.WriteAsync(JsonSerializer.Serialize(result, options));
    }
}
