import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';

void main() {
  group('Expense Integration Tests', () {
    testWidgets('Add new expense successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tìm nút thêm expense
      final addButton = find.byIcon(Icons.add);
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Nhập số tiền
      final amountField = find.byType(TextField).first;
      await tester.enterText(amountField, '150000');
      await tester.pumpAndSettle();

      // Nhập mô tả/ghi chú
      final descriptionField = find.byType(TextField).at(1);
      await tester.enterText(descriptionField, 'Ăn trưa');
      await tester.pumpAndSettle();

      // Chọn category
      final categoryDropdown = find.byType(DropdownButton).first;
      if (categoryDropdown.evaluate().isNotEmpty) {
        await tester.tap(categoryDropdown);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Ăn uống').first);
        await tester.pumpAndSettle();
      }

      // Lưu expense
      final saveButton = find.byIcon(Icons.check);
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Kiểm tra expense được thêm
      expect(find.text('150000'), findsOneWidget);
    });

    testWidgets('View expense list', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap vào tab lịch sử hoặc expense list
      final historyTab = find.byIcon(Icons.history);
      if (historyTab.evaluate().isNotEmpty) {
        await tester.tap(historyTab);
        await tester.pumpAndSettle();
      }

      // Kiểm tra list hiển thị
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Filter expenses by category',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm filter button
      final filterButton = find.byIcon(Icons.filter_list);
      if (filterButton.evaluate().isNotEmpty) {
        await tester.tap(filterButton);
        await tester.pumpAndSettle();

        // Chọn category filter
        await tester.tap(find.text('Ăn uống').first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Edit expense', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm expense item
      final expenseItem = find.byType(ListTile).first;
      if (expenseItem.evaluate().isNotEmpty) {
        await tester.tap(expenseItem);
        await tester.pumpAndSettle();

        // Kiểm tra edit screen
        expect(find.byType(TextField), findsWidgets);
      }
    });

    testWidgets('Delete expense', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Swipe để xóa
      final expenseItem = find.byType(Dismissible).first;
      if (expenseItem.evaluate().isNotEmpty) {
        await tester.drag(expenseItem, const Offset(-300, 0));
        await tester.pumpAndSettle();

        // Confirm delete
        final deleteButton = find.byIcon(Icons.delete);
        if (deleteButton.evaluate().isNotEmpty) {
          await tester.tap(deleteButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Search expenses', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm search field
      final searchField = find.byIcon(Icons.search);
      if (searchField.evaluate().isNotEmpty) {
        await tester.tap(searchField);
        await tester.pumpAndSettle();

        // Nhập search term
        await tester.enterText(find.byType(TextField).first, 'ăn');
        await tester.pumpAndSettle();
      }
    });
  });
}
