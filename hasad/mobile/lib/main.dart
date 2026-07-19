import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/core/l10n/locale_provider.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/storage/storage_providers.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EnvironmentConfig.setEnvironment(EnvironmentConfig.fromDartDefine());
  runApp(const ProviderScope(child: HasadApp()));
}

/// Root widget of the HASAD mobile application.
class HasadApp extends ConsumerWidget {
  /// Creates the application root.
  const HasadApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);
    // Initialize background sync
    ref.watch(syncServiceProvider);

    return MaterialApp.router(
      title: 'HASAD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
    );
  }
}
