# HASAD Project Status

> Living document — updated at the end of every sprint.

- **Current Version**: v0.7.0-alpha (User Management + Regional Scoping)
- **Current Sprint**: Sprint 9 — Compensation Workflow (in progress)
- **Current Branch**: `main`
- **Last Updated**: 2026-07-15

## Sprint 9.1 — IN PROGRESS
Implemented User Management and Regional Scoping:
- **Backend Core**: New `AppRoles` registry and `RoleScopeType` enum (Global, Governorate, Directorate) for multi-level geographic validation.
- **Security**: Hardened `CreateUserCommand` with 3-level scope validation and safe DTO exposure (no sensitive fields).
- **Mobile Admin**: New `admin` feature module with `UsersScreen` and `CreateUserScreen`.
- **Dynamic UI**: User creation form adapts automatically to selected roles, enforcing mandatory geographic assignments (e.g., Engineer requires Directorate).
- **Session Scoping**: `AuthSession` extended to include `userId`, `governorateId`, and `directorateId`, enabling offline-ready regional isolation.
- **Localization**: Full Arabic/English support for all new administrative interfaces.
- Tests: Added 20+ unit/widget tests for user management logic and security.

## Sprint 8 — COMPLETED
Implemented Evidence & Attachment Management module:
- **Attachment Domain**: New `DamageReportAttachment` entity with support for
  local/remote paths, file metadata, and upload status.
- **Storage Abstraction**: `IFileStorageService` implemented with local disk
  storage as a default, ready for Azure/S3 transition.
- **Backend API**: `UploadAttachmentCommand` (idempotent) and endpoints for
  managing multi-part file uploads within damage reports.
- **Mobile Persistence**: Drift schema upgraded to **v6** to support attachment
  metadata and background upload status.
- **Upload Engine**: Extended `BackgroundSyncService` to handle binary file
  uploads with existing retry and backoff logic.
- **UI/UX**: `AttachmentGalleryScreen` for capturing (camera) and managing
  damage evidence photos.
- Tests: Verified with 45 backend and 44 mobile tests.

## Sprint 7 — COMPLETED
Implemented Farm Management module with offline-first support:
- **Farm Domain**: New `Farm` entity with `ClientId`, `FarmerId`, and optimistic
  concurrency (`RowVersion`).
- **Backend API**: Full CRUD support with `FarmsController` and RBAC.
  Idempotent creation and versioned updates.
- **Mobile Persistence**: Drift schema v4 adding `Farms` table with migration
  strategy.
- **Sync Integration**: `BackgroundSyncService` updated to support `Farm`
  entity with automatic background synchronization and conflict resolution.
- **UI/UX**: `FarmsListScreen` and `FarmFormScreen` with RTL (Arabic) support,
  localized validation, and integration into existing navigation flow.
- Tests: Added backend unit tests and mobile widget tests for Farm features.

## Sprint 5 — COMPLETED
Complete synchronization robustness and infrastructure hardening:
- **Backend Idempotency**: `Farmer` entity updated with `ClientId` (unique index);
  `CreateFarmerCommand` implements check-and-create logic to prevent duplicates.
- **Optimistic Concurrency**: `RowVersion` added to `Farmer` for conflict
  detection; `UpdateFarmerCommand` returns `409 Conflict` on version mismatch.
- **Drift Migrations**: Mobile schema upgraded to v3; implemented `onUpgrade`
  strategy for `rowVersion` and `lastAttemptAt` columns.
- **Sync Engine**: `BackgroundSyncService` enhanced with retry backoff policy
  (1, 5, 15 min), detailed status tracking (Pending, Syncing, Completed,
  Failed, Conflict), and "Server Wins" resolution for 409 errors.
- Tests: Added backend tests for idempotency/concurrency and mobile unit
  tests for conflict resolution.
- Delivered via direct implementation and verification.

