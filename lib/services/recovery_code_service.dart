import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';

class RecoveryCodeService {
  RecoveryCodeService._();
  static final RecoveryCodeService instance = RecoveryCodeService._();

  final _firestore = FirebaseFirestore.instance;

  String generateRecoveryCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random.secure();

    String block() => List.generate(
          4,
          (_) => chars[rand.nextInt(chars.length)],
        ).join();

    return '${block()}-${block()}-${block()}';
  }

  Future<bool> hasRecoveryCode(String deviceId) async {
    final doc =
        await _firestore.collection('recovery_backups').doc(deviceId).get();
    return doc.exists && doc.data()?['recoveryCodeHash'] != null;
  }

  Future<void> saveRecoveryCode({
    required String deviceId,
    required String recoveryCode,
    required String phoneNumber,
  }) async {
    final codeHash = AuthService.instance.getHashedPin(recoveryCode);
    final phoneHash = AuthService.instance.getHashedPin(phoneNumber);

    await _firestore.collection('recovery_backups').doc(deviceId).set({
      'recoveryCodeHash': codeHash,
      'phoneHash': phoneHash,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<bool> verifyPhone({
    required String deviceId,
    required String phoneNumber,
  }) async {
    final doc =
        await _firestore.collection('recovery_backups').doc(deviceId).get();
    if (!doc.exists) return false;

    final savedPhoneHash = doc['phoneHash'];
    final inputHash = AuthService.instance.getHashedPin(phoneNumber);
    return savedPhoneHash == inputHash;
  }

  Future<bool> verifyRecoveryCode({
    required String deviceId,
    required String inputCode,
  }) async {
    final doc =
        await _firestore.collection('recovery_backups').doc(deviceId).get();

    if (!doc.exists) return false;

    final savedHash = doc['recoveryCodeHash'];
    final inputHash = AuthService.instance.getHashedPin(inputCode);

    return savedHash == inputHash;
  }
}
