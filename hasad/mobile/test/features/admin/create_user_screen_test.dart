import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/core/storage/secure_storage_service.dart';
import 'package:mobile/core/presentation/widgets/searchable_lookup_field.dart';
import 'package:mobile/features/admin/data/users_repository.dart';
import 'package:mobile/features/admin/domain/role.dart';
import 'package:mobile/features/admin/presentation/create_user_screen.dart';
import 'package:mobile/features/admin/presentation/users_providers.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/domain/auth_session.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockTokenRefresher extends Mock implements TokenRefresher {}

class FakeAuthNotifier extends AuthNotifier {
  FakeAuthNotifier()
    : super(
        MockAuthRepository(),
        MockSecureStorageService(),
        MockTokenRefresher(),
      ) {
    state = AuthState(
      status: AuthStatus.authenticated,
      session: const AuthSession(
        token: 't',
        refreshToken: 'r',
        userId: 'u1',
        email: 'a@a.com',
        fullName: 'Admin',
        roles: ['SuperAdmin'],
      ),
    );
  }

  @override
  Future<void> restoreSession() async {}
}

void main() {
  late MockUsersRepository repository;

  setUp(() {
    repository = MockUsersRepository();
  });

  Widget buildTestApp() {
    return ProviderScope(
      overrides: [
        usersRepositoryProvider.overrideWithValue(repository),
        authProvider.overrideWith((ref) => FakeAuthNotifier()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en')],
        home: UserFormScreen(),
      ),
    );
  }

  testWidgets('UserFormScreen shows validation errors for empty fields', (
    tester,
  ) async {
    when(() => repository.getRoles()).thenAnswer((_) async => []);
    when(() => repository.getGovernorates()).thenAnswer((_) async => []);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Use find.text('Save') to be more specific
    final saveButton = find.text('Save');
    expect(saveButton, findsOneWidget);

    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verify repository was not called due to validation failure
    verifyNever(
      () => repository.createUser(
        fullName: any(named: 'fullName'),
        userName: any(named: 'userName'),
        email: any(named: 'email'),
        phoneNumber: any(named: 'phoneNumber'),
        password: any(named: 'password'),
        confirmPassword: any(named: 'confirmPassword'),
        role: any(named: 'role'),
        isActive: any(named: 'isActive'),
      ),
    );
  });

  testWidgets('UserFormScreen geographic fields appear based on role', (
    tester,
  ) async {
    final roles = [
      const Role(id: 'r1', name: 'SuperAdmin', scopeType: 'Global'),
      const Role(id: 'r2', name: 'Director', scopeType: 'Governorate'),
    ];
    when(() => repository.getRoles()).thenAnswer((_) async => roles);
    when(() => repository.getGovernorates()).thenAnswer((_) async => []);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Initially Global role or no role, no geo fields
    expect(find.text('Governorate'), findsNothing);

    // Select Director
    final roleField = find.byType(SearchableLookupField<Role>);
    expect(roleField, findsOneWidget);
    await tester.ensureVisible(roleField);
    await tester.tap(roleField);
    await tester.pumpAndSettle();

    // In the search sheet, tap Director
    final directorItem = find.text('Director').last;
    await tester.tap(directorItem);
    await tester.pumpAndSettle();

    expect(find.text('Governorate'), findsOneWidget);
  });
}
