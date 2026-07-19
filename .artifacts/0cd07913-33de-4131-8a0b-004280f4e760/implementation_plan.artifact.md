# Implementation Plan - Geographic Lookup Bug Fix

This plan addresses the non-functional Governorate and Directorate dropdowns in the Create User screen by providing the official Palestinian geographic dataset and hardening the Flutter UI.

## User Review Required

> [!IMPORTANT]
> This plan includes the complete official dataset for 16 Palestinian Governorates and their associated Directorates. The seeding logic is idempotent to prevent duplicates or overwriting production data.

## Proposed Changes

### [Component] Backend - Data Seeding

#### [MODIFY] [DbInitializer.cs](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/backend/Hasad.Infrastructure/Persistence/Seed/DbInitializer.cs)
- Implement `SeedGeographicsAsync(ApplicationDbContext context)`:
    - Define all 16 Governorates: Jenin, Tubas, Tulkarm, Nablus, Qalqilya, Salfit, Ramallah, Jericho, Jerusalem, Bethlehem, Hebron, North Gaza, Gaza, Deir al-Balah, Khan Yunis, Rafah.
    - Define official Directorates for each Governorate.
    - Use `Guid.Parse` with stable IDs or lookup by Code/Name to ensure idempotency.
    - Check `context.Governorates.Any()` or specific IDs before inserting.

#### [MODIFY] [Program.cs](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/backend/Hasad.Api/Program.cs)
- Call `await DbInitializer.SeedGeographicsAsync(context);` during startup.

---

### [Component] Flutter - UI Hardening

#### [MODIFY] [create_user_screen.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/admin/presentation/create_user_screen.dart)
- **Type Safety**: Fix `directoratesAsync` initialization to `AsyncValue<List<Directorate>>.data([])`.
- **Loading State**: Show `LinearProgressIndicator` or "Loading..." text within dropdown labels if data is being fetched.
- **Error State**: Display a small error message if the lookup fails, and provide a retry mechanism if possible.
- **Empty State**: Show "No data available" if the list is empty.
- **Save Validation**: Disable the "Save" button if:
    - Data is currently loading.
    - Required geographic fields (based on role scope) are empty or in error state.

---

## Verification Plan

### Automated Tests
- **Backend**: Run `dotnet test` to verify `UserLookupTests` and `DbInitializerTests`.
- **Flutter**: Update `create_user_screen_test.dart` to include loading and error scenarios.

### Manual Verification
1. Log in as **SuperAdmin**.
2. Navigate to **User Management** -> **Add User**.
3. Select **Director** role.
4. Verify **Governorate** dropdown is populated with all 16 options.
5. Select **Hebron** and verify the **Directorate** dropdown updates with Hebron-specific options.
6. Attempt to save while data is loading and verify button is disabled.
7. Create a user and verify success.
