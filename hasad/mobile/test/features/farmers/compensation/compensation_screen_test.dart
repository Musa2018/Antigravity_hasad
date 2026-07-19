import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/features/auth/domain/auth_session.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/farmers/domain/compensation.dart';
import 'package:mobile/features/farmers/presentation/compensation/compensation_providers.dart';
import 'package:mobile/features/farmers/presentation/compensation/compensation_screen.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/farmers/data/compensation_repository.dart';

import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/core/storage/secure_storage_service.dart';
import 'package:mobile/core/network/token_refresher.dart';

class MockCompensationRepository extends Mock
    implements CompensationRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockTokenRefresher extends Mock implements TokenRefresher {}

void main() {
  late MockCompensationRepository repository;

  setUp(() {
    EnvironmentConfig.setEnvironment(AppEnvironment.dev);
    repository = MockCompensationRepository();
  });

  Widget buildTestApp(
    String reportId, {
    List<String> roles = const ['SuperAdmin'],
  }) {
    return ProviderScope(
      overrides: [
        compensationRepositoryProvider.overrideWithValue(repository),
        authProvider.overrideWith((ref) => _FakeAuthNotifier(roles)),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: CompensationScreen(reportId: reportId),
      ),
    );
  }

  testWidgets('CompensationScreen shows no compensation view when null', (
    tester,
  ) async {
    when(() => repository.getByReportId('123')).thenAnswer((_) async => null);

    await tester.pumpWidget(buildTestApp('123'));
    await tester.pumpAndSettle();

    expect(find.text('No compensation calculated yet.'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('CompensationScreen shows detail view when compensation exists', (
    tester,
  ) async {
    final comp = Compensation(
      id: 'c1',
      clientId: 'c1',
      damageReportId: '123',
      calculatedAmount: 1000,
      approvedAmount: 800,
      status: 'Calculated',
      remarks: 'Looks good',
      rowVersion: 'v1',
    );
    when(() => repository.getByReportId('123')).thenAnswer((_) async => comp);

    await tester.pumpWidget(buildTestApp('123'));
    await tester.pumpAndSettle();

    expect(find.text('1000.0'), findsOneWidget);
    expect(find.text('800.0'), findsOneWidget);
    expect(find.text('Calculated'), findsOneWidget);
    expect(find.text('Looks good'), findsOneWidget);
  });
}

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(List<String> roles)
    : super(
        MockAuthRepository(),
        MockSecureStorageService(),
        MockTokenRefresher(),
      ) {
    state = AuthState(
      status: AuthStatus.authenticated,
      session: AuthSession(
        token: 't',
        refreshToken: 'r',
        userId: 'u1',
        email: 'a@a.com',
        fullName: 'Admin',
        roles: roles,
      ),
    );
  }

  @override
  Future<void> restoreSession() async {}
}
