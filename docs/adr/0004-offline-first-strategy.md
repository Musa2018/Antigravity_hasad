# ADR-0004: Offline-First Strategy

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0 (documented; mobile implementation lands in Sprint 2+)

## Context
HASAD field surveyors work in rural areas with unreliable connectivity. Core
workflows (farmer registration, surveys) must not depend on a live connection.

## Decision
- For core features, data **must** be written to the local database before any
  API call is attempted (local-write-first rule from AGENTS.md).
- Local persistence uses **Drift** (already declared in `pubspec.yaml`); the
  wiring of Drift tables/DAOs is scheduled for the Flutter stabilization
  sprint.
- Each locally created record carries a sync status
  (pending / synced / failed) and a client-generated UUID so retries are
  idempotent.
- Reads prefer local data; remote data refreshes the local store when
  available.

## Consequences
- The app remains usable with zero connectivity.
- Synchronization conflict handling is required (see ADR-0005).
- Local schema migrations must be managed alongside backend migrations.
