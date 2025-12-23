# Integration Tests - Hướng dẫn sử dụng

## 📁 Cấu trúc thư mục

```
test/integration_test/
├── app_test.dart           # Test navigation, overall app flow
├── budget_test.dart        # Test budget CRUD operations
├── category_test.dart      # Test category management
├── expense_test.dart       # Test expense transactions
├── income_test.dart        # Test income management
├── test_helpers.dart       # Common utilities & test data
└── README.md              # File này
```

## 🚀 Chạy Integration Tests

### Phương pháp 1: Web Platform (Recommended for Windows)

**Setup:**
```bash
# Terminal trong VS Code (Ctrl + `)
flutter pub get
```

**Chạy tất cả tests:**
```bash
flutter test test/integration_test/ --target=test/integration_test/app_test.dart --web
```

**Chạy test cụ thể:**
```bash
# Chạy chỉ app_test.dart
flutter test test/integration_test/app_test.dart --web

# Chạy chỉ budget_test.dart
flutter test test/integration_test/budget_test.dart --web

# Chạy chỉ expense_test.dart
flutter test test/integration_test/expense_test.dart --web
```

### Phương pháp 2: Windows Desktop Platform

**Setup:**
```bash
# Enable windows desktop
flutter config --enable-windows-desktop

# Get dependencies
flutter pub get
```

**Chạy tests:**
```bash
flutter test test/integration_test/ --target=test/integration_test/app_test.dart -d windows
```

### Phương pháp 3: Chạy từ terminal (Powershell)

**Tất cả tests:**
```powershell
flutter test test/integration_test/ --web
```

**Một test file:**
```powershell
flutter test test/integration_test/budget_test.dart --web
```

**Xem verbose output:**
```powershell
flutter test test/integration_test/ --web --verbose
```

## 📝 File Test Descriptions

### app_test.dart (9 tests)
- ✅ App launches successfully
- ✅ Navigation between tabs works
- ✅ Settings screen accessibility
- ✅ Dashboard displays summary
- ✅ Date picker works
- ✅ User can logout
- ✅ Search functionality
- ✅ Back button navigation
- ✅ Theme persistence

**Chạy:** `flutter test test/integration_test/app_test.dart --web`

### budget_test.dart (6 tests)
- ✅ Create new budget
- ✅ View budget list
- ✅ Edit budget
- ✅ Delete budget
- ✅ Budget status updates
- ✅ Multiple budget management

**Chạy:** `flutter test test/integration_test/budget_test.dart --web`

### expense_test.dart (7 tests)
- ✅ Add new expense
- ✅ View expense list
- ✅ Filter by category
- ✅ Edit expense
- ✅ Delete expense
- ✅ Search expenses
- ✅ Recurring expenses

**Chạy:** `flutter test test/integration_test/expense_test.dart --web`

### income_test.dart (4 tests)
- ✅ Add new income
- ✅ View income list
- ✅ Edit income
- ✅ Set recurring income

**Chạy:** `flutter test test/integration_test/income_test.dart --web`

### category_test.dart (5 tests)
- ✅ Add new category
- ✅ View all categories
- ✅ Edit category
- ✅ Delete category
- ✅ Use category in transaction

**Chạy:** `flutter test test/integration_test/category_test.dart --web`

## ⚙️ Cấu hình Firebase cho Integration Tests (Optional)

Nếu tests cần access Firebase Firestore:

### Cách 1: Sử dụng Firebase Emulator (Recommended)

```bash
# Install Firebase emulator
npm install -g firebase-tools

# Start emulator (từ project root)
firebase emulators:start --only firestore,auth
```

### Cách 2: Test chỉ UI (không kết nối Firebase)

Tests hiện tại mặc định chỉ test UI layer. Để mock Firebase:

1. Tạo file `integration_test/firebase_mock.dart`:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock Firebase instances nếu cần
```

2. Import trong test file:
```dart
import 'firebase_mock.dart';
```

## 🔍 Troubleshooting

### ❌ "Cannot find Chrome"
**Solution:**
```bash
flutter test integration_test/ --web --dart-define=BROWSER_EXECUTABLE=chromium
```

### ❌ "Timeout waiting for widget"
**Solution:** Tăng timeout trong test
```dart
await tester.pumpAndSettle(const Duration(seconds: 5));
```

### ❌ "Widget not found"
**Solution:** Check widget hierarchy với `find.byType()` hoặc `find.byIcon()`

### ❌ "Test fails on CI/CD"
**Solution:** Disable animations
```bash
flutter test integration_test/ --web --test-randomize-ordering-seed=random
```

## 📊 CI/CD Integration (GitHub Actions)

Tạo `.github/workflows/integration_tests.yml`:

```yaml
name: Integration Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.6.2'
      - run: flutter pub get
      - run: flutter test integration_test/ --web
```

## 🎯 Best Practices

1. **Tách Unit Tests & Integration Tests**
   - ✅ Unit tests: `test/` (không cần UI)
   - ✅ Integration tests: `integration_test/` (full app flow)

2. **Sử dụng test_helpers.dart**
   ```dart
   import 'test_helpers.dart';
   
   await enterTextField(tester, 0, 'test data');
   await tapButton(tester, Icons.check);
   ```

3. **Test realistic scenarios**
   - ✅ User tạo budget → Thêm expense → Check status
   - ✅ Filter by date → Search result
   - ❌ Tránh test quá từng widget riêng

4. **Async handling**
   ```dart
   await tester.pumpAndSettle(const Duration(seconds: 2));
   // Luôn wait cho animations/network calls
   ```

5. **Error recovery**
   ```dart
   if (button.evaluate().isNotEmpty) {
     await tester.tap(button);
   }
   // Tránh crash nếu widget không found
   ```

## 📈 Test Coverage Report

Hiện tại: **31 integration tests**
- Navigation: 9 tests
- Budget: 6 tests
- Expense: 7 tests
- Income: 4 tests
- Category: 5 tests

**Mục tiêu:** 50+ tests covering all major flows

## 🔗 Thêm tests mới

### Template cho test file mới

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance_app/main.dart';
import 'test_helpers.dart';

void main() {
  group('Feature Name Integration Tests', () {
    testWidgets('Test description', (WidgetTester tester) async {
      await tester.pumpWidget(const MyFinanceApp());
      await waitForLoadingComplete(tester);

      // Arrange
      // Act
      // Assert
    });
  });
}
```

## 📞 Hỗ trợ

- Test không chạy? → Kiểm tra `pubspec.yaml` đã có `flutter_test` không
- Widget không found? → Dùng `find.byType()`, `find.byIcon()`, `find.byText()`
- Async timeout? → Tăng `pumpAndSettle()` duration

---

**Tạo ngày:** 2024
**Trạng thái:** Hoạt động ✅
**Phương pháp chạy:** Web Platform (Windows) hoặc Windows Desktop
