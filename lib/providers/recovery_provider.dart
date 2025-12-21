import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'dart:math';

class RecoveryProvider extends ChangeNotifier {
  static const String _boxName = 'security_box';
  static const String _recoveryCodeKey = 'recovery_code';
  static const String _recoveryShownKey = 'recovery_shown';

  bool isGenerated = false;
  String? recoveryCode;

  /// Khởi tạo và generate recovery code (CHỈ 1 LẦN)
  Future<void> generateAndSave() async {
    final box = await Hive.openBox(_boxName);

    final bool recoveryShown = box.get(_recoveryShownKey, defaultValue: false);

    // ⛔ Nếu đã hiển thị trước đó → không generate lại
    if (recoveryShown) {
      isGenerated = false;
      return;
    }

    // Nếu đã có code thì dùng lại (tránh generate nhiều lần)
    recoveryCode = box.get(_recoveryCodeKey);

    recoveryCode ??= _generateRecoveryCode();

    await box.put(_recoveryCodeKey, recoveryCode);

    isGenerated = true;
    notifyListeners();
  }

  /// Đánh dấu đã hiển thị recovery code (sau khi user bấm "Tôi đã lưu mã")
  Future<void> markRecoveryShown() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_recoveryShownKey, true);
  }

  /// Lấy recovery code đã lưu (dùng cho restore)
  Future<String?> getSavedRecoveryCode() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_recoveryCodeKey);
  }

  /// Reset recovery (chỉ dùng khi DEV / logout / reset app)
  Future<void> resetRecovery() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_recoveryCodeKey);
    await box.delete(_recoveryShownKey);
  }

  /// Generate mã recovery an toàn (XXXX-XXXX-XXXX)
  String _generateRecoveryCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random.secure();

    String block() =>
        List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();

    return '${block()}-${block()}-${block()}';
  }
}
