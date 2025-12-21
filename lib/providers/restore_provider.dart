import 'package:flutter/material.dart';

import '../services/firestore_restore_service.dart';
import '../services/device_service.dart';

class RestoreProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Thực hiện khôi phục dữ liệu bằng recovery code
  Future<bool> restore(String recoveryCode) async {
    // ⛔ Chặn click nhiều lần
    if (_isLoading) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final deviceId = await DeviceService.getDeviceId();

      final success =
          await FirestoreRestoreService.instance.restoreWithRecoveryCode(
        deviceId: deviceId,
        recoveryCode: recoveryCode,
      );

      if (!success) {
        _error =
            'Khôi phục thất bại. Vui lòng kiểm tra recovery code hoặc thử lại sau.';
      }

      return success;
    } catch (_) {
      // ❌ Không show exception raw cho user
      _error = 'Có lỗi xảy ra trong quá trình khôi phục dữ liệu';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset error (dùng khi rời màn hình hoặc nhập lại code)
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
