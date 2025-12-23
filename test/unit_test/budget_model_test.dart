import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/budget.dart';  

void main() {
  group('BudgetModel Unit Tests', () {

    test('Tính usagePercentage đúng', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 350000.0,
        period: 'monthly',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 31),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.usagePercentage, closeTo(35.0, 0.01));
    });

    test('Tính remaining đúng', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 350000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.remaining, 650000.0);
    });

    test('Status đúng theo mức sử dụng', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 200000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        alertPercentage: 80,
      );

      expect(budget.status, 'normal');

      final warning = budget.copyWith(spent: 850000.0);
      expect(warning.status, 'warning');

      final exceeded = budget.copyWith(spent: 1200000.0);
      expect(exceeded.status, 'exceeded');
    });

    test('toJson và fromJson hoạt động đúng', () {
      final original = BudgetModel(
        id: 'test1',
        categoryId: 'food',
        amount: 500000.0,
        spent: 100000.0,
        period: 'weekly',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 7),
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isRecurring: true,
      );

      final json = original.toJson();
      final restored = BudgetModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.amount, original.amount);
      expect(restored.spent, original.spent);
      expect(restored.isRecurring, true);
    });

    test('Khởi tạo với giá trị mặc định', () {
      final budget = BudgetModel(
        id: 'default1',
        categoryId: 'cat1',
        amount: 1000000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.spent, 0.0);
      expect(budget.isActive, true);
      expect(budget.alertEnabled, true);
      expect(budget.alertPercentage, 80);
      expect(budget.isRecurring, false);
      expect(budget.notes, null);
    });

    test('remaining âm khi spent > amount', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 1500000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.remaining, -500000.0);
    });

    test('usagePercentage bằng 0 khi amount bằng 0', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 0.0,
        spent: 0.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.usagePercentage, 0);
    });

    test('Status là full khi spent bằng amount', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 1000000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.status, 'full');
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = BudgetModel(
        id: 'test1',
        categoryId: 'food',
        amount: 500000.0,
        spent: 100000.0,
        period: 'monthly',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 31),
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        notes: 'Budget gốc',
        alertPercentage: 80,
      );

      final updated = original.copyWith(
        amount: 1000000.0,
        spent: 500000.0,
        notes: 'Budget cập nhật',
        alertPercentage: 90,
      );

      expect(updated.id, original.id);
      expect(updated.categoryId, original.categoryId);
      expect(updated.amount, 1000000.0);
      expect(updated.spent, 500000.0);
      expect(updated.notes, 'Budget cập nhật');
      expect(updated.alertPercentage, 90);
      expect(updated.period, original.period);
    });

    test('copyWith giữ nguyên các trường không được cập nhật', () {
      final original = BudgetModel(
        id: 'test1',
        categoryId: 'food',
        amount: 500000.0,
        spent: 100000.0,
        period: 'weekly',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 7),
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isActive: true,
      );

      final updated = original.copyWith(amount: 1000000.0);

      expect(updated.period, 'weekly');
      expect(updated.startDate, original.startDate);
      expect(updated.isActive, true);
      expect(updated.alertEnabled, original.alertEnabled);
    });

    test('usagePercentage tính chính xác với số thập phân', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 333333.33,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.usagePercentage, closeTo(33.33, 0.01));
    });

    test('Status warning với các mức alertPercentage khác nhau', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 600000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        alertPercentage: 60,
      );

      expect(budget.usagePercentage, 60.0);
      expect(budget.status, 'warning');

      final strictBudget = budget.copyWith(alertPercentage: 50);
      expect(strictBudget.status, 'warning');

      final lessBudget = budget.copyWith(alertPercentage: 70);
      expect(lessBudget.status, 'normal');
    });

    test('toJson bao gồm tất cả các trường', () {
      final budget = BudgetModel(
        id: 'test1',
        categoryId: 'food',
        amount: 500000.0,
        spent: 100000.0,
        period: 'weekly',
        startDate: DateTime(2025, 12, 1),
        endDate: DateTime(2025, 12, 7),
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isRecurring: true,
        alertPercentage: 75,
        notes: 'Test notes',
        isActive: false,
      );

      final json = budget.toJson();

      expect(json['id'], 'test1');
      expect(json['categoryId'], 'food');
      expect(json['amount'], 500000.0);
      expect(json['spent'], 100000.0);
      expect(json['period'], 'weekly');
      expect(json['isActive'], false);
      expect(json['alertPercentage'], 75);
      expect(json['notes'], 'Test notes');
      expect(json['isRecurring'], true);
    });

    test('fromJson xử lý các giá trị null/optional đúng cách', () {
      final json = {
        'id': 'test1',
        'categoryId': 'food',
        'amount': 500000.0,
        'spent': 100000.0,
        'period': 'monthly',
        'startDate': '2025-12-01T00:00:00.000Z',
        'endDate': '2025-12-31T00:00:00.000Z',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final budget = BudgetModel.fromJson(json);

      expect(budget.isActive, true);
      expect(budget.alertEnabled, true);
      expect(budget.alertPercentage, 80);
      expect(budget.isRecurring, false);
      expect(budget.notes, null);
      expect(budget.recurringTime, null);
    });

    test('fromJson xử lý recurringTime đúng cách', () {
      final json = {
        'id': 'test1',
        'categoryId': 'food',
        'amount': 500000.0,
        'spent': 100000.0,
        'period': 'monthly',
        'startDate': '2025-12-01T00:00:00.000Z',
        'endDate': '2025-12-31T00:00:00.000Z',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
        'isRecurring': true,
        'recurringTime': '2026-01-01T00:00:00.000Z',
      };

      final budget = BudgetModel.fromJson(json);

      expect(budget.isRecurring, true);
      expect(budget.recurringTime, isNotNull);
      expect(budget.recurringTime!.year, 2026);
    });

    test('usagePercentage 100% khi spent bằng amount', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 1000000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.usagePercentage, 100.0);
    });

    test('usagePercentage > 100% khi spent > amount', () {
      final budget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        spent: 1500000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(budget.usagePercentage, 150.0);
    });

    test('Period có thể là weekly, monthly hoặc yearly', () {
      final weeklyBudget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 500000.0,
        period: 'weekly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final monthlyBudget = BudgetModel(
        id: '2',
        categoryId: 'cat1',
        amount: 500000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final yearlyBudget = BudgetModel(
        id: '3',
        categoryId: 'cat1',
        amount: 500000.0,
        period: 'yearly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(weeklyBudget.period, 'weekly');
      expect(monthlyBudget.period, 'monthly');
      expect(yearlyBudget.period, 'yearly');
    });

    test('isActive có thể được bật/tắt', () {
      final activeBudget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );

      final inactiveBudget = activeBudget.copyWith(isActive: false);

      expect(activeBudget.isActive, true);
      expect(inactiveBudget.isActive, false);
    });

    test('alertEnabled có thể được bật/tắt', () {
      final alertBudget = BudgetModel(
        id: '1',
        categoryId: 'cat1',
        amount: 1000000.0,
        period: 'monthly',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        alertEnabled: true,
      );

      final noAlertBudget = alertBudget.copyWith(alertEnabled: false);

      expect(alertBudget.alertEnabled, true);
      expect(noAlertBudget.alertEnabled, false);
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = BudgetModel(
        id: 'complex1',
        categoryId: 'category_test',
        amount: 2500000.0,
        spent: 1750000.0,
        period: 'monthly',
        startDate: DateTime(2025, 12, 1, 10, 30, 0),
        endDate: DateTime(2025, 12, 31, 23, 59, 59),
        createdAt: DateTime(2025, 12, 1, 8, 0, 0),
        updatedAt: DateTime(2025, 12, 20, 14, 30, 0),
        isActive: true,
        alertEnabled: true,
        alertPercentage: 85,
        notes: 'Budget với ghi chú dài',
        isRecurring: true,
        recurringTime: DateTime(2026, 1, 1, 0, 0, 0),
      );

      final json = original.toJson();
      final restored = BudgetModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.categoryId, original.categoryId);
      expect(restored.amount, original.amount);
      expect(restored.spent, original.spent);
      expect(restored.period, original.period);
      expect(restored.isActive, original.isActive);
      expect(restored.alertEnabled, original.alertEnabled);
      expect(restored.alertPercentage, original.alertPercentage);
      expect(restored.notes, original.notes);
      expect(restored.isRecurring, original.isRecurring);
      expect(restored.recurringTime, original.recurringTime);
    });
  });
}