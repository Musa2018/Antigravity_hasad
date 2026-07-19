# ADR-0002: Authentication Strategy

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0

## Context
The API must authenticate mobile and web clients securely, resist brute-force
and credential-stuffing attacks, and avoid leaking account information.

## Decision
- **ASP.NET Core Identity** manages users, roles, and password hashing.
- **Password policy**: minimum 12 characters, uppercase, lowercase, digit, and
  non-alphanumeric character required.
- **Lockout**: enabled for all users; 5 failed attempts lock the account for
  15 minutes.
- **Generic 401 semantics**: unknown email, wrong password, and locked-out
  accounts all return `401 Unauthorized` with the same generic message to
  prevent account enumeration.
- **Rate limiting**: auth endpoints (`login`, `refresh`, `logout`) use a
  fixed-window rate limiter of 10 requests/minute per client IP, returning
  `429 Too Many Requests` when exceeded.
- **Seed admin**: the initial administrator is created only when
  `SeedAdmin:Email` and `SeedAdmin:Password` are configured; no hardcoded
  default credentials exist in code or configuration files.

## Consequences
- Brute-force attempts are throttled at two layers (rate limiter + lockout).
- Fresh deployments must explicitly configure the seed admin.
- Legitimate users mistyping a password 5 times wait 15 minutes (accepted).
