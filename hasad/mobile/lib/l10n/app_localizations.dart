import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'HASAD'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @farmers.
  ///
  /// In en, this message translates to:
  /// **'Farmers'**
  String get farmers;

  /// No description provided for @farms.
  ///
  /// In en, this message translates to:
  /// **'Farms'**
  String get farms;

  /// No description provided for @damageReports.
  ///
  /// In en, this message translates to:
  /// **'Damage Reports'**
  String get damageReports;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for the email field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for the password field on the login screen
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Validation message when the email field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get emailRequired;

  /// Validation message when the email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get emailInvalid;

  /// Validation message when the password field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get passwordRequired;

  /// Generic error shown when a login attempt is rejected
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials and try again.'**
  String get loginFailed;

  /// Label for the logout action
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Greeting shown on the home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcome(String name);

  /// No description provided for @welcomeToHasad.
  ///
  /// In en, this message translates to:
  /// **'Welcome to HASAD'**
  String get welcomeToHasad;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'Please Sign In'**
  String get pleaseSignIn;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @usernameOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Username or Email'**
  String get usernameOrEmail;

  /// No description provided for @addFarmer.
  ///
  /// In en, this message translates to:
  /// **'Add Farmer'**
  String get addFarmer;

  /// No description provided for @editFarmer.
  ///
  /// In en, this message translates to:
  /// **'Edit Farmer'**
  String get editFarmer;

  /// No description provided for @farmerName.
  ///
  /// In en, this message translates to:
  /// **'Farmer Name'**
  String get farmerName;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @jerusalemId.
  ///
  /// In en, this message translates to:
  /// **'Jerusalem ID'**
  String get jerusalemId;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this farmer?'**
  String get confirmDelete;

  /// No description provided for @noFarmers.
  ///
  /// In en, this message translates to:
  /// **'No farmers found.'**
  String get noFarmers;

  /// No description provided for @errorLoadingFarmers.
  ///
  /// In en, this message translates to:
  /// **'Failed to load farmers.'**
  String get errorLoadingFarmers;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @searchFarmer.
  ///
  /// In en, this message translates to:
  /// **'Search Farmer'**
  String get searchFarmer;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @farmerDetails.
  ///
  /// In en, this message translates to:
  /// **'Farmer Details'**
  String get farmerDetails;

  /// No description provided for @identitySection.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get identitySection;

  /// No description provided for @idType.
  ///
  /// In en, this message translates to:
  /// **'ID Type'**
  String get idType;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get idNumber;

  /// No description provided for @arabicNameSection.
  ///
  /// In en, this message translates to:
  /// **'Arabic Name'**
  String get arabicNameSection;

  /// No description provided for @englishNameSection.
  ///
  /// In en, this message translates to:
  /// **'English Name'**
  String get englishNameSection;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @secondName.
  ///
  /// In en, this message translates to:
  /// **'Second Name'**
  String get secondName;

  /// No description provided for @thirdName.
  ///
  /// In en, this message translates to:
  /// **'Third Name'**
  String get thirdName;

  /// No description provided for @fourthName.
  ///
  /// In en, this message translates to:
  /// **'Fourth Name'**
  String get fourthName;

  /// No description provided for @demographicsSection.
  ///
  /// In en, this message translates to:
  /// **'Demographics'**
  String get demographicsSection;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @familySize.
  ///
  /// In en, this message translates to:
  /// **'Family Size'**
  String get familySize;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @locationSection.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationSection;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Locality/Village'**
  String get village;

  /// No description provided for @auditSection.
  ///
  /// In en, this message translates to:
  /// **'Audit Info'**
  String get auditSection;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get updatedAt;

  /// No description provided for @syncStatus.
  ///
  /// In en, this message translates to:
  /// **'Sync Status'**
  String get syncStatus;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @pendingSync.
  ///
  /// In en, this message translates to:
  /// **'Pending Sync'**
  String get pendingSync;

  /// No description provided for @syncError.
  ///
  /// In en, this message translates to:
  /// **'Sync Error'**
  String get syncError;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @unspecified.
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get unspecified;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// No description provided for @invalidFamilySize.
  ///
  /// In en, this message translates to:
  /// **'Invalid family size'**
  String get invalidFamilySize;

  /// No description provided for @invalidPalestinianId.
  ///
  /// In en, this message translates to:
  /// **'Invalid Palestinian ID'**
  String get invalidPalestinianId;

  /// No description provided for @mustBeNumeric.
  ///
  /// In en, this message translates to:
  /// **'Must be numeric only'**
  String get mustBeNumeric;

  /// No description provided for @mustBeAlphanumeric.
  ///
  /// In en, this message translates to:
  /// **'Must be alphanumeric only'**
  String get mustBeAlphanumeric;

  /// No description provided for @mustBe18.
  ///
  /// In en, this message translates to:
  /// **'Farmer must be at least 18 years old'**
  String get mustBe18;

  /// No description provided for @cannotBeInFuture.
  ///
  /// In en, this message translates to:
  /// **'Date cannot be in the future'**
  String get cannotBeInFuture;

  /// No description provided for @selectIdType.
  ///
  /// In en, this message translates to:
  /// **'Select ID Type'**
  String get selectIdType;

  /// No description provided for @farmerUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Farmer updated successfully'**
  String get farmerUpdatedSuccessfully;

  /// No description provided for @farmerCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Farmer created successfully'**
  String get farmerCreatedSuccessfully;

  /// No description provided for @enterFarmerIdToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter Farmer ID to continue'**
  String get enterFarmerIdToContinue;

  /// No description provided for @addFarm.
  ///
  /// In en, this message translates to:
  /// **'Add Farm'**
  String get addFarm;

  /// No description provided for @editFarm.
  ///
  /// In en, this message translates to:
  /// **'Edit Farm'**
  String get editFarm;

  /// No description provided for @farmName.
  ///
  /// In en, this message translates to:
  /// **'Farm Name'**
  String get farmName;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @locality.
  ///
  /// In en, this message translates to:
  /// **'Locality'**
  String get locality;

  /// No description provided for @landArea.
  ///
  /// In en, this message translates to:
  /// **'Land Area'**
  String get landArea;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @ownershipType.
  ///
  /// In en, this message translates to:
  /// **'Ownership Type'**
  String get ownershipType;

  /// No description provided for @noFarms.
  ///
  /// In en, this message translates to:
  /// **'No farms found.'**
  String get noFarms;

  /// No description provided for @errorLoadingFarms.
  ///
  /// In en, this message translates to:
  /// **'Failed to load farms.'**
  String get errorLoadingFarms;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'A reset link has been sent to your email.'**
  String get emailSent;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @enterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get enterEmailToReset;

  /// No description provided for @compensation.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get compensation;

  /// No description provided for @calculatedAmount.
  ///
  /// In en, this message translates to:
  /// **'Calculated Amount'**
  String get calculatedAmount;

  /// No description provided for @approvedAmount.
  ///
  /// In en, this message translates to:
  /// **'Approved Amount'**
  String get approvedAmount;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @calculateCompensation.
  ///
  /// In en, this message translates to:
  /// **'Calculate Compensation'**
  String get calculateCompensation;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @noCompensation.
  ///
  /// In en, this message translates to:
  /// **'No compensation calculated yet.'**
  String get noCompensation;

  /// No description provided for @userManagement.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get userManagement;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add User'**
  String get addUser;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @directorate.
  ///
  /// In en, this message translates to:
  /// **'Directorate'**
  String get directorate;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @userCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User created successfully.'**
  String get userCreatedSuccessfully;

  /// No description provided for @errorCreatingUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to create user.'**
  String get errorCreatingUser;

  /// No description provided for @noUsers.
  ///
  /// In en, this message translates to:
  /// **'There are no users.'**
  String get noUsers;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
