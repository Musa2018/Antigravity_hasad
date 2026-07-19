# HASAD - Synchronization Documentation

## Strategy
Offline-first synchronization with a background queue.

## Components
- **SyncQueue**: Local database table tracking pending changes.
- **SyncStatus**: Pending, Syncing, Completed, Failed.
- **BackgroundService**: Native-compatible background worker to push updates.

## Conflict Resolution
- Most reports use **Last-Write-Wins**.
- Ownership changes require **Manual Resolution**.
