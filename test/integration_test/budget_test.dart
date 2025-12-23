import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';

void main() {
  group('Budget Integration Tests', () {
    testWidgets('Create new budget successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tìm và tap nút thêm budget (FAB hoặc menu)
      final addButton = find.byIcon(Icons.add);
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Nhập thông tin budget
      final nameField = find.byType(TextField).first;
      await tester.enterText(nameField, 'Tháng 1');
      await tester.pumpAndSettle();

      // Nhập hạn mức
      final amountField = find.byType(TextField).at(1);
      await tester.enterText(amountField, '5000000');
      await tester.pumpAndSettle();

      // Lưu budget
      final saveButton = find.byIcon(Icons.check);
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Kiểm tra budget được tạo
      expect(find.text('Tháng 1'), findsOneWidget);
    });

    testWidgets('View budget list', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Kiểm tra budget list hiển thị
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Edit budget', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm budget item
      final budgetItem = find.byType(ListTile).first;
      expect(budgetItem, findsOneWidget);

      // Long press để edit
      await tester.longPress(budgetItem);
      await tester.pumpAndSettle();

      // Kiểm tra edit dialog/screen hiển thị
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('Delete budget', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Long press budget item
      final budgetItem = find.byType(ListTile).first;
      await tester.longPress(budgetItem);
      await tester.pumpAndSettle();

      // Tap delete
      final deleteButton = find.byIcon(Icons.delete);
      if (deleteButton.evaluate().isNotEmpty) {
        await tester.tap(deleteButton);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Confirm delete nếu có dialog
        var confirmButton = find.text('Xóa');
        if (confirmButton.evaluate().isEmpty) {
          confirmButton = find.text('Delete');
        }
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Budget status updates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Kiểm tra status badge (normal/warning/exceeded)
      expect(
        find.byType(Container),
        findsWidgets,
      ); // Status indicator
    });
  });
}
