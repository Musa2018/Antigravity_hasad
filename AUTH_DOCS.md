# HASAD - Authentication Documentation

## Overview
Secure authentication system supporting offline access via cached credentials.

## Backend Logic
- **Identity**: ASP.NET Core Identity with PostgreSQL.
  - Password policy: minimum 12 characters, uppercase, lowercase, digit, and symbol required.
  - Lockout: 5 failed attempts lock the account for 15 minutes.
- **JWT**: JSON Web Tokens for API authorization.
  - Issuer and audience are validated (`JwtSettings:Issuer` / `JwtSettings:Audience`).
  - Access tokens expire after `JwtSettings:AccessTokenMinutes` (default 60).
  - The signing key is provided only via environment variables or user secrets
    (`JwtSettings__Key`), never committed to the repository; startup fails fast
    if it is missing or shorter than 32 characters.
- **Refresh Tokens**: persisted, rotated, and revocable.
  - Only a SHA-256 hash of each token is stored (`RefreshTokens` table).
  - Lifetime: `JwtSettings:RefreshTokenDays` (default 14 days).
  - `POST /api/v1/accounts/refresh` rotates the token: the presented token is
    revoked and a new access/refresh pair is issued.
  - Reuse of an already-rotated token revokes the entire token family
    (all descendants of the original login).
  - `POST /api/v1/accounts/logout` revokes the presented token and its family.
- **Login hardening**:
  - Invalid credentials, lockout, and invalid refresh tokens all return `401`
    with a generic message (no account enumeration).
  - Auth endpoints are rate limited (10 requests/minute per client IP → `429`).
- **Seed admin**: created at startup only when both `SeedAdmin__Email` and
  `SeedAdmin__Password` are configured; there are no hardcoded default
  credentials.
- **Roles**: SuperAdmin, Administrator, AgriculturalEngineer, FieldSurveyor, Farmer, ReadOnly.

## API Endpoints
| Endpoint | Method | Description |
|---|---|---|
| `/api/v1/accounts/login` | POST | Email + password → access token + refresh token |
| `/api/v1/accounts/refresh` | POST | Refresh token → new access + refresh pair (rotation) |
| `/api/v1/accounts/logout` | POST | Revokes the refresh token and its family |

## Mobile Logic
- **Secure Storage**: `flutter_secure_storage` for tokens and sensitive data.
- **Auto-Login**: Application checks for valid local tokens on startup.
- **Biometrics**: Architecture supports biometric unlock (FaceID/Fingerprint).

See also: [ADR-0002 Authentication Strategy](docs/adr/0002-authentication-strategy.md)
and [ADR-0003 JWT & Refresh Token Design](docs/adr/0003-jwt-and-refresh-token-design.md).
