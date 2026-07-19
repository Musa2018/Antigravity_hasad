# ADR 0008: Pin MediatR to 12.5.0 (Apache-2.0)

- Status: Accepted (approved by project owner, Sprint 1)
- Date: 2026-07-06

## Context

MediatR versions 13+ are distributed under a commercial license (Lucky Penny LLC).
The project used MediatR 14.2.0, creating licensing uncertainty for production use.
Three options were evaluated: (A) keep 14.2.0 under the commercial license,
(B) pin to 12.5.0, the last Apache-2.0 release, (C) replace MediatR with an
internal dispatcher.

## Decision

Option B: pin MediatR to **12.5.0**, the last version published under Apache-2.0.

The codebase uses only `IRequest`/`IRequestHandler`, `AddMediatR` with
`RegisterServicesFromAssembly`, and `IPipelineBehavior` — all fully supported in
12.x, so the downgrade required no code changes.

## Consequences

- No licensing cost or uncertainty; Apache-2.0 is compatible with the project.
- No new MediatR 13+/14+ features may be used; 12.5.0 receives no new feature work.
- If future needs outgrow 12.5.0, Option C (internal dispatcher) is the planned
  path and requires a superseding ADR.
