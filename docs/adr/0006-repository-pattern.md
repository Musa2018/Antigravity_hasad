# ADR-0006: Repository Pattern & Data Access

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0

## Context
Application-layer use cases need persistence without depending on EF Core, and
tests need to substitute data access easily.

## Decision
- Data access is abstracted behind interfaces defined in **Hasad.Application**
  (e.g., `IRefreshTokenStore`) and implemented in **Hasad.Infrastructure**
  against `ApplicationDbContext`.
- Store/repository interfaces are **intent-based** (issue / rotate / revoke)
  rather than generic CRUD, keeping invariants (hash-only storage, family
  revocation) inside the implementation.
- EF Core `DbContext` is never injected into Application-layer handlers.
- Identity data access continues to use ASP.NET Core Identity's
  `UserManager`/`RoleManager` abstractions rather than a bespoke repository.

## Consequences
- Handlers are tested with `NSubstitute` mocks; store implementations are
  tested against the EF in-memory provider.
- Some duplication versus a generic repository, in exchange for clear
  invariants and simpler mocking.
