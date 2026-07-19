# Implementation Plan — Sprint 10.6 — Farmer Business Rules & Validation

Implement centralized business validation for Farmers across Backend and Flutter, focusing on ID correctness, age requirements, and duplicate prevention.

## User Review Required

> [!IMPORTANT]
> The Palestinian ID checksum logic (Modulus-10) will be applied strictly. Existing invalid IDs in the database (if any) might cause issues during updates if not handled, but for this sprint, we assume data integrity for new/updated records.

## Proposed Changes

### [Backend] Farmer Validation Logic

#### [NEW] [FarmerValidationHelpers.cs](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/backend/Hasad.Application/Features/Farmers/Commands/FarmerValidationHelpers.cs)
- Implement `IsValidPalestinianId(string id)` with Modulus-10 checksum.
- Implement `CalculateAge(DateOnly birthDate)` and `IsAtLeast18(DateOnly birthDate)`.

#### [MODIFY] [CreateFarmerCommand.cs](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/backend/Hasad.Application/Features/Farmers/Commands/CreateFarmer/CreateFarmerCommand.cs)
- Update `CreateFarmerCommandValidator` to:
    - Validate `IdNumber` based on `IdTypeId`:
        - Type 1 (Palestinian ID): 9 digits, numeric, checksum.
        - Type 2 (Jerusalem ID): Numeric only.
        - Type 3 (Passport): Alphanumeric.
    - Validate `BirthDate`: Must be at least 18 years ago and not in the future.

#### [MODIFY] [UpdateFarmerCommand.cs](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/backend/Hasad.Application/Features/Farmers/Commands/UpdateFarmer/UpdateFarmerCommand.cs)
- Apply the same validation rules as `CreateFarmerCommandValidator`.

---

### [Flutter] Farmer Validation Logic

#### [NEW] [validators.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/core/utils/validators.dart)
- Implement `isValidPalestinianId(String id)`.
- Implement `isAtLeast18(DateTime birthDate)`.
- Generic validators for required fields, numeric, alphanumeric.

#### [MODIFY] [farmer_form_screen.dart](file:///C:/Users/musa_/StudioProjects/Jules_HASAD/hasad/mobile/lib/features/farmers/presentation/farmer_form_screen.dart)
- Integrate new validators into `TextFormField` validation logic.
- Dynamically change `IdNumber` validation based on selected `IdTypeId`.
- Ensure Age validation is checked before submission.

## Verification Plan

### Automated Tests
- **Backend**:
    - Run `dotnet test` filtered to `CreateFarmerCommandValidatorTests` and `UpdateFarmerCommandValidatorTests` (if they exist) or create a new test file for validation logic.
- **Flutter**:
    - Run `flutter analyze` to ensure no regressions.
    - Run relevant widget tests if available.

### Manual Verification
- Test Farmer creation/edit with:
    - Valid/Invalid Palestinian IDs.
    - Numeric Jerusalem IDs.
    - Alphanumeric Passports.
    - Birth dates making the farmer < 18 or > 18 years old.
    - Duplicate ID Number + Type combinations.
