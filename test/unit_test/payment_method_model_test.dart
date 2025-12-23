import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/payment_method.dart';

void main() {
  group('PaymentMethodModel Unit Tests', () {
    test('Khởi tạo với giá trị mặc định', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(paymentMethod.isDefault, false);
      expect(paymentMethod.isBuiltIn, false);
    });

    test('Built-in payment methods được đánh dấu đúng cách', () {
      final builtInMethod = PaymentMethodModel(
        id: 'pm_builtin',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        isBuiltIn: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final customMethod = PaymentMethodModel(
        id: 'pm_custom',
        name: 'Ngân hàng ABC',
        iconName: 'account_balance',
        iconColor: 0xFF2196F3,
        isBuiltIn: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(builtInMethod.isBuiltIn, true);
      expect(customMethod.isBuiltIn, false);
    });

    test('Icon getter trả về IconData chính xác', () {
      final walletMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(walletMethod.icon, Icons.account_balance_wallet);
    });

    test('Icon getter trả về default icon cho iconName không hợp lệ', () {
      final unknownMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Phương thức lạ',
        iconName: 'unknown_icon',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(unknownMethod.icon, Icons.payment);
    });

    test('Color getter chuyển đổi iconColor thành Color', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(paymentMethod.color, Color(0xFF4CAF50));
    });

    test('isDefault có thể được bật/tắt', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        isDefault: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updated = paymentMethod.copyWith(isDefault: true);

      expect(paymentMethod.isDefault, false);
      expect(updated.isDefault, true);
    });

    test('toJson bao gồm tất cả các trường', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        isDefault: false,
        isBuiltIn: true,
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
      );

      final json = paymentMethod.toJson();

      expect(json['id'], 'pm1');
      expect(json['name'], 'Tiền mặt');
      expect(json['iconName'], 'account_balance_wallet');
      expect(json['iconColor'], 0xFF4CAF50);
      expect(json['isDefault'], false);
      expect(json['isBuiltIn'], true);
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'pm1',
        'name': 'Tiền mặt',
        'iconName': 'account_balance_wallet',
        'iconColor': 0xFF4CAF50,
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final paymentMethod = PaymentMethodModel.fromJson(json);

      expect(paymentMethod.isDefault, false);
      expect(paymentMethod.isBuiltIn, false);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        isDefault: false,
        isBuiltIn: false,
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
      );

      final updated = original.copyWith(
        name: 'Tiền mặt VNĐ',
        iconColor: 0xFF8BC34A,
        isDefault: true,
      );

      expect(updated.id, original.id);
      expect(updated.name, 'Tiền mặt VNĐ');
      expect(updated.iconColor, 0xFF8BC34A);
      expect(updated.isDefault, true);
      expect(updated.iconName, original.iconName);
    });

    test('Các icon types được hỗ trợ', () {
      final icons = [
        'account_balance_wallet',
        'credit_card',
        'payment',
        'account_balance',
        'phone_android',
        'qr_code',
        'contactless',
        'savings',
        'currency_exchange',
        'money',
      ];

      for (String iconName in icons) {
        final method = PaymentMethodModel(
          id: 'pm_test',
          name: 'Test',
          iconName: iconName,
          iconColor: 0xFF4CAF50,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        expect(method.icon, isNotNull);
      }
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = PaymentMethodModel(
        id: 'pm_credit',
        name: 'Thẻ tín dụng Vietcombank',
        iconName: 'credit_card',
        iconColor: 0xFF2196F3,
        isDefault: true,
        isBuiltIn: false,
        createdAt: DateTime(2025, 12, 1, 10, 0, 0),
        updatedAt: DateTime(2025, 12, 15, 14, 30, 0),
      );

      final json = original.toJson();
      final restored = PaymentMethodModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.iconName, original.iconName);
      expect(restored.iconColor, original.iconColor);
      expect(restored.isDefault, original.isDefault);
      expect(restored.isBuiltIn, original.isBuiltIn);
    });

    test('Nhiều payment methods có thể tồn tại', () {
      final cashMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final cardMethod = PaymentMethodModel(
        id: 'pm2',
        name: 'Thẻ tín dụng',
        iconName: 'credit_card',
        iconColor: 0xFF2196F3,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final eWalletMethod = PaymentMethodModel(
        id: 'pm3',
        name: 'E-wallet',
        iconName: 'phone_android',
        iconColor: 0xFFFF9800,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(cashMethod.id, 'pm1');
      expect(cardMethod.id, 'pm2');
      expect(eWalletMethod.id, 'pm3');
    });

    test('Icon color là hex color hợp lệ', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(paymentMethod.iconColor, 0xFF4CAF50);
    });

    test('Name của payment method không trống', () {
      final paymentMethod = PaymentMethodModel(
        id: 'pm1',
        name: 'Tiền mặt',
        iconName: 'account_balance_wallet',
        iconColor: 0xFF4CAF50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(paymentMethod.name, isNotEmpty);
    });
  });
}
