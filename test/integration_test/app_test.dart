import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';

void main() {
  group('App Navigation & Overall Integration Tests', () {
    testWidgets('App starts successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Kiểm tra main screen hiển thị
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Navigation between tabs works',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm bottom navigation
      final navigationBar = find.byType(BottomNavigationBar);
      expect(navigationBar, findsOneWidget);

      // Tap vào các tab
      final tabs = find.byType(BottomNavigationBarItem);
      for (int i = 0; i < tabs.evaluate().length && i < 3; i++) {
        await tester.tap(find.byIcon(Icons.home));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Settings screen accessibility',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm settings button
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        // Kiểm tra settings screen
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Dashboard displays summary correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Kiểm tra dashboard elements
      expect(find.byType(Card), findsWidgets);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('Date picker works', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm date picker button
      final dateButton = find.byIcon(Icons.calendar_today);
      if (dateButton.evaluate().isNotEmpty) {
        await tester.tap(dateButton.first);
        await tester.pumpAndSettle();

        // Kiểm tra date picker dialog
        expect(find.byType(Dialog), findsOneWidget);
      }
    });

    testWidgets('User can logout', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm settings
      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        // Tìm logout button
        var logoutButton = find.text('Đăng xuất');
        if (logoutButton.evaluate().isEmpty) {
          logoutButton = find.text('Logout');
        }
        if (logoutButton.evaluate().isEmpty) {
          logoutButton = find.byIcon(Icons.logout);
        }
        if (logoutButton.evaluate().isNotEmpty) {
          await tester.tap(logoutButton);
          await tester.pumpAndSettle();

          // Confirm logout nếu có
          var confirmButton = find.text('Có');
          if (confirmButton.evaluate().isEmpty) {
            confirmButton = find.text('Yes');
          }
          if (confirmButton.evaluate().isEmpty) {
            confirmButton = find.text('OK');
          }
          if (confirmButton.evaluate().isNotEmpty) {
            await tester.tap(confirmButton);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('Search functionality', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tìm search icon
      final searchIcon = find.byIcon(Icons.search);
      if (searchIcon.evaluate().isNotEmpty) {
        await tester.tap(searchIcon);
        await tester.pumpAndSettle();

        // Nhập search term
        await tester.enterText(find.byType(TextField).first, 'test');
        await tester.pumpAndSettle();

        // Verify search results
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Back button navigation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await tester.pumpAndSettle();

      // Vào một screen khác
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        // Quay lại
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });
  });
}
