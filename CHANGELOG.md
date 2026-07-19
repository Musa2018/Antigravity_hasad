# Changelog

## [Unreleased]

### Sprint 4 — CI/CD Hardening

#### Changed
- `.github/workflows/dotnet.yml`: `actions/checkout@v4`, `actions/setup-dotnet@v4`
  pinned to SDK `8.0.422` with NuGet dependency caching; added a
  `dotnet format --verify-no-changes` gate; build now passes
  `-p:ContinuousIntegrationBuild=true` for deterministic output; tests publish
  TRX results and Cobertura coverage as a build artifact; workflow runs are
  cancelled on superseding pushes to the same ref (concurrency group).
- `.github/workflows/flutter.yml`: `actions/checkout@v4`; Flutter pinned to
  `3.41.2` (matches `.metadata`, Dart `3.11.0`, satisfying the `^3.11.0` SDK
  constraint) instead of the floating `3.x`; added `flutter-action` cache;
  tests now run with `--coverage` and the LCOV report is published as a
  build artifact; concurrency cancellation added.
- `hasad/backend/global.json`: added, pinning the backend to .NET SDK
  `8.0.422` (`rollForward: latestPatch`) so local and CI builds resolve the
  same SDK deterministically.
- `hasad/backend/docker-compose.yml`: pinned `postgres:alpine` to
  `postgres:16-alpine`; removed the obsolete top-level `version` key; added a
  `pg_isready` healthcheck and a named volume for dev data persistence.

#### Notes
- Infrastructure/config only — no application code, business logic, APIs, or
  architecture changed. Validated locally (SDK 8.0.422, Flutter 3.41.2):
  `dotnet format`/`build`/`test` (31/31 passing) and `dart format`/`flutter
  analyze`/`flutter test --coverage` (38/38 passing) all green.
- Closes #22, #23.

### Sprint 3 — Testing & Code Coverage

#### Added
- Backend: `LogoutCommandHandler` tests and `DbInitializer` seeding tests
  (role idempotency, SuperAdmin creation/duplicate-skip, password-policy
  failure) — 31 backend unit tests total.
- Mobile: LoginScreen loading-state and Arabic/RTL widget tests, HomeScreen
  widget tests (welcome, logout, RTL), and router auth-guard tests (splash
  hold during restoration, login redirect, session restoration to home,
  post-login navigation, logout return) — 38 mobile tests total.
- No production code changes; tests only.

## [v0.3.0-alpha] — Sprint 2: Mobile Stabilization

### Fixed (post-release hardening, PR #35)
- Malformed backend auth payloads now surface as `AuthException` instead of
  escaping as raw deserialization errors (stuck login spinner / unhandled
  Future error at startup).

### Added
- `AuthSession` model matching the backend auth contract, with an
  `AuthRepository` for `/accounts/login`, `/accounts/refresh`, and
  `/accounts/logout` (rotation-aware, error-envelope parsing).
- `TokenRefresher`: single-flight refresh-token rotation with secure
  persistence; concurrent callers share one in-flight refresh.
- `AuthInterceptor`: attaches the Bearer token to API requests and, on `401`,
  transparently rotates the token and retries the request once.
- `AuthNotifier` (Riverpod) auth state machine: login, logout with server-side
  revocation, and automatic session restoration on app start.
- Auth-guarded `GoRouter` (splash/login/home) that re-evaluates redirects when
  the auth state changes; `HomeScreen` with logout.
- Localized (English/Arabic) login form validation and error reporting.
- 22 new unit/widget tests plus an opt-in live E2E test covering the full
  auth lifecycle against a running backend.

### Changed
- `EnvironmentConfig` now fails fast with a clear `StateError` when accessed
  before initialization; `main()` initializes it from `--dart-define=ENV`
  before `runApp()` (fixes the login-time crash).
- `LoginScreen` rewritten: proper controller lifecycle, client-side
  validation, loading state, and backend error surfacing.

### Removed
- Unused `User` model (required an `id` the backend never returns), replaced
  by `AuthSession`.

## [v0.3.0-alpha] — Sprint 1: Backend Stabilization

### Added
- FluentValidation wired into the MediatR pipeline via `ValidationBehavior<,>`;
  malformed requests now short-circuit with `400 Bad Request` before reaching
  handlers (previously the package was declared but unused).
- Validators for `LoginCommand`, `RefreshTokenCommand`, and `LogoutCommand`.
- Explicit logging for database initialization and SuperAdmin seeding outcomes.
- 11 new unit tests (validation behavior + validators); 25 total.

### Changed
- MediatR pinned to 12.5.0, the last Apache-2.0 release, per the approved
  licensing decision (ADR 0008). No code changes were required.
- EF Core migration history squashed into a single verified `InitialCreate`
  migration producing an identical schema (9 tables, verified via
  `dotnet ef migrations script`). No production database exists yet, so no
  deployed schema is affected; the previous migrations are recoverable by
  reverting the squash commit.
- `ExceptionMiddleware` now maps `FluentValidation.ValidationException` to
  `400` with the individual error messages; unexpected exceptions remain `500`
  with a generic message.

## [v0.3.0-alpha] — Sprint 0: Security Hardening & Complete Authentication Subsystem

### Security
- Removed the committed JWT signing key from all configuration files; the key
  is now loaded only from environment variables or user secrets
  (`JwtSettings__Key`) and startup fails fast if it is missing or shorter than
  32 characters. **The previously committed key must be considered
  compromised and must not be reused.**
- Replaced the broken `${VAR}` placeholders in `appsettings.Production.json`
  (never substituted by .NET) with standard environment-variable
  configuration; Production now boots from environment variables alone.
- Seed admin account is no longer created unconditionally with hardcoded
  credentials; it is created only when `SeedAdmin__Email` and
  `SeedAdmin__Password` are configured.
- JWT validation now enforces issuer and audience; access-token lifetime
  reduced from 7 days to 60 minutes; zero clock skew;
  `RequireHttpsMetadata = true` outside Development.
- Login failures (unknown email, wrong password, lockout) now return a generic
  `401 Unauthorized` (previously `400`), preventing account enumeration.
- Auth endpoints rate limited: 10 requests/minute per client IP (`429`).
- Identity hardening: 12-character minimum password policy with complexity
  requirements; lockout after 5 failed attempts for 15 minutes.

### Added
- Persisted refresh tokens (`RefreshTokens` table, EF migration
  `AddRefreshTokens`): SHA-256 hashed storage, 14-day lifetime, rotation on
  every refresh, family revocation on token reuse, and revoke-on-logout.
- `POST /api/v1/accounts/refresh` and `POST /api/v1/accounts/logout` endpoints.
- `ITokenService` / `IRefreshTokenStore` abstractions with Infrastructure
  implementations; strongly-typed `JwtOptions`.
- `Hasad.Application.Tests` project (xUnit + NSubstitute): 14 tests covering
  the token service, refresh-token store, and login/refresh handlers.
- Architecture Decision Records `docs/adr/0001`–`0007`.
- `PROJECT_STATUS.md` living status document and a pull request template.

## [v0.2.0-alpha] - 2024-05-24
### Added
- Clean Architecture implementation for Backend (.NET 8) and Mobile (Flutter).
- Authentication system with JWT and Identity.
- Offline-first foundation and synchronization models.
- Environment configuration (Dev, Staging, Prod).
- Secure storage service for mobile.
- Comprehensive documentation (Architecture, Domain, Auth, Sync, Security).

## [v0.1.0-alpha] - 2024-05-23
### Added
- Initial project setup.
- Basic folder structure.
- Localization (Arabic/English).
- Theme configuration.
