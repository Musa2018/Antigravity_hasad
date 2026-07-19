# Sprint 10.4 — Farmers Search First Workflow Plan

Implement the "Search First" workflow for the Farmers module. This ensures that users search for a farmer by ID number locally and remotely before creating a new record, maintaining data integrity and reducing duplicates.

## User Review Required

> [!IMPORTANT]
> - A new `FarmerSearchScreen` will be created as the primary entry point for looking up farmers.
> - A placeholder `FarmerDetailsScreen` will be added to support navigation after a successful search.
> - The backend API already supports `IdNumber` search, so no backend changes are needed.

## Proposed Changes

### Data Layer (Repository)

#### [MODIFY] [farmer_repository.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/data/farmer_repository.dart)
- Add `Future<domain.Farmer?> findByIdNumber(String idNumber)` to `FarmerRepository`.
- Implement in `OfflineFirstFarmerRepository`:
    1. Search local Drift database.
    2. If not found and online (using connectivity check), call remote search.
    3. If found remotely, save to local Drift database.
    4. Return the farmer or null.

#### [MODIFY] [remote_farmer_repository.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/data/remote_farmer_repository.dart)
- Update `getFarmers` to accept an optional `idNumber` parameter and pass it to the API.

---

### Presentation Layer

#### [MODIFY] [farmers_providers.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/presentation/farmers_providers.dart)
- Implement `FarmerSearchNotifier` and `farmerSearchProvider`.
- Expose search logic and state (Idle, Searching, Found, NotFound, Error).

#### [NEW] [farmer_search_screen.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/presentation/farmer_search_screen.dart)
- Simple UI with an `idNumber` text field and search button.
- Handles navigation based on search results:
    - **Found**: Navigate to `FarmerDetailsScreen`.
    - **Not Found**: Navigate to `FarmerFormScreen` with prefilled ID.

#### [NEW] [farmer_details_screen.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/presentation/farmer_details_screen.dart)
- Placeholder screen showing basic farmer info and navigation to farms/history.

---

### Navigation

#### [MODIFY] [app_router.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/core/router/app_router.dart)
- Add `AppRoutes.farmerSearch` route.
- Add `AppRoutes.farmerDetails` route.
- Configure `GoRouter` to include these new screens.

---

### Verification Plan

#### Automated Tests
- Create `test/farmers/search_workflow_test.dart` to verify:
    - Local search success.
    - Remote fallback success.
    - Offline behavior (skipping remote search).
- Run `flutter analyze`.

#### Manual Verification
- Open Farmers module.
- Search for an existing local ID.
- Search for an ID that exists only on the server.
- Search for a non-existent ID and verify prefill in the form.
