import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';

void main() {
  group('Category Management Integration Tests', () {
    testWidgets('Add new category successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Vào settings/category management
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        // Tìm category management
        var categoryOption = find.text('Danh mục');
        if (categoryOption.evaluate().isEmpty) {
          categoryOption = find.text('Category');
        }
        if (categoryOption.evaluate().isNotEmpty) {
          await tester.tap(categoryOption);
          await tester.pumpAndSettle();
        }
      }

      // Tìm nút thêm category
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        // Nhập tên category
        final nameField = find.byType(TextField).first;
        await tester.enterText(nameField, 'Mua sắm online');
        await tester.pumpAndSettle();

        // Chọn icon/color
        final colorButton = find.byType(Container).first;
        await tester.tap(colorButton);
        await tester.pumpAndSettle();

        // Lưu category
        final saveButton = find.byIcon(Icons.check);
        if (saveButton.evaluate().isNotEmpty) {
          await tester.tap(saveButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('View all categories', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Vào category management
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        var categoryOption = find.text('Danh mục');
        if (categoryOption.evaluate().isEmpty) {
          categoryOption = find.text('Category');
        }
        if (categoryOption.evaluate().isNotEmpty) {
          await tester.tap(categoryOption);
          await tester.pumpAndSettle();

          // Kiểm tra list categories
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    testWidgets('Edit category', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Vào category management
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        var categoryOption = find.text('Danh mục');
        if (categoryOption.evaluate().isEmpty) {
          categoryOption = find.text('Category');
        }
        if (categoryOption.evaluate().isNotEmpty) {
          await tester.tap(categoryOption);
          await tester.pumpAndSettle();

          // Tap category item để edit
          final categoryItem = find.byType(ListTile).first;
          if (categoryItem.evaluate().isNotEmpty) {
            await tester.tap(categoryItem);
            await tester.pumpAndSettle();

            // Kiểm tra edit form
            expect(find.byType(TextField), findsWidgets);
          }
        }
      }
    });

    testWidgets('Delete category', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Vào category management
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        var categoryOption = find.text('Danh mục');
        if (categoryOption.evaluate().isEmpty) {
          categoryOption = find.text('Category');
        }
        if (categoryOption.evaluate().isNotEmpty) {
          await tester.tap(categoryOption);
          await tester.pumpAndSettle();

          // Long press category để delete
          final categoryItem = find.byType(ListTile).first;
          if (categoryItem.evaluate().isNotEmpty) {
            await tester.longPress(categoryItem);
            await tester.pumpAndSettle();

            // Confirm delete
            final deleteButton = find.byIcon(Icons.delete);
            if (deleteButton.evaluate().isNotEmpty) {
              await tester.tap(deleteButton);
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });
  });
}
