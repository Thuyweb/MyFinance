import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';

void main() {
  group('Income Integration Tests', () {
    testWidgets('Add new income successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tìm nút thêm income
      final addButton = find.byIcon(Icons.add);
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Kiểm tra có tùy chọn Income/Expense
      var incomeOption = find.text('Thu nhập');
      if (incomeOption.evaluate().isEmpty) {
        incomeOption = find.text('Income');
      }
      if (incomeOption.evaluate().isNotEmpty) {
        await tester.tap(incomeOption);
        await tester.pumpAndSettle();
      }

      // Nhập số tiền
      final amountField = find.byType(TextField).first;
      await tester.enterText(amountField, '5000000');
      await tester.pumpAndSettle();

      // Nhập nguồn thu
      final sourceField = find.byType(TextField).at(1);
      await tester.enterText(sourceField, 'Lương tháng');
      await tester.pumpAndSettle();

      // Lưu income
      final saveButton = find.byIcon(Icons.check);
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Kiểm tra income được thêm
      expect(find.text('5000000'), findsOneWidget);
    });

    testWidgets('View income list', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap vào income tab
      final incomeTab = find.byIcon(Icons.trending_up);
      if (incomeTab.evaluate().isNotEmpty) {
        await tester.tap(incomeTab);
        await tester.pumpAndSettle();
      }

      // Kiểm tra list hiển thị
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Edit income', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm income item
      final incomeItem = find.byType(ListTile).first;
      if (incomeItem.evaluate().isNotEmpty) {
        await tester.tap(incomeItem);
        await tester.pumpAndSettle();

        // Kiểm tra edit screen
        expect(find.byType(TextField), findsWidgets);
      }
    });

    testWidgets('Set recurring income', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tìm nút thêm income
      final addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Chọn recurring option
      final recurringCheckbox = find.byType(Checkbox).first;
      if (recurringCheckbox.evaluate().isNotEmpty) {
        await tester.tap(recurringCheckbox);
        await tester.pumpAndSettle();

        // Chọn recurring pattern
        final patternDropdown = find.byType(DropdownButton).first;
        if (patternDropdown.evaluate().isNotEmpty) {
          await tester.tap(patternDropdown);
          await tester.pumpAndSettle();
          await tester.tap(find.text('Hàng tháng').first);
          await tester.pumpAndSettle();
        }
      }
    });
  });
}
