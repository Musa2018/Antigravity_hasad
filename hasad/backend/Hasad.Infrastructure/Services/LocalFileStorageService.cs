using Hasad.Application.Common.Interfaces;
using Microsoft.AspNetCore.Hosting;

namespace Hasad.Infrastructure.Services;

public class LocalFileStorageService : IFileStorageService
{
    private readonly string _storagePath;
    private readonly string _baseUrl;

    public LocalFileStorageService(IWebHostEnvironment env)
    {
        _storagePath = Path.Combine(env.WebRootPath ?? env.ContentRootPath, "uploads");
        _baseUrl = "/uploads";

        if (!Directory.Exists(_storagePath))
        {
            Directory.CreateDirectory(_storagePath);
        }
    }

    public async Task<string> SaveAsync(Stream fileStream, string fileName, string contentType, CancellationToken cancellationToken)
    {
        var relativePath = Path.Combine(DateTime.UtcNow.ToString("yyyyMMdd"), fileName);
        var fullPath = Path.Combine(_storagePath, relativePath);

        var directory = Path.GetDirectoryName(fullPath);
        if (directory != null && !Directory.Exists(directory))
        {
            Directory.CreateDirectory(directory);
        }

        using var output = File.Create(fullPath);
        await fileStream.CopyToAsync(output, cancellationToken);

        return relativePath.Replace("\\", "/");
    }

    public Task DeleteAsync(string remotePath, CancellationToken cancellationToken)
    {
        var fullPath = Path.Combine(_storagePath, remotePath);
        if (File.Exists(fullPath))
        {
            File.Delete(fullPath);
        }
        return Task.CompletedTask;
    }

    public string GetUrl(string remotePath)
    {
        return $"{_baseUrl}/{remotePath}";
    }
}
