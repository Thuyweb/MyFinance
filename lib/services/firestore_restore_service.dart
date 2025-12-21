import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/model_factory.dart';
import 'database_service.dart';
import 'recovery_code_service.dart';

class FirestoreRestoreService {
  FirestoreRestoreService._();
  static final FirestoreRestoreService instance = FirestoreRestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Restore bằng recovery code (ENTRY POINT)
  Future<bool> restoreWithRecoveryCode({
    required String deviceId,
    required String recoveryCode,
  }) async {
    // 1️⃣ Verify recovery code
    final isValid = await RecoveryCodeService.instance.verifyRecoveryCode(
      deviceId: deviceId,
      inputCode: recoveryCode,
    );

    if (!isValid) {
      debugPrint('❌ Invalid recovery code');
      return false;
    }

    // 2️⃣ Restore snapshot mới nhất
    final restored = await restoreLatestBackup(deviceId);

    if (restored) {
      debugPrint('🔐 Device marked as restored');
      // 👉 Nếu sau này có LocalDeviceState / VaultState
      // LocalDeviceState.markRestored(deviceId);
    }

    return restored;
  }

  /// 🔁 Restore snapshot mới từ Firestore
  Future<bool> restoreLatestBackup(String deviceId) async {
    if (kIsWeb) return false;

    final db = DatabaseService.instance;

    try {
      final query = await _firestore
          .collection('backups')
          .doc(deviceId)
          .collection('snapshots')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        debugPrint('⚠ No snapshot found');
        return false;
      }

      final snapshot = query.docs.first;
      final data = snapshot['data'] as Map<String, dynamic>;

      // 🔐 Backup local để rollback
      await db.backupLocalTemp();

      // 🧹 Clear local data
      await db.clearAllData();

      // 🔁 Restore từng Hive box
      await _restoreBox(db.user, data['user']);
      await _restoreBox(db.categories, data['categories']);
      await _restoreBox(db.expenses, data['expenses']);
      await _restoreBox(db.incomes, data['incomes']);
      await _restoreBox(db.budgets, data['budgets']);
      await _restoreBox(db.transactions, data['transactions']);
      await _restoreBox(db.paymentMethods, data['payment_methods']);

      // ✅ Xoá backup tạm sau khi restore thành công
      await db.clearTempBackup();

      debugPrint('✅ Restore completed successfully');
      return true;
    } catch (e, s) {
      debugPrint('❌ Restore failed: $e');
      debugPrint('$s');

      // ♻ Rollback data cũ nếu có lỗi
      await DatabaseService.instance.restoreFromTemp();
      return false;
    }
  }

  /// 🔧 Restore dữ liệu cho từng Hive box
  Future<void> _restoreBox<T>(
    Box<T> box,
    List<dynamic>? items,
  ) async {
    if (items == null || items.isEmpty) return;

    for (final json in items) {
      final model = ModelFactory.fromJson<T>(
        Map<String, dynamic>.from(json),
      );

      if (model == null) continue;

      final id = (model as dynamic).id;
      if (id == null) continue;

      await box.put(id, model);
    }
  }
}
