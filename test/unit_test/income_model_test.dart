import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/income.dart';

void main() {
  group('IncomeModel Unit Tests', () {
    test('Khởi tạo với giá trị mặc định', () {
      final income = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương tháng 12',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(income.isRecurring, false);
      expect(income.recurringPattern, null);
      expect(income.attachmentPath, null);
    });



    test('Income source được lưu trữ chính xác', () {
      final salaryIncome = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final freelanceIncome = IncomeModel(
        id: 'inc2',
        amount: 5000000.0,
        categoryId: 'cat_freelance',
        description: 'Công việc freelance',
        date: DateTime.now(),
        source: 'freelance',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final investmentIncome = IncomeModel(
        id: 'inc3',
        amount: 2000000.0,
        categoryId: 'cat_investment',
        description: 'Lợi tức đầu tư',
        date: DateTime.now(),
        source: 'investment',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(salaryIncome.source, 'salary');
      expect(freelanceIncome.source, 'freelance');
      expect(investmentIncome.source, 'investment');
    });

    test('Recurring income được định nghĩa chính xác', () {
      final recurringIncome = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương hàng tháng',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isRecurring: true,
        recurringPattern: 'monthly',
      );

      expect(recurringIncome.isRecurring, true);
      expect(recurringIncome.recurringPattern, 'monthly');
    });

    test('toJson bao gồm tất cả các trường', () {
      final income = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương tháng 12',
        date: DateTime(2025, 12, 1),
        source: 'salary',
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
        isRecurring: true,
        recurringPattern: 'monthly',
        attachmentPath: '/path/to/salary_slip.pdf',
      );

      final json = income.toJson();

      expect(json['id'], 'inc1');
      expect(json['amount'], 15000000.0);
      expect(json['categoryId'], 'cat_salary');
      expect(json['description'], 'Lương tháng 12');
      expect(json['source'], 'salary');
      expect(json['isRecurring'], true);
      expect(json['recurringPattern'], 'monthly');
      expect(json['attachmentPath'], '/path/to/salary_slip.pdf');
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'inc1',
        'amount': 15000000.0,
        'categoryId': 'cat_salary',
        'description': 'Lương tháng 12',
        'date': '2025-12-01T00:00:00.000Z',
        'source': 'salary',
        'createdAt': '2025-12-01T00:00:00.000Z',
        'updatedAt': '2025-12-01T00:00:00.000Z',
      };

      final income = IncomeModel.fromJson(json);

      expect(income.isRecurring, false);
      expect(income.recurringPattern, null);
      expect(income.attachmentPath, null);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương tháng 12',
        date: DateTime(2025, 12, 1),
        source: 'salary',
        createdAt: DateTime(2025, 12, 1),
        updatedAt: DateTime(2025, 12, 1),
      );

      final updated = original.copyWith(
        amount: 16000000.0,
        description: 'Lương tháng 12 + thưởng',
      );

      expect(updated.id, original.id);
      expect(updated.amount, 16000000.0);
      expect(updated.description, 'Lương tháng 12 + thưởng');
      expect(updated.source, original.source);
    });

    test('Income với attachment path', () {
      final incomeWithAttachment = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attachmentPath: '/storage/emulated/0/Documents/salary_slip.pdf',
      );

      expect(incomeWithAttachment.attachmentPath, '/storage/emulated/0/Documents/salary_slip.pdf');
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = IncomeModel(
        id: 'inc_complex',
        amount: 20000000.0,
        categoryId: 'cat_multiple',
        description: 'Lương + thưởng cuối năm',
        date: DateTime(2025, 12, 1, 10, 0, 0),
        source: 'salary_bonus',
        createdAt: DateTime(2025, 12, 1, 8, 0, 0),
        updatedAt: DateTime(2025, 12, 15, 14, 30, 0),
        isRecurring: false,
        attachmentPath: '/path/to/salary_slip.pdf',
      );

      final json = original.toJson();
      final restored = IncomeModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.amount, original.amount);
      expect(restored.categoryId, original.categoryId);
      expect(restored.description, original.description);
      expect(restored.source, original.source);
      expect(restored.isRecurring, original.isRecurring);
      expect(restored.attachmentPath, original.attachmentPath);
    });

    test('Income amount luôn dương', () {
      final income = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(income.amount, greaterThan(0));
    });

    test('Recurring pattern có thể là weekly, monthly hoặc yearly', () {
      final weeklyIncome = IncomeModel(
        id: 'inc1',
        amount: 2000000.0,
        categoryId: 'cat_freelance',
        description: 'Thu nhập freelance',
        date: DateTime.now(),
        source: 'freelance',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isRecurring: true,
        recurringPattern: 'weekly',
      );

      final monthlyIncome = weeklyIncome.copyWith(recurringPattern: 'monthly');
      final yearlyIncome = weeklyIncome.copyWith(recurringPattern: 'yearly');

      expect(weeklyIncome.recurringPattern, 'weekly');
      expect(monthlyIncome.recurringPattern, 'monthly');
      expect(yearlyIncome.recurringPattern, 'yearly');
    });

    test('Nhiều income sources có thể tồn tại', () {
      final salaryIncome = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final bonusIncome = IncomeModel(
        id: 'inc2',
        amount: 5000000.0,
        categoryId: 'cat_bonus',
        description: 'Thưởng',
        date: DateTime.now(),
        source: 'bonus',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final interestIncome = IncomeModel(
        id: 'inc3',
        amount: 500000.0,
        categoryId: 'cat_interest',
        description: 'Lãi suất',
        date: DateTime.now(),
        source: 'interest',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(salaryIncome.source, 'salary');
      expect(bonusIncome.source, 'bonus');
      expect(interestIncome.source, 'interest');
    });

    test('Income description không trống', () {
      final income = IncomeModel(
        id: 'inc1',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương tháng 12',
        date: DateTime.now(),
        source: 'salary',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(income.description, isNotEmpty);
    });
  });
}
