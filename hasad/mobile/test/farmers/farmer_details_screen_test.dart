import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/farmer_details_screen.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile/features/farmers/domain/gender.dart';

void main() {
  final testFarmer = Farmer(
    id: '1',
    idTypeId: 1,
    idNumber: '123456789',
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
    phoneNumber: '0599123456',
    familySize: 5,
    governorateId: 'G1',
    localityId: 'L1',
    address: 'Gaza',
    syncStatus: 'completed',
    createdAt: DateTime(2026, 1, 1),
  );

  testWidgets('FarmerDetailsScreen shows farmer details', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          farmerProvider('1').overrideWith((ref) => testFarmer),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          home: FarmerDetailsScreen(farmer: testFarmer),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('أحمد'), findsOneWidget);
    expect(find.text('123456789'), findsOneWidget);
    expect(find.text('0599123456'), findsOneWidget);
    expect(find.text('Ahmed'), findsOneWidget);
    expect(find.text('Synced'), findsOneWidget);
  });

  testWidgets('FarmerDetailsScreen shows loading state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          farmerProvider('1').overrideWith((ref) => Future.delayed(
            const Duration(seconds: 1),
            () => testFarmer,
          )),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          home: FarmerDetailsScreen(farmer: testFarmer),
        ),
      ),
    );

    // Initial data is shown from the passed 'farmer' object
    expect(find.text('أحمد'), findsOneWidget);
    
    // Clear the pending timer
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('FarmerDetailsScreen handles error state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          farmerProvider('1').overrideWith((ref) => throw Exception('Failed to load')),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          home: FarmerDetailsScreen(farmer: testFarmer),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // It should fallback to the passed 'farmer' data
    expect(find.text('أحمد'), findsOneWidget);
  });
}
