import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/main.dart';

import 'auth/fakes.dart';

void main() {
  testWidgets('HASAD smoke test: boots to the login screen', (tester) async {
    EnvironmentConfig.setEnvironment(AppEnvironment.dev);
    final repository = FakeAuthRepository();
    final storage = FakeSecureStorage();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(
            (ref) => AuthNotifier(
              repository,
              storage,
              TokenRefresher(repository, storage),
            ),
          ),
        ],
        child: const HasadApp(),
      ),
    );
    await tester.pumpAndSettle();

    // With no stored session the auth guard must land on the login screen.
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
