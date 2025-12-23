# 📚 HƯỚNG DẪN UNIT TESTS CHUẨN

## ✅ Tiêu chí Unit Test Chuẩn (FIRST Principle)

### 1. **FAST** (Nhanh)
- Chạy trong vài milliseconds
- Không gọi external APIs, databases, networks
- Không có I/O operations

### 2. **INDEPENDENT** (Độc lập)
- Mỗi test chạy độc lập, không phụ thuộc test khác
- Có thể chạy theo bất kỳ thứ tự nào
- Không chia sẻ state giữa các tests

### 3. **REPEATABLE** (Lặp lại được)
- Chạy lại nhiều lần, kết quả luôn như nhau
- Không phụ thuộc vào thời gian hệ thống
- Không phụ thuộc vào random data

### 4. **SELF-VALIDATING** (Tự đánh giá)
- Kết quả rõ ràng: PASS hoặc FAIL
- Không cần check console output
- Assertions rõ ràng và specific

### 5. **TIMELY** (Đúng lúc)
- Viết cùng lúc với production code
- Giúp thiết kế code tốt hơn
- Phát hiện bugs sớm

---

## 📋 Cấu trúc Unit Test Chuẩn

### Pattern: Arrange → Act → Assert (AAA)

```dart
test('Mô tả test rõ ràng', () {
  // ARRANGE: Chuẩn bị data/fixtures cần thiết
  final category = CategoryModel(
    id: 'test1',
    name: 'Thức ăn',
    type: 'expense',
    // ...
  );

  // ACT: Thực hiện action cần kiểm tra
  final json = category.toJson();
  final restored = CategoryModel.fromJson(json);

  // ASSERT: Kiểm tra kết quả
  expect(restored.id, equals(category.id));
  expect(restored.name, equals(category.name));
});
```

### Sử dụng setUp() và tearDown()

```dart
void main() {
  group('CategoryModel Tests', () {
    late CategoryModel testCategory;
    late DateTime testTime;

    setUp(() {
      // Chạy TRƯỚC mỗi test
      testTime = DateTime(2025, 12, 21);
      testCategory = CategoryModel(
        id: 'test1',
        name: 'Thức ăn',
        type: 'expense',
        createdAt: testTime,
        updatedAt: testTime,
      );
    });

    tearDown(() {
      // Chạy SAU mỗi test - cleanup
      // Nếu có databases, file systems, v.v.
    });

    test('Test 1', () { /* ... */ });
    test('Test 2', () { /* ... */ });
  });
}
```

---

## 🎯 Các Matchers Tốt Nhất

### Thay vì:
```dart
expect(value == true, true);           // ❌ Không rõ ràng
expect(value.isEmpty, true);           // ❌ Không rõ ràng
```

### Dùng:
```dart
expect(value, isTrue);                 // ✅ Rõ ràng hơn
expect(value, isEmpty);                // ✅ Rõ ràng hơn
expect(value, equals('expected'));     // ✅ Specific
expect(value, contains('substring'));  // ✅ Specific
expect(value, containsPair('key', 'val')); // ✅ Specific
expect(value, greaterThan(10));        // ✅ Specific
expect(value, isNull);                 // ✅ Specific
expect(value, isNotNull);              // ✅ Specific
```

---

## 🛡️ Tránh những Lỗi Thường Gặp

### ❌ KHÔNG NÊN:

1. **Test quá nhiều thứ trong 1 test**
```dart
test('Test tất cả', () {
  // ❌ Kiểm tra quá nhiều - nếu fail không biết cái nào sai
  expect(obj.id, equals('1'));
  expect(obj.name, equals('Test'));
  expect(obj.type, equals('expense'));
  expect(obj.isActive, isTrue);
});
```

2. **Dùng DateTime.now() trong tests**
```dart
test('Date test', () {
  final expense = ExpenseModel(
    // ...
    date: DateTime.now(), // ❌ Random - khó test lại
  );
});
```

3. **Gọi external services**
```dart
test('API test', () {
  final result = apiService.fetchData(); // ❌ Phụ thuộc network
});
```

4. **Chia sẻ state giữa tests**
```dart
late List<Expense> expenses; // ❌ Shared state
test('Test 1', () {
  expenses.add(expense); // Ảnh hưởng test khác
});
```

### ✅ NÊN LÀM:

1. **Test một điều duy nhất**
```dart
test('CategoryModel khởi tạo với đúng ID', () {
  final category = CategoryModel(
    id: 'cat1',
    // ...
  );
  expect(category.id, equals('cat1'));
});
```

2. **Dùng fixed DateTime cho tests**
```dart
test('Date test', () {
  final testTime = DateTime(2025, 12, 21, 10, 30);
  final expense = ExpenseModel(
    date: testTime, // ✅ Predictable
  );
});
```

3. **Mock external dependencies**
```dart
test('Service test', () {
  // Mock the API service
  final mockService = MockApiService();
  when(mockService.fetchData()).thenReturn(testData);
  
  final result = mockService.fetchData();
  expect(result, equals(testData));
});
```

4. **Setup mỗi test độc lập**
```dart
setUp(() {
  expenses = []; // ✅ Fresh data mỗi test
});
```

---

## 📊 Coverage Goals

| Component | Target Coverage | Tầm Quan Trọng |
|-----------|-----------------|----------------|
| Models (toJson, fromJson) | 90%+ | Cao |
| Getters & Setters | 85%+ | Trung |
| Business Logic | 85%+ | Cao |
| UI Components | 50-70% | Thấp |
| External APIs | 80%+ (với mocks) | Cao |

---

## 🚀 Chạy Tests

### Chạy tất cả tests:
```bash
flutter test
```

### Chạy test cụ thể:
```bash
flutter test test/test/category_model_test.dart
```

### Chạy với verbose output:
```bash
flutter test -v
```

### Chạy với coverage:
```bash
flutter test --coverage
```

### Chạy và xem report:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 📝 Test Naming Convention

### ✅ TÊN TEST TỐT:
```dart
test('CategoryModel khởi tạo với đúng các giá trị', () { ... });
test('fromJson xử lý giá trị null/optional đúng cách', () { ... });
test('copyWith tạo object mới mà không làm thay đổi object cũ', () { ... });
test('JSON serialization round-trip bảo tồn tất cả dữ liệu', () { ... });
```

### ❌ TÊN TEST TỒI:
```dart
test('test1', () { ... });
test('CategoryModel test', () { ... });
test('JSON test', () { ... });
```

---

## 🎓 Test Checklist

Trước khi commit, kiểm tra:

- [ ] Tất cả tests đều PASS
- [ ] Mỗi test chỉ test **1 điều duy nhất**
- [ ] Sử dụng **setUp/tearDown** cho fixtures
- [ ] Dùng **matchers rõ ràng** (isTrue, equals, etc)
- [ ] **Không gọi** external APIs/databases
- [ ] **Không dùng** DateTime.now()
- [ ] Tests **độc lập** và chạy được theo bất kỳ thứ tự
- [ ] Tên test **mô tả rõ ràng** những gì đang test
- [ ] **Coverage >= 80%** cho critical code

---

## 📚 Tham Khảo Thêm

- [Dart Testing Guide](https://dart.dev/guides/testing)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Unit Test Best Practices](https://medium.com/@scottsanche/unit-test-best-practices-f6393d6e6231)
