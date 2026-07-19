import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/farms_list_screen.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

import 'package:mobile/features/farmers/domain/gender.dart';

void main() {
  final farmer = Farmer(
    id: 'farmer-1',
    idTypeId: 1,
    idNumber: '123',
    firstNameAr: 'أحمد',
    fatherNameAr: 'محمد',
    grandfatherNameAr: 'علي',
    familyNameAr: 'محمود',
    firstNameEn: 'Ahmed',
    fatherNameEn: 'Mohammed',
    grandfatherNameEn: 'Ali',
    familyNameEn: 'Mahmoud',
    birthDate: DateTime(1985, 5, 10),
    gender: Gender.male,
    phoneNumber: '555',
    familySize: 5,
    governorateId: 'G1',
    localityId: 'L1',
    address: 'Gaza',
  );

  testWidgets('FarmsListScreen shows farms for farmer', (tester) async {
    final farms = [
      const Farm(
        id: 'farm-1',
        farmerId: 'farmer-1',
        name: 'Fruit Garden',
        governorateId: 'Gaza',
        localityId: 'City',
        landArea: 5,
        landAreaUnit: 'Dunam',
        ownershipTypeId: 'Owned',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          farmsListByFarmerProvider('farmer-1').overrideWith((ref) => farms),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: FarmsListScreen(farmer: farmer),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Fruit Garden'), findsOneWidget);
    expect(find.text('5.0 Dunam'), findsOneWidget);
  });
}
