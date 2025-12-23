# Hướng dẫn chạy Tests - My Finance App

## 📋 Tóm tắt

```
Folder test/unit_test/           → Unit Tests (104 tests)
Folder test/integration_test/    → Integration Tests (31 tests)
Folder test/tools/               → Test case exporter scripts
```

**Không ảnh hưởng lẫn nhau - có thể chạy độc lập!** ✅

## 🧪 UNIT TESTS (Test từng function/class)

### Nơi chứa files
```
test/
├── unit_test/
│   ├── budget_model_test.dart       (21 tests)
│   ├── category_model_test.dart     (12 tests)
│   ├── expense_model_test.dart      (10 tests)
│   ├── income_model_test.dart       (12 tests)
│   ├── payment_method_model_test.dart (14 tests)
│   ├── transaction_model_test.dart  (15 tests)
│   └── user_model_test.dart         (20 tests)
├── integration_test/
│   ├── app_test.dart
│   ├── budget_test.dart
│   ├── category_test.dart
│   ├── expense_test.dart
│   ├── income_test.dart
│   ├── test_helpers.dart
│   └── README.md
├── tools/
│   ├── test_case_exporter_csv.dart
│   ├── test_case_exporter_excel.dart
│   └── test_case_exporter_html.dart
├── UNIT_TEST_GUIDE.md
└── TEST_GUIDE.md (file này)
```

### Chạy Unit Tests

**Chạy tất cả unit tests:**
```bash
flutter test test/unit_test/
```

**Chạy một file cụ thể:**
```bash
flutter test test/unit_test/budget_model_test.dart
```

**Chạy một test cụ thể:**
```bash
flutter test test/unit_test/models/budget_model_test.dart -n "should calculate percentage correctly"
```

**Xem chi tiết output:**
```bash
flutter test test/unit_test/ --verbose
```

**Tính coverage:**
```bash
flutter test test/unit_test/ --coverage
```

---

## 🎬 INTEGRATION TESTS (Test toàn flow ứng dụng)

### Nơi chứa files
```
integration_test/
├── app_test.dart       (9 tests)
├── budget_test.dart    (6 tests)
├── expense_test.dart   (7 tests)
├── income_test.dart    (4 tests)
├── category_test.dart  (5 tests)
├── test_helpers.dart   (utilities)
└── README.md          (detailed guide)
```

### Chạy Integration Tests

**Trên Windows - Dùng Web Platform (đơn giản nhất):**
```bash
# Chạy tất cả
flutter test test/integration_test/ --web

# Chạy file cụ thể
flutter test test/integration_test/budget_test.dart --web

# Xem verbose
flutter test test/integration_test/ --web --verbose
```

**Trên Windows - Dùng Desktop Platform:**
```bash
flutter config --enable-windows-desktop
flutter test test/integration_test/ -d windows
```

---

## 🔄 Chạy cả Unit & Integration Tests

### Sequential (từng cái một)
```bash
# Unit tests trước
flutter test test/unit_test/

# Sau đó integration tests
flutter test test/integration_test/ --web
```

### Cùng lúc (nếu máy đủ mạnh)
```bash
# Terminal 1: Unit tests
flutter test test/unit_test/

# Terminal 2 (mở terminal mới): Integration tests
flutter test test/integration_test/ --web
```

---

## 📊 Thống kê Tests

| Loại | File | Số tests | Chạy lệnh |
|------|------|----------|-----------|
| Unit | test/models/budget_model_test.dart | 21 | `flutter test test/models/budget_model_test.dart` |
| Unit | test/models/category_model_test.dart | 12 | `flutter test test/models/category_model_test.dart` |
| Unit | test/models/expense_model_test.dart | 10 | `flutter test test/models/expense_model_test.dart` |
| Unit | test/models/income_model_test.dart | 12 | `flutter test test/models/income_model_test.dart` |
| Unit | test/models/payment_method_model_test.dart | 14 | `flutter test test/models/payment_method_model_test.dart` |
| Unit | test/models/transaction_model_test.dart | 15 | `flutter test test/models/transaction_model_test.dart` |
| Unit | test/models/user_model_test.dart | 20 | `flutter test test/models/user_model_test.dart` |
| **Unit TOTAL** | - | **104** | `flutter test test/` |
| Integration | integration_test/app_test.dart | 9 | `flutter test integration_test/app_test.dart --web` |
| Integration | integration_test/budget_test.dart | 6 | `flutter test integration_test/budget_test.dart --web` |
| Integration | integration_test/expense_test.dart | 7 | `flutter test integration_test/expense_test.dart --web` |
| Integration | integration_test/income_test.dart | 4 | `flutter test integration_test/income_test.dart --web` |
| Integration | integration_test/category_test.dart | 5 | `flutter test integration_test/category_test.dart --web` |
| **Integration TOTAL** | - | **31** | `flutter test integration_test/ --web` |
| **TỔNG CỘNG** | - | **135** | - |

