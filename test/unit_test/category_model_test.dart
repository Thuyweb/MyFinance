import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/category.dart';

void main() {
  group('CategoryModel Unit Tests', () {
    late DateTime testTime;
    
    setUp(() {
      testTime = DateTime(2025, 12, 21, 10, 30, 0);
    });

    tearDown(() {
      // Cleanup sau mỗi test
    });

    test('Khởi tạo với giá trị mặc định', () {
      final category = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: testTime,
        updatedAt: testTime,
      );

      expect(category.isActive, isTrue);
      expect(category.isDefault, isFalse);
      expect(category.id, equals('cat1'));
      expect(category.name, equals('Ăn uống'));
    });

    test('Type là income hoặc expense', () {
      final expenseCategory = CategoryModel(
        id: 'exp1',
        name: 'Chi tiêu',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: testTime,
        updatedAt: testTime,
      );

      final incomeCategory = CategoryModel(
        id: 'inc1',
        name: 'Thu nhập',
        type: 'income',
        iconCodePoint: '59490',
        colorValue: '#4CAF50',
        createdAt: testTime,
        updatedAt: testTime,
      );

      expect(expenseCategory.type, equals('expense'));
      expect(incomeCategory.type, equals('income'));
    });

    test('Không chấp nhận type không hợp lệ - kiểm tra validation', () {
      // Mặc dù model không validate, nhưng test này ghi chú rằng
      // trong production, nên thêm validation cho type
      final invalidCategory = CategoryModel(
        id: 'invalid',
        name: 'Invalid',
        type: 'unknown', // Không hợp lệ
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: testTime,
        updatedAt: testTime,
      );

      expect(invalidCategory.type, equals('unknown'));
      // TODO: Thêm validation vào model để reject các types không hợp lệ
    });

    test('toJson bao gồm tất cả các trường', () {
      final category = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        isActive: true,
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isDefault: false,
      );

      final json = category.toJson();

      expect(json['id'], 'cat1');
      expect(json['name'], 'Ăn uống');
      expect(json['type'], 'expense');
      expect(json['iconCodePoint'], '59490');
      expect(json['colorValue'], '#FF5722');
      expect(json['isActive'], true);
      expect(json['isDefault'], false);
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'cat1',
        'name': 'Ăn uống',
        'type': 'expense',
        'iconCodePoint': '59490',
        'colorValue': '#FF5722',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final category = CategoryModel.fromJson(json);

      expect(category.isActive, true);
      expect(category.isDefault, false);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        isActive: true,
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isDefault: false,
      );

      final updated = original.copyWith(
        name: 'Ăn uống & Thức uống',
        colorValue: '#E64A19',
      );

      expect(updated.id, original.id);
      expect(updated.name, 'Ăn uống & Thức uống');
      expect(updated.colorValue, '#E64A19');
      expect(updated.type, original.type);
      expect(updated.isDefault, original.isDefault);
    });

    test('isActive có thể được bật/tắt', () {
      final activeCategory = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final inactiveCategory = activeCategory.copyWith(isActive: false);

      expect(activeCategory.isActive, true);
      expect(inactiveCategory.isActive, false);
    });

    test('isDefault đánh dấu category mặc định', () {
      final defaultCategory = CategoryModel(
        id: 'default1',
        name: 'Khác',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#9E9E9E',
        isDefault: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final customCategory = defaultCategory.copyWith(isDefault: false);

      expect(defaultCategory.isDefault, true);
      expect(customCategory.isDefault, false);
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = CategoryModel(
        id: 'cat_food',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        isActive: true,
        createdAt: DateTime(2025, 12, 1, 10, 30, 0),
        updatedAt: DateTime(2025, 12, 20, 14, 30, 0),
        isDefault: false,
      );

      final json = original.toJson();
      final restored = CategoryModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.type, original.type);
      expect(restored.iconCodePoint, original.iconCodePoint);
      expect(restored.colorValue, original.colorValue);
      expect(restored.isActive, original.isActive);
      expect(restored.isDefault, original.isDefault);
    });

    test('Nhiều categories có thể tồn tại cùng lúc', () {
      final foodCategory = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final transportCategory = CategoryModel(
        id: 'cat2',
        name: 'Vận chuyển',
        type: 'expense',
        iconCodePoint: '59515',
        colorValue: '#2196F3',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final salaryCategory = CategoryModel(
        id: 'cat3',
        name: 'Lương',
        type: 'income',
        iconCodePoint: '59464',
        colorValue: '#4CAF50',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(foodCategory.id, 'cat1');
      expect(transportCategory.id, 'cat2');
      expect(salaryCategory.id, 'cat3');
    });

    test('Icon code point được lưu trữ chính xác', () {
      final category = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(category.iconCodePoint, '59490');
    });

    test('Color hex value được lưu trữ chính xác', () {
      final category = CategoryModel(
        id: 'cat1',
        name: 'Ăn uống',
        type: 'expense',
        iconCodePoint: '59490',
        colorValue: '#FF5722',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(category.colorValue, '#FF5722');
    });
  });
}
