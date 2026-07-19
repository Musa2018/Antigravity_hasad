# Walkthrough — User Scope Classification (3-Level Architecture)

I have implemented the three-level geographic scope validation for user creation in the backend. This architecture replaces hardcoded role checks with a centralized, scalable registry that defines the geographic requirements for each role.

## Changes Made

### Domain Layer
- [RoleScopeType.cs](file:///hasad/backend/Hasad.Domain/Enums/RoleScopeType.cs): Defined a new enum for the three scope levels: `Global`, `Governorate`, and `Directorate`.
- [AppRoles.cs](file:///hasad/backend/Hasad.Domain/Constants/AppRoles.cs): Created a centralized role registry that maps each role to its corresponding `RoleScopeType`.
  - **Global**: `SuperAdmin`, `Administrator`, `Finance`, `ReadOnly`, `Farmer`.
  - **Governorate**: `Director`.
  - **Directorate**: `AgriculturalEngineer`, `FieldSurveyor`.

### Application Layer
- [CreateUserCommand.cs](file:///hasad/backend/Hasad.Application/Features/Users/Commands/CreateUser/CreateUserCommand.cs): Updated the `Handle` method to use `AppRoles.GetScopeType` for validation.
  - **Global**: No geographic assignment required.
  - **Governorate**: `GovernorateId` required, `DirectorateId` optional.
  - **Directorate**: Both `GovernorateId` and `DirectorateId` required.
  - Ownership validation: If `DirectorateId` is provided, it must belong to the selected `GovernorateId`.

### Infrastructure Layer
- [DbInitializer.cs](file:///hasad/backend/Hasad.Infrastructure/Persistence/Seed/DbInitializer.cs): Updated the role seeding logic to use the centralized `AppRoles.All()` list.

### Tests
- [CreateUserTests.cs](file:///hasad/backend/Hasad.Application.Tests/CreateUserTests.cs): Added 4 new unit tests covering each scope level and the ownership validation.
- [DbInitializerTests.cs](file:///hasad/backend/Hasad.Application.Tests/DbInitializerTests.cs): Updated to support the expanded list of roles (8 roles total).

## Verification Results

### Automated Tests
Ran all 68 backend application tests. All tests passed.
```text
Test summary: total: 68, failed: 0, succeeded: 68, skipped: 0, duration: 5.5s
Build succeeded with 3 warning(s) in 8.5s
```

### Build Result
The backend API project builds successfully without errors.
```text
Build succeeded with 2 warning(s) in 4.4s
```

## GitHub Integration
- **Commit Hash**: `3efe53f`
- **Branch**: `main`
- **Push Verification**: Success.