---

## ✨ Chi tiết từng loại test

### Unit Tests là gì?
- Test **từng function/method** riêng lẻ
- Sử dụng **Mockito** để mock dependencies
- **Không cần UI**, chạy nhanh (< 10 giây)
- Ví dụ: Test `Budget.calculatePercentage()` có đúng không

```dart
test('should calculate percentage correctly', () {
  final budget = Budget(name: 'Test', spent: 50, limit: 100);
  expect(budget.percentageUsed, 0.5);
});
```

### Integration Tests là gì?
- Test **toàn flow ứng dụng** (như user thực sự dùng)
- **Cần UI**, test thực tế mà người dùng làm
- Chạy chậm hơn (30-60 giây tùy test)
- Ví dụ: User tạo budget → Thêm expense → Kiểm tra status

```dart
testWidgets('Create budget and verify', (WidgetTester tester) async {
  await tester.pumpWidget(const MyFinanceApp());
  
  // Tap nút add
  await tester.tap(find.byIcon(Icons.add));
  
  // Nhập data
  await tester.enterText(find.byType(TextField), 'Tháng 1');
  
  // Verify
  expect(find.text('Tháng 1'), findsOneWidget);
});
```

---

## 🎯 Chạy test trên VS Code

### Cách 1: Command Palette

1. Nhấn `Ctrl + Shift + P`
2. Gõ "Flutter: Run Tests"
3. Chọn

### Cách 2: Terminal (Recommended)

1. Nhấn `` Ctrl + ` `` (mở terminal)
2. Gõ lệnh test
3. Xem kết quả

### Cách 3: CodeLens (Trực tiếp trên file)

Khi mở file `budget_model_test.dart`:
- Nếu có CodeLens, sẽ thấy link "Run" trên mỗi test
- Clic vào để chạy test đó

---

## 🚨 Lỗi thường gặp & Cách fix

### ❌ "Could not find tests"
**Nguyên nhân:** File path sai
**Fix:**
```bash
# Đúng
flutter test test/models/budget_model_test.dart

# Sai (không có)
flutter test test/budget_model_test.dart
```

### ❌ "No tests found in..."
**Nguyên nhân:** File không có test function
**Fix:** Kiểm tra file có `testWidgets()` hoặc `test()` không

### ❌ "Cannot find Chrome" (Integration tests)
**Nguyên nhân:** Browser không tìm thấy
**Fix:** Dùng Windows desktop
```bash
flutter test integration_test/ -d windows
```

### ❌ "Timeout waiting for widget"
**Nguyên nhân:** App chạy chậm
**Fix:** Tăng timeout
```dart
await tester.pumpAndSettle(const Duration(seconds: 5));
```

---

## 📈 Quick Reference

```bash
# Unit Tests
flutter test test/unit_test/                                    # Tất cả unit tests
flutter test test/unit_test/budget_model_test.dart            # Một file
flutter test test/unit_test/ --verbose                        # Chi tiết
flutter test test/unit_test/ --coverage                       # Coverage report

# Integration Tests (Web)
flutter test test/integration_test/ --web                # Tất cả
flutter test test/integration_test/budget_test.dart --web # Một file

# Integration Tests (Desktop)
flutter test test/integration_test/ -d windows           # Tất cả
flutter test test/integration_test/budget_test.dart -d windows

# Chạy app (để test trực tiếp)
flutter run                # Chạy app bình thường
flutter run --web         # Chạy trên web
```

---

## 🔗 Tài liệu thêm

- **Unit Tests:** Xem [test/UNIT_TEST_GUIDE.md](test/UNIT_TEST_GUIDE.md)
- **Integration Tests:** Xem [integration_test/README.md](integration_test/README.md)
- **Flutter Testing Docs:** https://flutter.dev/docs/testing

---

**Tạo ngày:** 2024
**Cuối cập nhật:** 2024
**Trạng thái:** ✅ Hoạt động
