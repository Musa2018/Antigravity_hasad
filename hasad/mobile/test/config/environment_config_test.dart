import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/config/app_config.dart';

void main() {
  group('EnvironmentConfig', () {
    test('setEnvironment selects the matching config', () {
      EnvironmentConfig.setEnvironment(AppEnvironment.staging);

      expect(EnvironmentConfig.isInitialized, isTrue);
      expect(EnvironmentConfig.config.environment, AppEnvironment.staging);
      expect(EnvironmentConfig.config.apiBaseUrl, isNotEmpty);
    });

    test('prod config disables logging', () {
      EnvironmentConfig.setEnvironment(AppEnvironment.prod);

      expect(EnvironmentConfig.config.enableLogging, isFalse);
    });

    test('fromDartDefine defaults to dev', () {
      expect(EnvironmentConfig.fromDartDefine(), AppEnvironment.dev);
    });
  });
}
