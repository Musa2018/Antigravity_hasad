# Sprint 10.6 — Farmer Validation Task List

- [x] **Research & Setup**
    - [x] Verify branch `farmers`
    - [x] Identify location for backend helper methods
    - [x] Identify location for Flutter utility methods

- [x] **Backend Implementation**
    - [x] Create `FarmerValidationHelpers.cs`
    - [x] Implement Palestinian ID Modulus-10 checksum
    - [x] Implement Age >= 18 validation logic
    - [x] Update `CreateFarmerCommandValidator`
    - [x] Update `UpdateFarmerCommandValidator`
    - [x] Verify duplicate prevention logic in handlers

- [x] **Flutter Implementation**
    - [x] Create `lib/core/utils/validators.dart`
    - [x] Implement ID validation logic (checksum, numeric, alphanumeric)
    - [x] Implement Age validation logic
    - [x] Update `FarmerFormScreen` validation for `IdNumber`
    - [x] Update `FarmerFormScreen` validation for `BirthDate`

- [x] **Verification**
    - [x] Run backend validation tests
    - [x] Run `flutter analyze`
    - [x] Verify error messages in both Arabic and English

- [ ] **Cleanup & Git**
    - [ ] Commit changes to `farmers` branch
    - [ ] Push to remote
    - [ ] Generate final report
