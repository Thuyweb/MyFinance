import 'package:flutter/foundation.dart';

import '../services/firestore_backup_service.dart';
import '../services/device_service.dart';

class BackupProvider extends ChangeNotifier {
  /// Gọi khi dữ liệu thay đổi (add / update / delete)
  Future<void> onDataChanged() async {
    try {
      if (kIsWeb) return;

      final deviceId = await DeviceService.getDeviceId();
      await FirestoreBackupService.instance.backupAllData(deviceId);
    } catch (e) {
      debugPrint('BackupProvider error: $e');
    }
  }

  /// Backup ngay (PIN, logout, v.v.)
  Future<void> backupNow() async {
    try {
      if (kIsWeb) return;

      final deviceId = await DeviceService.getDeviceId();
      await FirestoreBackupService.instance.backupAllData(deviceId);
    } catch (e) {
      debugPrint('Backup now failed: $e');
    }
  }
}
