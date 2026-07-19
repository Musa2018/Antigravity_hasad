import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/l10n/app_localizations.dart';

import '../auth/fakes.dart';

Widget buildHomeApp(
  FakeAuthRepository repository,
  FakeSecureStorage storage, {
  Locale locale = const Locale('en'),
}) {
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
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: const HomeScreen(),
    ),
  );
}

/// Seeds [storage] and [repository] so session restoration authenticates.
void seedAuthenticatedSession(
  FakeAuthRepository repository,
  FakeSecureStorage storage,
) {
  storage.values['refresh'] = 'refresh-0';
  repository.session = sampleSession();
}

void main() {
  group('HomeScreen', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
    });

    testWidgets('greets the signed-in user by full name', (tester) async {
      seedAuthenticatedSession(repository, storage);
      await tester.pumpWidget(buildHomeApp(repository, storage));
      await tester.pumpAndSettle();

      expect(find.text('Welcome, Super Admin'), findsOneWidget);
    });

    testWidgets('logout revokes the session and clears storage', (
      tester,
    ) async {
      seedAuthenticatedSession(repository, storage);
      await tester.pumpWidget(buildHomeApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      expect(repository.logoutCalls, 1);
      expect(storage.values, isEmpty);
    });

    testWidgets('renders in Arabic with RTL directionality', (tester) async {
      seedAuthenticatedSession(repository, storage);
      await tester.pumpWidget(
        buildHomeApp(repository, storage, locale: const Locale('ar')),
      );
      await tester.pumpAndSettle();

      expect(find.text('لوحة القيادة'), findsOneWidget);
      expect(find.text('مرحباً، Super Admin'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.byType(HomeScreen))),
        TextDirection.rtl,
      );
    });
  });
}
