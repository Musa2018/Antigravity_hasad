# ADR-0007: Dependency Injection

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0

## Context
Components must be composed without hard-wiring concrete types, and
configuration must be validated before the application serves traffic.

## Decision
- The built-in ASP.NET Core DI container is the single composition root
  (`Program.cs` in Hasad.Api).
- Interfaces live in Application; implementations are registered from
  Infrastructure (`ITokenService` → `TokenService`, `IRefreshTokenStore` →
  `RefreshTokenStore`) with **scoped** lifetime for anything using the
  `DbContext` and **singleton** only for stateless services.
- Configuration uses the **options pattern**: strongly-typed classes (e.g.,
  `JwtOptions`) bound from configuration sections with
  `ValidateOnStart`-style fail-fast checks (missing/short JWT key aborts
  startup).
- `TimeProvider` is injected wherever the current time matters
  (refresh-token expiry) so tests can control the clock.

## Consequences
- No service locators or static singletons; all dependencies are explicit.
- Misconfiguration is caught at boot, not on first request.
- Flutter-side DI uses Riverpod providers (documented separately when the
  mobile sprints begin).
