// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HASAD';

  @override
  String get login => 'Login';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get farmers => 'Farmers';

  @override
  String get farms => 'Farms';

  @override
  String get damageReports => 'Damage Reports';

  @override
  String get map => 'Map';

  @override
  String get settings => 'Settings';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Please enter your email.';

  @override
  String get emailInvalid => 'Please enter a valid email address.';

  @override
  String get passwordRequired => 'Please enter your password.';

  @override
  String get loginFailed =>
      'Login failed. Please check your credentials and try again.';

  @override
  String get logout => 'Logout';

  @override
  String welcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get welcomeToHasad => 'Welcome to HASAD';

  @override
  String get pleaseSignIn => 'Please Sign In';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get usernameOrEmail => 'Username or Email';

  @override
  String get addFarmer => 'Add Farmer';

  @override
  String get editFarmer => 'Edit Farmer';

  @override
  String get farmerName => 'Farmer Name';

  @override
  String get nationalId => 'National ID';

  @override
  String get jerusalemId => 'Jerusalem ID';

  @override
  String get passport => 'Passport';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get address => 'Address';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmDelete => 'Are you sure you want to delete this farmer?';

  @override
  String get noFarmers => 'No farmers found.';

  @override
  String get errorLoadingFarmers => 'Failed to load farmers.';

  @override
  String get retry => 'Retry';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get searchFarmer => 'Search Farmer';

  @override
  String get search => 'Search';

  @override
  String get farmerDetails => 'Farmer Details';

  @override
  String get identitySection => 'Identity';

  @override
  String get idType => 'ID Type';

  @override
  String get idNumber => 'ID Number';

  @override
  String get arabicNameSection => 'Arabic Name';

  @override
  String get englishNameSection => 'English Name';

  @override
  String get firstName => 'First Name';

  @override
  String get secondName => 'Second Name';

  @override
  String get thirdName => 'Third Name';

  @override
  String get fourthName => 'Fourth Name';

  @override
  String get demographicsSection => 'Demographics';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get gender => 'Gender';

  @override
  String get familySize => 'Family Size';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get locationSection => 'Location';

  @override
  String get village => 'Locality/Village';

  @override
  String get auditSection => 'Audit Info';

  @override
  String get createdAt => 'Created At';

  @override
  String get updatedAt => 'Updated At';

  @override
  String get syncStatus => 'Sync Status';

  @override
  String get synced => 'Synced';

  @override
  String get pendingSync => 'Pending Sync';

  @override
  String get syncError => 'Sync Error';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get unspecified => 'Unspecified';

  @override
  String get selectDate => 'Select Date';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get invalidFamilySize => 'Invalid family size';

  @override
  String get invalidPalestinianId => 'Invalid Palestinian ID';

  @override
  String get mustBeNumeric => 'Must be numeric only';

  @override
  String get mustBeAlphanumeric => 'Must be alphanumeric only';

  @override
  String get mustBe18 => 'Farmer must be at least 18 years old';

  @override
  String get cannotBeInFuture => 'Date cannot be in the future';

  @override
  String get selectIdType => 'Select ID Type';

  @override
  String get farmerUpdatedSuccessfully => 'Farmer updated successfully';

  @override
  String get farmerCreatedSuccessfully => 'Farmer created successfully';

  @override
  String get enterFarmerIdToContinue => 'Enter Farmer ID to continue';

  @override
  String get addFarm => 'Add Farm';

  @override
  String get editFarm => 'Edit Farm';

  @override
  String get farmName => 'Farm Name';

  @override
  String get governorate => 'Governorate';

  @override
  String get locality => 'Locality';

  @override
  String get landArea => 'Land Area';

  @override
  String get unit => 'Unit';

  @override
  String get ownershipType => 'Ownership Type';

  @override
  String get noFarms => 'No farms found.';

  @override
  String get errorLoadingFarms => 'Failed to load farms.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get emailSent => 'A reset link has been sent to your email.';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get enterEmailToReset =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get compensation => 'Compensation';

  @override
  String get calculatedAmount => 'Calculated Amount';

  @override
  String get approvedAmount => 'Approved Amount';

  @override
  String get remarks => 'Remarks';

  @override
  String get status => 'Status';

  @override
  String get calculateCompensation => 'Calculate Compensation';

  @override
  String get approve => 'Approve';

  @override
  String get paid => 'Paid';

  @override
  String get noCompensation => 'No compensation calculated yet.';

  @override
  String get userManagement => 'User Management';

  @override
  String get users => 'Users';

  @override
  String get addUser => 'Add User';

  @override
  String get fullName => 'Full Name';

  @override
  String get username => 'Username';

  @override
  String get role => 'Role';

  @override
  String get directorate => 'Directorate';

  @override
  String get active => 'Active';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get userCreatedSuccessfully => 'User created successfully.';

  @override
  String get errorCreatingUser => 'Failed to create user.';

  @override
  String get noUsers => 'There are no users.';
}
