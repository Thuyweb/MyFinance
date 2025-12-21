import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'database_service.dart';

class FirestoreBackupService {
  FirestoreBackupService._();
  static final FirestoreBackupService instance = FirestoreBackupService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> backupAllData(String deviceId) async {
    if (kIsWeb) return;

    final db = DatabaseService.instance;

    final data = {
      'user': db.user.values.map((e) => e.toJson()).toList(),
      'categories': db.categories.values.map((e) => e.toJson()).toList(),
      'expenses': db.expenses.values.map((e) => e.toJson()).toList(),
      'incomes': db.incomes.values.map((e) => e.toJson()).toList(),
      'budgets': db.budgets.values.map((e) => e.toJson()).toList(),
      'transactions': db.transactions.values.map((e) => e.toJson()).toList(),
      'payment_methods':
          db.paymentMethods.values.map((e) => e.toJson()).toList(),
    };

    await _firestore
        .collection('backups')
        .doc(deviceId)
        .collection('snapshots')
        .add({
      'timestamp': FieldValue.serverTimestamp(),
      'appVersion': '1.0.0',
      'schemaVersion': 1,
      'data': data,
    });

    debugPrint('✅ Backup snapshot created');
  }
}
