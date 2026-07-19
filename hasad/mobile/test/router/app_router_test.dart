import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/l10n/app_localizations.dart';

import '../auth/fakes.dart';

Widget buildRoutedApp(
  FakeAuthRepository repository,
  FakeSecureStorage storage,
) {
  return ProviderScope(
    overrides: [
      authProvider.overrideWith(
        (ref) => AuthNotifier(
          repository,
          storage,
          TokenRefresher(repository, storage),
        ),
      ),
    ],
    child: Consumer(
      builder: (context, ref, _) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
      ),
    ),
  );
}

void main() {
  group('App router auth guard', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
    });

    testWidgets('holds on splash while the session is being restored', (
      tester,
    ) async {
      storage.values['refresh'] = 'refresh-0';
      repository.session = sampleSession();
      repository.refreshDelay = const Duration(milliseconds: 300);

      await tester.pumpWidget(buildRoutedApp(repository, storage));
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(HomeScreen), findsNothing);

      await tester.pumpAndSettle();
    });

    testWidgets('redirects to login when no session can be restored', (
      tester,
    ) async {
      await tester.pumpWidget(buildRoutedApp(repository, storage));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('restores a persisted session and lands on home', (
      tester,
    ) async {
      storage.values['refresh'] = 'refresh-0';
      repository.session = sampleSession();

      await tester.pumpWidget(buildRoutedApp(repository, storage));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(storage.values['token'], 'access-1');
    });

    testWidgets('navigates to home after a successful login', (tester) async {
      repository.session = sampleSession();

      await tester.pumpWidget(buildRoutedApp(repository, storage));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField).first,
        'admin@hasad.ps',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('returns to login after logout', (tester) async {
      storage.values['refresh'] = 'refresh-0';
      repository.session = sampleSession();

      await tester.pumpWidget(buildRoutedApp(repository, storage));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(storage.values, isEmpty);
    });
  });
}
