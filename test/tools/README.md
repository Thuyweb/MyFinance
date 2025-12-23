# Test Case Exporter Tools

Các script để xuất test case data sang các định dạng khác nhau.

## 📁 Files

### 1. test_case_exporter_csv.dart
Export tất cả test cases sang **CSV format** (Excel compatible)

**Chạy:**
```bash
dart run test/tools/test_case_exporter_csv.dart
```

**Output:** `TestCases_Report.csv`

### 2. test_case_exporter_excel.dart
Export tất cả test cases sang **Excel format** với Steps column

**Chạy:**
```bash
dart run test/tools/test_case_exporter_excel.dart
```

**Output:** `TestCases_Report.csv` (Excel compatible)

### 3. test_case_exporter_html.dart
Export tất cả test cases sang **HTML format** cho web viewing

**Chạy:**
```bash
dart run test/tools/test_case_exporter_html.dart
```

**Output:** `TestCases_Report.html`

## 📊 Test Cases Data

Tất cả 3 exporter đều lấy dữ liệu từ 7 model files:

- `test/unit_test/budget_model_test.dart` (21 tests)
- `test/unit_test/category_model_test.dart` (12 tests)
- `test/unit_test/expense_model_test.dart` (10 tests)
- `test/unit_test/income_model_test.dart` (12 tests)
- `test/unit_test/payment_method_model_test.dart` (14 tests)
- `test/unit_test/transaction_model_test.dart` (15 tests)
- `test/unit_test/user_model_test.dart` (20 tests)

**Tổng cộng:** 104 test cases

## 🔄 Khi nào chạy?

- Khi thêm test case mới → chạy exporter để cập nhật báo cáo
- Khi cần refresh báo cáo → chạy exporter
- Khi cần export sang format khác → chạy exporter tương ứng

## 📝 Output Files

Output files được tạo ở **root folder**:
- `TestCases_Report.csv` - CSV format (shared across CSV & Excel exporter)
- `TestCases_Report.html` - HTML format

---

**Tạo ngày:** 2024
**Trạng thái:** Active ✅
