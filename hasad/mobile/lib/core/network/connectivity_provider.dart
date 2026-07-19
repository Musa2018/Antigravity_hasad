import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final connectivityStatusProvider = StreamProvider<List<ConnectivityResult>>((
  ref,
) {
  return ref.watch(_connectivityProvider).onConnectivityChanged;
});

extension ConnectivityX on WidgetRef {
  bool get isOffline {
    final connectivity = watch(connectivityStatusProvider).value ?? [];
    return connectivity.isEmpty ||
        connectivity.contains(ConnectivityResult.none);
  }

  /// Performs a fresh, non-cached active check of the network status.
  /// Use this inside action buttons (onPressed) to avoid "fake offline" errors.
  Future<bool> checkIsOffline() async {
    try {
      final connectivity = read(_connectivityProvider);
      final List<ConnectivityResult> results = await connectivity
          .checkConnectivity();
      return results.isEmpty || results.contains(ConnectivityResult.none);
    } catch (_) {
      // If the plugin fails or returns an unexpected type, proceed cautiously
      return false;
    }
  }
}
