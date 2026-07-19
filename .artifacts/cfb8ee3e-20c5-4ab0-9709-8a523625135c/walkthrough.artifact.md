# Sprint 10.4 — Farmers Search First Workflow Walkthrough

I have implemented the **Search First** workflow for the Farmers module. This workflow ensures that before a new farmer is created, a mandatory search is performed both locally (Drift database) and remotely (Backend API) to prevent duplicate records and ensure data consistency.

## Changes Made

### 1. Data Layer (Repository)
- **Repository Interface**: Added `findByIdNumber(String idNumber)` to `FarmerRepository`.
- **Remote Implementation**: Updated `RemoteFarmerRepository.getFarmers` to support `idNumber` query parameters and implemented `findByIdNumber`.
- **Offline-First Implementation**: Enhanced `OfflineFirstFarmerRepository.findByIdNumber` with the following logic:
    1. Search local Drift database.
    2. If not found locally, check connectivity.
    3. If online, search the backend API.
    4. If found remotely, automatically save/update the local Drift database to ensure the record is available offline.

### 2. State Management (Riverpod)
- **Farmer Search Notifier**: Created `FarmerSearchNotifier` to manage the search lifecycle (Idle, Searching, Found, NotFound, Error).
- **Provider**: Exposed the notifier via `farmerSearchProvider`.

### 3. UI and Navigation
- **Search Gateway**: Created `FarmerSearchScreen` as the new entry point for adding/viewing farmers.
- **Details Placeholder**: Created `FarmerDetailsScreen` to show farmer information after a successful search.
- **Routing**:
    - Updated `AppRoutes` and `GoRouter` configuration.
    - Updated `FarmersListScreen` FAB to point to the search gateway.
    - Updated `FarmerFormScreen` to support pre-filling the ID number from the search result.

### 4. Localization
- Added required keys to `app_en.arb` and `app_ar.arb` for the new search and details screens.

## Verification Results

### Automated Tests
- **Repository Tests**: Verified local search success and remote fallback logic.
- **Connectivity Tests**: Verified that remote search is skipped when the device is offline.
- **Navigation Tests**: Verified correct routing to Details (if found) or Form (if not found).
- **Result**: All tests passed. Command: `flutter test test/farmers/search_workflow_test.dart`

### Analyze Result
- **Success**: No issues found. Command: `flutter analyze`

## Remaining Work
- Implement full UI for `FarmerDetailsScreen` (currently a placeholder).
- Update `FarmerFormScreen` UI to support the full 8-part name fields and new demographic data.
- Implement advanced Palestinian ID checksum validation.
