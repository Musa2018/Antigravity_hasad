enum SyncStatus { pending, syncing, completed, failed, conflict }

enum SyncOperation { create, update, delete }

class SyncQueueItem {
  final String id;
  final String localId;
  final String? serverId;
  final String entityType; // e.g., 'farmer', 'farm', 'damage_report'
  final SyncOperation operation;
  final Map<String, dynamic> data;
  final SyncStatus status;
  final int retryCount;
  final String? lastError;
  final DateTime? lastAttemptAt;
  final DateTime createdAt;

  SyncQueueItem({
    required this.id,
    required this.localId,
    this.serverId,
    required this.entityType,
    required this.operation,
    required this.data,
    this.status = SyncStatus.pending,
    this.retryCount = 0,
    this.lastError,
    this.lastAttemptAt,
    required this.createdAt,
  });
}

abstract class BackgroundSyncService {
  Future<void> addToQueue(SyncQueueItem item);
  Future<void> processQueue();
  Future<void> resolveConflict(String localId, Map<String, dynamic> serverData);
}
