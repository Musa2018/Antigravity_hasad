/// Deployment environments supported by the HASAD mobile application.
enum AppEnvironment { dev, staging, prod }

/// Immutable runtime configuration for a specific [AppEnvironment].
class AppConfig {
  /// The environment this configuration targets.
  final AppEnvironment environment;

  /// Base URL of the HASAD backend API, without a trailing slash.
  final String apiBaseUrl;

  /// Whether verbose network/application logging is enabled.
  final bool enableLogging;

  /// Creates a configuration instance.
  AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.enableLogging = true,
  });

  /// Development environment configuration.
  static AppConfig get dev => AppConfig(
    environment: AppEnvironment.dev,
    apiBaseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:5271/api',
    ),
  );

  /// Staging environment configuration.
  static AppConfig get staging => AppConfig(
    environment: AppEnvironment.staging,
    apiBaseUrl: 'https://staging-api.hasad.ps/api',
  );

  /// Production environment configuration.
  static AppConfig get prod => AppConfig(
    environment: AppEnvironment.prod,
    apiBaseUrl: 'https://api.hasad.ps/api',
    enableLogging: false,
  );
}

/// Holds the active [AppConfig] for the running application.
///
/// [setEnvironment] must be called exactly once at startup (see `main.dart`)
/// before any code reads [config].
class EnvironmentConfig {
  static AppConfig? _config;

  /// The active configuration.
  ///
  /// Throws a [StateError] when accessed before [setEnvironment] is called.
  static AppConfig get config {
    final current = _config;
    if (current == null) {
      throw StateError(
        'EnvironmentConfig has not been initialized. '
        'Call EnvironmentConfig.setEnvironment(...) before runApp().',
      );
    }
    return current;
  }

  /// Whether [setEnvironment] has been called.
  static bool get isInitialized => _config != null;

  /// Selects the active environment configuration.
  static void setEnvironment(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.dev:
        _config = AppConfig.dev;
      case AppEnvironment.staging:
        _config = AppConfig.staging;
      case AppEnvironment.prod:
        _config = AppConfig.prod;
    }
  }

  /// Resolves the environment from the `APP_ENV` compile-time define
  /// (`dev`, `staging`, or `prod`), defaulting to [AppEnvironment.dev].
  static AppEnvironment fromDartDefine() {
    const raw = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    switch (raw) {
      case 'prod':
        return AppEnvironment.prod;
      case 'staging':
        return AppEnvironment.staging;
      default:
        return AppEnvironment.dev;
    }
  }
}