## Sprint 4 — COMPLETED
Complete production-ready authentication subsystem delivered and merged
(PR #31, tag `sprint-0`, GitHub Release published): secure configuration,
JWT hardening (issuer/audience, 1h tokens, externalized key), persisted
refresh tokens with rotation and family revocation, login hardening
(401 semantics, rate limiting, lockout), configurable seed admin.
Verification: unit tests, full auth E2E, both CI workflows green on the PR
and on `main` post-merge. Milestone closed (5/5 issues).

## Sprint 1 — COMPLETED
- MediatR pinned to 12.5.0 (Apache-2.0) per approved Option B (ADR 0008).
- C7 (#17): InMemory-safe database initialization with explicit
  migration/seeding logging and fail-fast error reporting.
- H1 (#18): migration history squashed into a single verified `InitialCreate`.
- H3 (#20): FluentValidation pipeline behavior + Login/Refresh/Logout
  validators; validation failures return `400` with error details.
- M2 (#25): ITokenService extraction verified complete (delivered in Sprint 0).
- Tests: 25 backend unit tests (11 added this sprint).
- Delivered via PR #33, tag `sprint-1`, GitHub Release published.

## Sprint 2 — COMPLETED
- C6 (#16): fail-fast `EnvironmentConfig` initialized in `main()` before
  `runApp()`; login-time crash eliminated.
- M1 (#24): LoginScreen rewritten — proper controller lifecycle, client-side
  validation, localized (en/ar) errors, loading state.
- M3 (#26): logout with server-side revocation, single-flight token refresh
  with rotation, transparent 401 retry via `AuthInterceptor`, session
  restoration on app start. (Drift sync-queue remains a post-remediation
  epic per the issue.)
- L3 (#30): auth-guarded GoRouter with `/login`, `/home`, splash, and
  auth-state-driven redirects.
- Tests: 22 mobile unit/widget tests + opt-in live E2E auth lifecycle test.
- Delivered via PR #34 (tag `sprint-2`, Release published) plus follow-up
  PR #35 hardening auth error handling against malformed backend payloads
  (fixes both post-merge review findings). First alpha tagged: `v0.3.0-alpha`.

## Sprint 3 — Testing & Code Coverage (this sprint)
- #19: expanded `Hasad.Application.Tests` — LogoutCommandHandler tests and
  DbInitializer seeding tests (roles idempotency, SuperAdmin creation/skip,
  password-policy failure); 31 backend tests total (6 added this sprint).
- #29: Flutter widget-test suite expanded — LoginScreen loading state and
  Arabic/RTL rendering + localized validation, HomeScreen (welcome, logout,
  RTL), and router auth-guard tests (splash hold, login redirect, session
  restoration to home, login navigation, logout return); 38 mobile tests
  total (11 added this sprint).
- No production code changes; tests only.

## Sprint 4 — CI/CD Hardening (this sprint)
- #22: CI hardening — `actions/checkout@v4` and `actions/setup-dotnet@v4`/
  `actions/setup-dotnet` caching; .NET SDK pinned to `8.0.422` (also via new
  `hasad/backend/global.json`); Flutter pinned to `3.41.2` (matches the
  project's `.metadata`, replacing the floating `3.x`); concurrency
  cancellation on both workflows; `dotnet format --verify-no-changes` gate
  added; coverage published as build artifacts (Cobertura for backend, LCOV
  for mobile); backend build uses `-p:ContinuousIntegrationBuild=true` for
  deterministic output.
- #23: `hasad/backend/docker-compose.yml` — `postgres:alpine` pinned to
  `postgres:16-alpine`, obsolete `version` key removed, `pg_isready`
  healthcheck and a named volume added.
- No application code, business logic, API, or architecture changes.
- Validated locally end-to-end (SDK 8.0.422 / Flutter 3.41.2, installed
  fresh in the build sandbox): `dotnet restore/format/build/test` (31/31
  passing) and `flutter pub get`/`dart format`/`flutter analyze`/
  `flutter test --coverage` (38/38 passing) and `flutter build web`
  (informational only, not added to CI) all green.

## Open Issues (remediation backlog)
- Sprint 5 (Repository Cleanup): #21, #28
- Sprint 6 (Documentation Sync): #27

## Completed Issues
- Sprint 0: #11, #12, #13, #14, #15 — closed via PR #31.
- Sprint 1: #17, #18, #20, #25 — closed via PR #33.
- Sprint 2: #16, #24, #26, #30 — closed via PR #34 (+ hardening PR #35).
- Sprint 3: #19, #29 — closing via this sprint's PR.
- Sprint 4: #22, #23 — closing via this sprint's PR.

## Current Risks
- Sessions issued before the JWT key rotation are invalidated (expected; users
  must log in again).
- Rate limiting is per-instance in-memory; multi-instance deployments need a
  distributed limiter (tracked for the production roadmap).

## Technical Debt
- No backend integration-test project yet (unit + live E2E coverage only;
  a dedicated WebApplicationFactory-based suite remains future work).
- Drift sync-queue (offline persistence) implemented with v3 schema and background sync service.
- Junk files (`Class1.cs`, `build_output.txt`) outstanding (Sprint 5).

## CI Status
- Green: .NET CI and Flutter CI on `main` and on the Sprint 4 branch (hardened workflows: pinned toolchains, format gates, coverage artifacts, concurrency cancellation).

## Next Sprint
- Sprint 5 — Repository Cleanup (requires explicit user approval).
