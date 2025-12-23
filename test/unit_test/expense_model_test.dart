import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/expense.dart';

void main() {
  group('ExpenseModel Unit Tests', () {
    test('Khởi tạo với giá trị mặc định', () {
      final expense = ExpenseModel(
        id: 'exp1',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(expense.paymentMethod, 'cash');
      expect(expense.notes, null);
      expect(expense.isRecurring, false);
      expect(expense.recurringPattern, null);
    });



    test('Payment method có thể là cash, card, hoặc e_wallet', () {
      final cashExpense = ExpenseModel(
        id: 'exp1',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        paymentMethod: 'cash',
      );

      final cardExpense = ExpenseModel(
        id: 'exp2',
        amount: 500000.0,
        categoryId: 'cat_transport',
        description: 'Vé máy bay',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        paymentMethod: 'credit_card',
      );

      final eWalletExpense = ExpenseModel(
        id: 'exp3',
        amount: 100000.0,
        categoryId: 'cat_food',
        description: 'Order đồ ăn',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        paymentMethod: 'e_wallet',
      );

      expect(cashExpense.paymentMethod, 'cash');
      expect(cardExpense.paymentMethod, 'credit_card');
      expect(eWalletExpense.paymentMethod, 'e_wallet');
    });

    test('Recurring expense được định nghĩa chính xác', () {
      final recurringExpense = ExpenseModel(
        id: 'exp1',
        amount: 500000.0,
        categoryId: 'cat_rent',
        description: 'Tiền thuê nhà',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isRecurring: true,
        recurringPattern: 'monthly',
      );

      expect(recurringExpense.isRecurring, true);
      expect(recurringExpense.recurringPattern, 'monthly');
    });

    test('toJson bao gồm tất cả các trường', () {
      final expense = ExpenseModel(
        id: 'exp1',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime(2025, 12, 15),
        receiptPhotoPath: '/path/to/receipt.jpg',
        createdAt: DateTime(2025, 12, 15),
        updatedAt: DateTime(2025, 12, 15),
        location: 'Nhà hàng ABC',
        paymentMethod: 'cash',
        notes: 'Ăn với bạn',
        isRecurring: false,
      );

      final json = expense.toJson();

      expect(json['id'], 'exp1');
      expect(json['amount'], 250000.0);
      expect(json['categoryId'], 'cat_food');
      expect(json['description'], 'Ăn tối');
      expect(json['receiptPhotoPath'], '/path/to/receipt.jpg');
      expect(json['location'], 'Nhà hàng ABC');
      expect(json['paymentMethod'], 'cash');
      expect(json['notes'], 'Ăn với bạn');
      expect(json['isRecurring'], false);
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'exp1',
        'amount': 250000.0,
        'categoryId': 'cat_food',
        'description': 'Ăn tối',
        'date': '2025-12-15T00:00:00.000Z',
        'createdAt': '2025-12-15T00:00:00.000Z',
        'updatedAt': '2025-12-15T00:00:00.000Z',
      };

      final expense = ExpenseModel.fromJson(json);

      expect(expense.paymentMethod, 'cash');
      expect(expense.isRecurring, false);
      expect(expense.receiptPhotoPath, null);
      expect(expense.notes, null);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = ExpenseModel(
        id: 'exp1',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime(2025, 12, 15),
        createdAt: DateTime(2025, 12, 15),
        updatedAt: DateTime(2025, 12, 15),
        location: 'Nhà hàng ABC',
        paymentMethod: 'cash',
      );

      final updated = original.copyWith(
        amount: 350000.0,
        location: 'Nhà hàng XYZ',
        notes: 'Ăn ngon lắm',
      );

      expect(updated.id, original.id);
      expect(updated.amount, 350000.0);
      expect(updated.location, 'Nhà hàng XYZ');
      expect(updated.notes, 'Ăn ngon lắm');
      expect(updated.categoryId, original.categoryId);
    });

    test('Expense với receipt photo path', () {
      final expenseWithReceipt = ExpenseModel(
        id: 'exp1',
        amount: 500000.0,
        categoryId: 'cat_shopping',
        description: 'Mua quần áo',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        receiptPhotoPath: '/storage/emulated/0/Pictures/receipt_001.jpg',
      );

      expect(expenseWithReceipt.receiptPhotoPath, '/storage/emulated/0/Pictures/receipt_001.jpg');
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = ExpenseModel(
        id: 'exp_complex',
        amount: 1250000.0,
        categoryId: 'cat_travel',
        description: 'Chuyến du lịch',
        date: DateTime(2025, 12, 15, 14, 30, 0),
        receiptPhotoPath: '/path/to/receipt.jpg',
        createdAt: DateTime(2025, 12, 15, 10, 0, 0),
        updatedAt: DateTime(2025, 12, 16, 11, 0, 0),
        location: 'Nha Trang',
        paymentMethod: 'debit_card',
        notes: 'Du lịch với gia đình',
        isRecurring: false,
      );

      final json = original.toJson();
      final restored = ExpenseModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.amount, original.amount);
      expect(restored.categoryId, original.categoryId);
      expect(restored.description, original.description);
      expect(restored.receiptPhotoPath, original.receiptPhotoPath);
      expect(restored.location, original.location);
      expect(restored.paymentMethod, original.paymentMethod);
      expect(restored.notes, original.notes);
    });

    test('Expense amount luôn dương', () {
      final expense = ExpenseModel(
        id: 'exp1',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(expense.amount, greaterThan(0));
    });

    test('Recurring pattern có thể là daily, weekly, monthly, hoặc yearly', () {
      final dailyExpense = ExpenseModel(
        id: 'exp1',
        amount: 50000.0,
        categoryId: 'cat_food',
        description: 'Cà phê',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isRecurring: true,
        recurringPattern: 'daily',
      );

      final weeklyExpense = dailyExpense.copyWith(recurringPattern: 'weekly');
      final monthlyExpense = dailyExpense.copyWith(recurringPattern: 'monthly');
      final yearlyExpense = dailyExpense.copyWith(recurringPattern: 'yearly');

      expect(dailyExpense.recurringPattern, 'daily');
      expect(weeklyExpense.recurringPattern, 'weekly');
      expect(monthlyExpense.recurringPattern, 'monthly');
      expect(yearlyExpense.recurringPattern, 'yearly');
    });
  });
}
