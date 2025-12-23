import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/user.dart';

void main() {
  group('UserModel Unit Tests', () {
    test('Khởi tạo với giá trị mặc định', () {
      final user = UserModel(
        id: 'user1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.currency, 'VNĐ');
      expect(user.isBackupEnabled, false);
      expect(user.notificationEnabled, true);
      expect(user.biometricEnabled, false);
      expect(user.theme, 'system');
      expect(user.language, 'vi');
      expect(user.budgetAlertEnabled, true);
      expect(user.budgetAlertPercentage, 80);
      expect(user.pinEnabled, false);
      expect(user.isSetupCompleted, false);
      expect(user.backgroundLockTimeout, 120);
    });

    test('Currency được lưu trữ chính xác', () {
      final userVND = UserModel(
        id: 'user1',
        currency: 'VNĐ',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final userUSD = UserModel(
        id: 'user2',
        currency: 'USD',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(userVND.currency, 'VNĐ');
      expect(userUSD.currency, 'USD');
    });

    test('Theme là light, dark hoặc system', () {
      final lightTheme = UserModel(
        id: 'user1',
        theme: 'light',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final darkTheme = lightTheme.copyWith(theme: 'dark');
      final systemTheme = lightTheme.copyWith(theme: 'system');

      expect(lightTheme.theme, 'light');
      expect(darkTheme.theme, 'dark');
      expect(systemTheme.theme, 'system');
    });

    test('Language là vi hoặc en', () {
      final viUser = UserModel(
        id: 'user1',
        language: 'vi',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final enUser = viUser.copyWith(language: 'en');

      expect(viUser.language, 'vi');
      expect(enUser.language, 'en');
    });

    test('Google account information được lưu trữ', () {
      final user = UserModel(
        id: 'user1',
        googleAccountEmail: 'user@gmail.com',
        googleAccountName: 'John Doe',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.googleAccountEmail, 'user@gmail.com');
      expect(user.googleAccountName, 'John Doe');
    });

    test('Backup settings được quản lý', () {
      final noBackup = UserModel(
        id: 'user1',
        isBackupEnabled: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final withBackup = noBackup.copyWith(
        isBackupEnabled: true,
        lastBackupDate: DateTime.now(),
      );

      expect(noBackup.isBackupEnabled, false);
      expect(withBackup.isBackupEnabled, true);
      expect(withBackup.lastBackupDate, isNotNull);
    });

    test('Notification settings được quản lý', () {
      final notificationEnabled = UserModel(
        id: 'user1',
        notificationEnabled: true,
        notificationTime: '09:00',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final notificationDisabled = notificationEnabled.copyWith(
        notificationEnabled: false,
      );

      expect(notificationEnabled.notificationEnabled, true);
      expect(notificationEnabled.notificationTime, '09:00');
      expect(notificationDisabled.notificationEnabled, false);
    });

    test('Biometric settings được quản lý', () {
      const biometricDisabled = false;
      const biometricEnabled = true;

      final user1 = UserModel(
        id: 'user1',
        biometricEnabled: biometricDisabled,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final user2 = user1.copyWith(biometricEnabled: biometricEnabled);

      expect(user1.biometricEnabled, false);
      expect(user2.biometricEnabled, true);
    });

    test('Budget alert settings được quản lý', () {
      final user = UserModel(
        id: 'user1',
        monthlyBudgetLimit: 50000000.0,
        budgetAlertEnabled: true,
        budgetAlertPercentage: 80,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updated = user.copyWith(
        monthlyBudgetLimit: 60000000.0,
        budgetAlertPercentage: 90,
      );

      expect(user.monthlyBudgetLimit, 50000000.0);
      expect(user.budgetAlertPercentage, 80);
      expect(updated.monthlyBudgetLimit, 60000000.0);
      expect(updated.budgetAlertPercentage, 90);
    });

    test('PIN code settings được quản lý', () {
      final noPIN = UserModel(
        id: 'user1',
        pinEnabled: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final withPIN = noPIN.copyWith(
        pinEnabled: true,
        pinCode: 'hashed_pin_code_here',
      );

      expect(noPIN.pinEnabled, false);
      expect(noPIN.pinCode, null);
      expect(withPIN.pinEnabled, true);
      expect(withPIN.pinCode, 'hashed_pin_code_here');
    });

    test('Background lock timeout được lưu trữ', () {
      final user = UserModel(
        id: 'user1',
        backgroundLockTimeout: 120,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updated = user.copyWith(backgroundLockTimeout: 300);

      expect(user.backgroundLockTimeout, 120);
      expect(updated.backgroundLockTimeout, 300);
    });

    test('Recovery code được lưu trữ', () {
      final user = UserModel(
        id: 'user1',
        recoveryCode: 'RECOVERY_CODE_12345',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(user.recoveryCode, 'RECOVERY_CODE_12345');
    });

    test('Setup completion status được quản lý', () {
      final notSetup = UserModel(
        id: 'user1',
        isSetupCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final setup = notSetup.copyWith(isSetupCompleted: true);

      expect(notSetup.isSetupCompleted, false);
      expect(setup.isSetupCompleted, true);
    });

    test('toJson bao gồm tất cả các trường', () {
      final user = UserModel(
        id: 'user1',
        currency: 'VNĐ',
        googleAccountEmail: 'user@gmail.com',
        googleAccountName: 'John Doe',
        isBackupEnabled: true,
        lastBackupDate: DateTime(2025, 12, 1),
        notificationEnabled: true,
        notificationTime: '09:00',
        biometricEnabled: false,
        theme: 'dark',
        language: 'vi',
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        monthlyBudgetLimit: 50000000.0,
        budgetAlertEnabled: true,
        budgetAlertPercentage: 80,
        pinEnabled: true,
        pinCode: 'hashed_pin',
        isSetupCompleted: true,
        backgroundLockTimeout: 120,
        recoveryCode: 'RECOVERY_CODE',
      );

      final json = user.toJson();

      expect(json['id'], 'user1');
      expect(json['currency'], 'VNĐ');
      expect(json['googleAccountEmail'], 'user@gmail.com');
      expect(json['googleAccountName'], 'John Doe');
      expect(json['isBackupEnabled'], true);
      expect(json['notificationEnabled'], true);
      expect(json['biometricEnabled'], false);
      expect(json['theme'], 'dark');
      expect(json['language'], 'vi');
      expect(json['monthlyBudgetLimit'], 50000000.0);
      expect(json['budgetAlertPercentage'], 80);
      expect(json['pinEnabled'], true);
      expect(json['isSetupCompleted'], true);
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'user1',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final user = UserModel.fromJson(json);

      expect(user.currency, 'VNĐ');
      expect(user.isBackupEnabled, false);
      expect(user.notificationEnabled, true);
      expect(user.biometricEnabled, false);
      expect(user.theme, 'system');
      expect(user.language, 'vi');
    });

    test('fromJson xử lý nullable dates', () {
      final json = {
        'id': 'user1',
        'lastBackupDate': '2025-12-01T10:00:00.000Z',
        'lastSyncDate': '2025-12-01T12:00:00.000Z',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final user = UserModel.fromJson(json);

      expect(user.lastBackupDate, isNotNull);
      expect(user.lastSyncDate, isNotNull);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = UserModel(
        id: 'user1',
        currency: 'VNĐ',
        theme: 'light',
        language: 'vi',
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
      );

      final updated = original.copyWith(
        currency: 'USD',
        theme: 'dark',
        language: 'en',
      );

      expect(updated.id, original.id);
      expect(updated.currency, 'USD');
      expect(updated.theme, 'dark');
      expect(updated.language, 'en');
      expect(updated.createdAt, original.createdAt);
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = UserModel(
        id: 'user_complex',
        currency: 'VNĐ',
        googleAccountEmail: 'user@gmail.com',
        googleAccountName: 'John Doe',
        isBackupEnabled: true,
        lastBackupDate: DateTime(2025, 12, 1, 10, 0, 0),
        lastSyncDate: DateTime(2025, 12, 1, 12, 0, 0),
        notificationEnabled: true,
        notificationTime: '09:00',
        biometricEnabled: true,
        theme: 'dark',
        language: 'vi',
        createdAt: DateTime(2025, 12, 1, 0, 0, 0),
        updatedAt: DateTime(2025, 12, 20, 14, 30, 0),
        monthlyBudgetLimit: 50000000.0,
        budgetAlertEnabled: true,
        budgetAlertPercentage: 85,
        pinEnabled: true,
        pinCode: 'hashed_pin_code',
        isSetupCompleted: true,
        backgroundLockTimeout: 180,
        recoveryCode: 'RECOVERY_CODE_123',
      );

      final json = original.toJson();
      final restored = UserModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.currency, original.currency);
      expect(restored.googleAccountEmail, original.googleAccountEmail);
      expect(restored.googleAccountName, original.googleAccountName);
      expect(restored.isBackupEnabled, original.isBackupEnabled);
      expect(restored.notificationEnabled, original.notificationEnabled);
      expect(restored.biometricEnabled, original.biometricEnabled);
      expect(restored.theme, original.theme);
      expect(restored.language, original.language);
      expect(restored.monthlyBudgetLimit, original.monthlyBudgetLimit);
      expect(restored.budgetAlertPercentage, original.budgetAlertPercentage);
      expect(restored.pinEnabled, original.pinEnabled);
      expect(restored.pinCode, original.pinCode);
      expect(restored.isSetupCompleted, original.isSetupCompleted);
      expect(restored.backgroundLockTimeout, original.backgroundLockTimeout);
      expect(restored.recoveryCode, original.recoveryCode);
    });

    test('Sync date được cập nhật', () {
      final user = UserModel(
        id: 'user1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final syncDate = DateTime.now();
      final updated = user.copyWith(lastSyncDate: syncDate);

      expect(updated.lastSyncDate, syncDate);
    });

    test('Monthly budget limit có thể được đặt hoặc bỏ qua', () {
      final noBudgetLimit = UserModel(
        id: 'user1',
        monthlyBudgetLimit: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final withBudgetLimit = noBudgetLimit.copyWith(
        monthlyBudgetLimit: 50000000.0,
      );

      expect(noBudgetLimit.monthlyBudgetLimit, null);
      expect(withBudgetLimit.monthlyBudgetLimit, 50000000.0);
    });
  });
}
