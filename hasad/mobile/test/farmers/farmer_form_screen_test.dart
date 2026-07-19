import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/domain/gender.dart';
import 'package:mobile/features/farmers/data/farmer_repository.dart';
import 'package:mobile/features/farmers/presentation/farmer_form_screen.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/features/location/domain/locality.dart';
import 'package:mobile/features/location/data/location_repository.dart';
import 'package:mobile/features/location/presentation/location_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockFarmerRepository extends Mock implements FarmerRepository {}
class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockFarmerRepository mockFarmerRepo;
  late MockLocationRepository mockLocationRepo;

  setUpAll(() {
    registerFallbackValue(
      Farmer(
        id: '',
        idTypeId: 1,
        idNumber: '',
        firstNameAr: '',
        fatherNameAr: '',
        grandfatherNameAr: '',
        familyNameAr: '',
        firstNameEn: '',
        fatherNameEn: '',
        grandfatherNameEn: '',
        familyNameEn: '',
        birthDate: DateTime.now(),
        gender: Gender.unspecified,
        phoneNumber: '',
        familySize: 1,
        governorateId: '',
        localityId: '',
        address: '',
      ),
    );
  });

  setUp(() {
    mockFarmerRepo = MockFarmerRepository();
    mockLocationRepo = MockLocationRepository();
  });

  Widget createWidget(Widget child) {
    return ProviderScope(
      overrides: [
        farmerRepositoryProvider.overrideWithValue(mockFarmerRepo),
        locationRepositoryProvider.overrideWithValue(mockLocationRepo),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: child,
      ),
    );
  }

  testWidgets('FarmerFormScreen renders sections correctly', (tester) async {
    when(() => mockLocationRepo.getGovernorates()).thenAnswer((_) async => []);

    await tester.pumpWidget(createWidget(const FarmerFormScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Identity'), findsOneWidget);
    expect(find.text('Arabic Name'), findsOneWidget);
    expect(find.text('English Name'), findsOneWidget);
    expect(find.text('Demographics'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
  });

  testWidgets('FarmerFormScreen handles Cascading Lookups', (tester) async {
    final govs = [const Governorate(id: 'g1', nameAr: 'محافظة 1', nameEn: 'Gov 1')];
    final locs = [const Locality(id: 'l1', nameAr: 'تجمع 1', nameEn: 'Loc 1', governorateId: 'g1')];

    when(() => mockLocationRepo.getGovernorates()).thenAnswer((_) async => govs);
    when(() => mockLocationRepo.getLocalities(governorateId: any(named: 'governorateId')))
        .thenAnswer((_) async => locs);

    await tester.pumpWidget(createWidget(const FarmerFormScreen()));
    await tester.pumpAndSettle();

    // Select Governorate
    final govField = find.ancestor(
      of: find.text('Governorate'),
      matching: find.byType(InkWell),
    ).first;
    await tester.ensureVisible(govField);
    await tester.tap(govField);
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('Gov 1'));
    await tester.pumpAndSettle();

    expect(find.text('Gov 1'), findsOneWidget);

    // Verify Locality is now available
    final locField = find.ancestor(
      of: find.text('Locality/Village'),
      matching: find.byType(InkWell),
    ).first;
    await tester.ensureVisible(locField);
    await tester.tap(locField);
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('Loc 1'));
    await tester.pumpAndSettle();

    expect(find.text('Loc 1'), findsOneWidget);
  });

  testWidgets('FarmerFormScreen saves edited farmer', (tester) async {
    final farmer = Farmer(
      id: '1',
      idTypeId: 1,
      idNumber: '123',
      firstNameAr: 'أ',
      fatherNameAr: 'ب',
      grandfatherNameAr: 'ج',
      familyNameAr: 'د',
      firstNameEn: 'A',
      fatherNameEn: 'B',
      grandfatherNameEn: 'C',
      familyNameEn: 'D',
      birthDate: DateTime(1990, 1, 1),
      gender: Gender.male,
      phoneNumber: '059',
      familySize: 4,
      governorateId: 'g1',
      localityId: 'l1',
      address: 'Addr',
      rowVersion: 'v1',
    );

    when(() => mockLocationRepo.getGovernorates()).thenAnswer((_) async => [
      const Governorate(id: 'g1', nameAr: 'محافظة 1', nameEn: 'Gov 1')
    ]);
    when(() => mockLocationRepo.getLocalities(governorateId: any(named: 'governorateId')))
        .thenAnswer((_) async => [
      const Locality(id: 'l1', nameAr: 'تجمع 1', nameEn: 'Loc 1', governorateId: 'g1')
    ]);
    when(() => mockFarmerRepo.updateFarmer(any())).thenAnswer((_) async => farmer);

    await tester.pumpWidget(createWidget(FarmerFormScreen(farmer: farmer)));
    await tester.pumpAndSettle();

    final saveButton = find.text('Save');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    
    // Pump once to start the action
    await tester.pump();
    
    // We expect SnackBar to appear.
    await tester.pump(const Duration(milliseconds: 100));
    
    verify(() => mockFarmerRepo.updateFarmer(any())).called(1);
    
    expect(find.text('Farmer updated successfully'), findsOneWidget);
  });
}
