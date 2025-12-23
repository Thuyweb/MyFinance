import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/models/transaction.dart';

void main() {
  group('TransactionModel Unit Tests', () {
    test('Khởi tạo với giá trị mặc định', () {
      final transaction = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(transaction.attachmentPath, null);
      expect(transaction.paymentMethod, null);
      expect(transaction.location, null);
      expect(transaction.notes, null);
      expect(transaction.sourceOrDestination, null);
    });

    test('Getter isIncome trả về true cho income transaction', () {
      final income = TransactionModel(
        id: 'txn1',
        type: 'income',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(income.isIncome, true);
      expect(income.isExpense, false);
    });

    test('Getter isExpense trả về true cho expense transaction', () {
      final expense = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(expense.isExpense, true);
      expect(expense.isIncome, false);
    });

    test('Transaction type là income hoặc expense', () {
      final incomeTransaction = TransactionModel(
        id: 'txn1',
        type: 'income',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final expenseTransaction = TransactionModel(
        id: 'txn2',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(incomeTransaction.type, 'income');
      expect(expenseTransaction.type, 'expense');
    });

    test('toJson bao gồm tất cả các trường', () {
      final transaction = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime(2025, 12, 15),
        createdAt: DateTime(2025, 12, 15),
        updatedAt: DateTime(2025, 12, 15),
        attachmentPath: '/path/to/receipt.jpg',
        paymentMethod: 'cash',
        location: 'Nhà hàng ABC',
        notes: 'Ăn với bạn',
        sourceOrDestination: 'Restaurant',
      );

      final json = transaction.toJson();

      expect(json['id'], 'txn1');
      expect(json['type'], 'expense');
      expect(json['amount'], 250000.0);
      expect(json['categoryId'], 'cat_food');
      expect(json['description'], 'Ăn tối');
      expect(json['attachmentPath'], '/path/to/receipt.jpg');
      expect(json['paymentMethod'], 'cash');
      expect(json['location'], 'Nhà hàng ABC');
      expect(json['notes'], 'Ăn với bạn');
      expect(json['sourceOrDestination'], 'Restaurant');
    });

    test('fromJson xử lý các giá trị mặc định đúng cách', () {
      final json = {
        'id': 'txn1',
        'type': 'expense',
        'amount': 250000.0,
        'categoryId': 'cat_food',
        'description': 'Ăn tối',
        'date': '2025-12-15T00:00:00.000Z',
        'createdAt': '2025-12-15T00:00:00.000Z',
        'updatedAt': '2025-12-15T00:00:00.000Z',
      };

      final transaction = TransactionModel.fromJson(json);

      expect(transaction.attachmentPath, null);
      expect(transaction.paymentMethod, null);
      expect(transaction.location, null);
    });

    test('copyWith cập nhật các trường một cách chính xác', () {
      final original = TransactionModel(
        id: 'txn1',
        type: 'expense',
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
      expect(updated.paymentMethod, original.paymentMethod);
    });

    test('Transaction với attachment path', () {
      final transactionWithAttachment = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 500000.0,
        categoryId: 'cat_shopping',
        description: 'Mua sắm',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attachmentPath: '/storage/emulated/0/Pictures/receipt_001.jpg',
      );

      expect(transactionWithAttachment.attachmentPath, '/storage/emulated/0/Pictures/receipt_001.jpg');
    });

    test('Transaction với location', () {
      final transactionWithLocation = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        location: 'Nha Trang',
      );

      expect(transactionWithLocation.location, 'Nha Trang');
    });

    test('Income transaction có sourceOrDestination', () {
      final incomeTransaction = TransactionModel(
        id: 'txn1',
        type: 'income',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        sourceOrDestination: 'Công ty ABC',
      );

      expect(incomeTransaction.sourceOrDestination, 'Công ty ABC');
    });

    test('Round-trip JSON serialization giữ nguyên tất cả dữ liệu', () {
      final original = TransactionModel(
        id: 'txn_complex',
        type: 'expense',
        amount: 1250000.0,
        categoryId: 'cat_travel',
        description: 'Chuyến du lịch',
        date: DateTime(2025, 12, 15, 14, 30, 0),
        createdAt: DateTime(2025, 12, 15, 10, 0, 0),
        updatedAt: DateTime(2025, 12, 16, 11, 0, 0),
        attachmentPath: '/path/to/receipt.jpg',
        paymentMethod: 'credit_card',
        location: 'Nha Trang',
        notes: 'Du lịch với gia đình',
        sourceOrDestination: 'Khách sạn ABC',
      );

      final json = original.toJson();
      final restored = TransactionModel.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.type, original.type);
      expect(restored.amount, original.amount);
      expect(restored.categoryId, original.categoryId);
      expect(restored.description, original.description);
      expect(restored.attachmentPath, original.attachmentPath);
      expect(restored.paymentMethod, original.paymentMethod);
      expect(restored.location, original.location);
      expect(restored.notes, original.notes);
      expect(restored.sourceOrDestination, original.sourceOrDestination);
    });

    test('Transaction amount luôn dương', () {
      final transaction = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(transaction.amount, greaterThan(0));
    });

    test('Nhiều transactions có thể tồn tại', () {
      final transaction1 = TransactionModel(
        id: 'txn1',
        type: 'income',
        amount: 15000000.0,
        categoryId: 'cat_salary',
        description: 'Lương tháng 12',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final transaction2 = TransactionModel(
        id: 'txn2',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final transaction3 = TransactionModel(
        id: 'txn3',
        type: 'expense',
        amount: 5000000.0,
        categoryId: 'cat_rent',
        description: 'Tiền thuê nhà',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(transaction1.id, 'txn1');
      expect(transaction2.id, 'txn2');
      expect(transaction3.id, 'txn3');
    });

    test('Transaction description không trống', () {
      final transaction = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(transaction.description, isNotEmpty);
    });

    test('Transaction date được lưu trữ chính xác', () {
      final date = DateTime(2025, 12, 15, 14, 30, 0);
      final transaction = TransactionModel(
        id: 'txn1',
        type: 'expense',
        amount: 250000.0,
        categoryId: 'cat_food',
        description: 'Ăn tối',
        date: date,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(transaction.date, date);
    });
  });
}
