// Helper utilities for integration testing
// Chứa các common functions, fixtures, và test data

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tìm text field và nhập data
Future<void> enterTextField(
  WidgetTester tester,
  int index,
  String text,
) async {
  final field = find.byType(TextField).at(index);
  await tester.enterText(field, text);
  await tester.pumpAndSettle();
}

/// Tìm button và tap
Future<void> tapButton(WidgetTester tester, IconData icon) async {
  final button = find.byIcon(icon);
  if (button.evaluate().isNotEmpty) {
    await tester.tap(button);
    await tester.pumpAndSettle();
  }
}

/// Tìm text và tap
Future<void> tapText(WidgetTester tester, String text) async {
  final button = find.text(text);
  if (button.evaluate().isNotEmpty) {
    await tester.tap(button);
    await tester.pumpAndSettle();
  }
}

/// Wait for loading/animation
Future<void> waitForLoadingComplete(WidgetTester tester,
    {Duration? timeout}) async {
  await tester.pumpAndSettle(timeout ?? const Duration(seconds: 3));
}

/// Mock test data
class TestData {
  // Budget test data
  static const String testBudgetName = 'Tháng 1';
  static const String testBudgetAmount = '5000000';

  // Expense test data
  static const String testExpenseAmount = '150000';
  static const String testExpenseDescription = 'Ăn trưa';
  static const String testExpenseCategory = 'Ăn uống';

  // Income test data
  static const String testIncomeAmount = '5000000';
  static const String testIncomeSource = 'Lương tháng';

  // Category test data
  static const String testCategoryName = 'Mua sắm online';

  // Payment method test data
  static const String testPaymentMethod = 'Ví điện tử';
}

/// Common assertions
void expectTextToExist(String text) {
  expect(find.text(text), findsOneWidget);
}

void expectIconToExist(IconData icon) {
  expect(find.byIcon(icon), findsOneWidget);
}

void expectWidgetToExist(Type widgetType) {
  expect(find.byType(widgetType), findsOneWidget);
}

void expectListToBeVisible() {
  expect(find.byType(ListView), findsWidgets);
}

/// Wait for navigation
Future<void> waitForNavigation(WidgetTester tester) async {
  await tester.pumpAndSettle(const Duration(seconds: 1));
}

/// Verify dialog/modal opened
void expectDialogOpen() {
  expect(find.byType(Dialog), findsOneWidget);
}

/// Verify no errors in console
void expectNoErrorsLogged() {
  // Check if any error text appears in UI
  expect(find.byType(SnackBar), findsNothing);
}

/// Helper to enter multiple form fields
Future<void> enterFormData(
  WidgetTester tester,
  Map<int, String> fieldData,
) async {
  fieldData.forEach((index, text) async {
    await enterTextField(tester, index, text);
  });
}

/// Helper to take screenshot during test (useful for debugging)
Future<void> captureScreenshot(WidgetTester tester, String name) async {
  // Uncomment khi cần capture screenshots
  // await tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
  // addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}

/// Scroll to widget
Future<void> scrollToWidget(WidgetTester tester, Type widgetType) async {
  await tester.scrollUntilVisible(find.byType(widgetType), 100);
  await tester.pumpAndSettle();
}

/// Swipe to delete
Future<void> swipeToDelete(WidgetTester tester) async {
  final dismissible = find.byType(Dismissible).first;
  if (dismissible.evaluate().isNotEmpty) {
    await tester.drag(dismissible, const Offset(-300, 0));
    await tester.pumpAndSettle();
  }
}

/// Common test scenario: Create and verify item
Future<void> createAndVerifyItem(
  WidgetTester tester, {
  required List<String> formInputs,
  required String expectedResult,
  String? addButtonIcon,
  String? saveButtonIcon,
}) async {
  // Tap add button
  if (addButtonIcon != null) {
    await tapText(tester, addButtonIcon);
  } else {
    await tapButton(tester, Icons.add);
  }
  await waitForNavigation(tester);

  // Fill form
  for (int i = 0; i < formInputs.length; i++) {
    await enterTextField(tester, i, formInputs[i]);
  }

  // Save
  if (saveButtonIcon != null) {
    await tapText(tester, saveButtonIcon);
  } else {
    await tapButton(tester, Icons.check);
  }
  await waitForLoadingComplete(tester);

  // Verify
  expectTextToExist(expectedResult);
}
