# ADR-0001: Clean Architecture

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0

## Context
HASAD spans a .NET backend and a Flutter mobile client. The codebase must stay
maintainable as features grow, and business rules must be testable in isolation
from frameworks and infrastructure.

## Decision
The backend follows Clean Architecture with four projects:

- **Hasad.Domain** — entities and identity types; no external dependencies.
- **Hasad.Application** — use cases (MediatR commands/queries), interfaces
  (`ITokenService`, `IRefreshTokenStore`), options, and validation. Depends
  only on Domain.
- **Hasad.Infrastructure** — EF Core persistence, Identity stores, and service
  implementations. Depends on Application and Domain.
- **Hasad.Api** — controllers, DI composition root, middleware, configuration.

Dependency rule: source dependencies point inward only. Infrastructure details
(EF Core, JWT libraries) never leak into Application or Domain signatures.

## Consequences
- Application-layer handlers are unit-testable with mocked interfaces.
- Swapping infrastructure (e.g., database provider) does not touch use cases.
- Slight ceremony cost: new features require touching multiple projects.
