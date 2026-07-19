import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/l10n/app_localizations.dart';

import 'fakes.dart';

Widget buildLoginApp(
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
      home: const LoginScreen(),
    ),
  );
}

void main() {
  group('LoginScreen', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
    });

    testWidgets('shows validation errors for empty fields', (tester) async {
      await tester.pumpWidget(buildLoginApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email.'), findsOneWidget);
      expect(find.text('Please enter your password.'), findsOneWidget);
    });

    testWidgets('rejects a malformed email', (tester) async {
      await tester.pumpWidget(buildLoginApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
      await tester.enterText(find.byType(TextFormField).last, 'secret');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address.'), findsOneWidget);
    });

    testWidgets('shows a localized error when login fails', (tester) async {
      repository.session = null;
      await tester.pumpWidget(buildLoginApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'admin@hasad.ps',
      );
      await tester.enterText(find.byType(TextFormField).last, 'wrong');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(
        find.text('Login failed. Please check your credentials and try again.'),
        findsOneWidget,
      );
    });

    testWidgets('valid submission authenticates and stores tokens', (
      tester,
    ) async {
      repository.session = sampleSession();
      await tester.pumpWidget(buildLoginApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'admin@hasad.ps',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(storage.values['token'], 'access-1');
      expect(storage.values['refresh'], 'refresh-1');
    });

    testWidgets('shows a spinner and disables inputs while logging in', (
      tester,
    ) async {
      repository.session = sampleSession();
      repository.loginDelay = const Duration(milliseconds: 300);
      await tester.pumpWidget(buildLoginApp(repository, storage));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'admin@hasad.ps',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final field = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(field.enabled, isFalse);

      await tester.pumpAndSettle();
    });

    testWidgets('renders in Arabic with RTL directionality', (tester) async {
      await tester.pumpWidget(
        buildLoginApp(repository, storage, locale: const Locale('ar')),
      );
      await tester.pumpAndSettle();

      expect(find.text('تسجيل الدخول'.toUpperCase()), findsWidgets);
      expect(find.text('اسم المستخدم أو البريد الإلكتروني'), findsOneWidget);
      expect(find.text('كلمة المرور'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.byType(LoginScreen))),
        TextDirection.rtl,
      );
    });

    testWidgets('shows localized Arabic validation errors', (tester) async {
      await tester.pumpWidget(
        buildLoginApp(repository, storage, locale: const Locale('ar')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('يرجى إدخال البريد الإلكتروني.'), findsOneWidget);
      expect(find.text('يرجى إدخال كلمة المرور.'), findsOneWidget);
    });
  });
}
