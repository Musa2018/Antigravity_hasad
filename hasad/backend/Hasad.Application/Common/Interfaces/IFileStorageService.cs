namespace Hasad.Application.Common.Interfaces;

public interface IFileStorageService
{
    Task<string> SaveAsync(Stream fileStream, string fileName, string contentType, CancellationToken cancellationToken);
    Task DeleteAsync(string remotePath, CancellationToken cancellationToken);
    string GetUrl(string remotePath);
}
