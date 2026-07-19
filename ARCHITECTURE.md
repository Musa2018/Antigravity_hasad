# HASAD - Architecture Documentation

## Overview
HASAD follows a **Clean Architecture** approach combined with a **Feature-First** structure to ensure scalability, maintainability, and offline-first capabilities.

## Mobile (Flutter)
- **Presentation Layer**: Riverpod for state management, GoRouter for navigation.
- **Domain Layer**: Entities and Repository interfaces.
- **Data Layer**: Repository implementations, Data sources (Dio for API, Drift for SQLite).
- **Core**: Cross-cutting concerns like synchronization, secure storage, and networking.

## Backend (.NET 8)
- **Web API**: Controllers and Middleware.
- **Application**: CQRS patterns using MediatR, FluentValidation.
- **Domain**: Core entities and business rules.
- **Infrastructure**: Persistence (EF Core, PostgreSQL), Identity, and External Services.

## Offline First Strategy
- **Local First**: Data is saved to SQLite via Drift first. Every record has a client-generated UUID for backend idempotency.
- **Sync Queue**: Operations are queued in a persistent local table and processed by `BackgroundSyncService` when connectivity is detected, using an exponential backoff retry policy.
- **Conflict Resolution**: **Optimistic Concurrency** via `RowVersion` tokens. The server returns `409 Conflict` if the record has been modified by another user. Default resolution is **Server Wins**, where the sync engine fetches remote authority data to resolve the local conflict.

## Folder Structure (Mobile)
- `lib/core`: Cross-cutting logic (Networking, Storage, Config).
- `lib/features`: Domain-driven feature modules.
  - `auth`: Authentication logic.
  - `dashboard`: Main user interface and statistics.
  - `farmers`: Farmer management.
  - `farms`: Farm management.
  - `damage_reports`: Report creation and viewing.
  - `map`: GIS features.
  - `admin`: User management and administrative tools.
- `lib/shared`: Reusable UI components and models.

## User Scope & Regional Isolation
Users are categorized into three scope levels which define their data access and operational boundaries:
1. **Global**: Access to system-wide data (e.g., SuperAdmin, Finance). No geographic assignment required.
2. **Governorate**: Tied to a specific Governorate. Can access all data within that governorate.
3. **Directorate**: Tied to a specific Directorate within a Governorate. Restricted to local data entry and assessment.

These rules are enforced in the Backend via `RoleScopeType` validation and in the Flutter app via dynamic UI forms and regional filtering.
