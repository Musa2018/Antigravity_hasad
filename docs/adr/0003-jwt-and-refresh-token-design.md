# ADR-0003: JWT & Refresh Token Design

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0

## Context
The previous implementation signed JWTs with a key committed to the repository,
disabled issuer/audience validation, used 7-day access tokens, and issued a
random GUID as a "refresh token" that was never persisted or validated.

## Decision
### Access tokens
- Signed with HMAC-SHA256 using a key supplied **only** via environment
  variables or user secrets (`JwtSettings__Key`, ≥ 32 chars, fail-fast at boot).
- Issuer and audience validation enabled (`JwtSettings:Issuer`/`:Audience`).
- Lifetime 60 minutes (`JwtSettings:AccessTokenMinutes`), zero clock skew.
- `RequireHttpsMetadata = true` outside Development.
- Token creation is encapsulated in `ITokenService` (implemented in
  Infrastructure) so handlers never touch JWT primitives.

### Refresh tokens
- 64 random bytes, Base64URL-encoded; only the SHA-256 hash is persisted in
  the `RefreshTokens` table (raw value returned to the client once).
- Lifetime 14 days (`JwtSettings:RefreshTokenDays`).
- **Rotation**: `/api/v1/accounts/refresh` revokes the presented token and
  issues a replacement within the same *token family* (`FamilyId` shared by
  all tokens descending from one login).
- **Reuse detection**: presenting an already-rotated or revoked token revokes
  the entire family, forcing re-authentication (stolen-token containment).
- **Revocation**: `/api/v1/accounts/logout` revokes the presented token's
  family.
- Persistence/rotation logic is encapsulated in `IRefreshTokenStore`.

## Consequences
- A leaked access token is valid for at most 1 hour.
- A stolen refresh token is neutralized as soon as either party uses the
  rotated-out token.
- The database gains one table; token validation adds one indexed lookup per
  refresh (acceptable).
- Existing sessions from before this change are invalidated (key rotation).
