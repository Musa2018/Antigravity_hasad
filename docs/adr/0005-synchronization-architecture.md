# ADR-0005: Synchronization Architecture

- **Status**: Accepted
- **Date**: 2026-07-06
- **Sprint**: 0 (documented; implementation post-remediation)

## Context
Offline-created records (ADR-0004) must eventually reach the backend without
data loss or duplication, and server-side changes must reach devices.

## Decision
- **Push**: a sync queue drains pending local records to the API in creation
  order. Client-generated UUIDs make uploads idempotent; the server upserts by
  UUID.
- **Pull**: incremental fetch using a per-entity `lastSyncedAtUtc` watermark.
- **Conflict policy**: last-writer-wins on a per-field timestamp basis for the
  initial version; conflicting records are flagged for manual review rather
  than silently discarded.
- **Versioning**: the sync protocol is versioned independently of the API
  version so mobile clients can detect incompatible backends and degrade
  gracefully (compatibility handshake defined in Engineering Plan v3 Part II).

## Consequences
- No core data is lost when connectivity drops mid-sync (queue persists).
- Manual-review flagging requires a small admin surface later.
- Sync protocol changes require a version bump and compatibility notes.
