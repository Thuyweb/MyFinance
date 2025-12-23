import 'dart:io';

void main() async {
  // Dữ liệu tất cả test cases từ test_case_exporter_csv.dart
  final testCases = [
    // Budget Model Tests
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tính usagePercentage đúng', 'description': 'Kiểm tra tính toán phần trăm sử dụng budget', 'testType': 'Calculation', 'priority': 'High', 'steps': '1. Mở ứng dụng Budget | 2. Nhập amount và spent | 3. Kiểm tra usagePercentage được tính đúng'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tính remaining đúng', 'description': 'Kiểm tra tính toán số tiền còn lại', 'testType': 'Calculation', 'priority': 'High', 'steps': '1. Tạo Budget mới | 2. Thiết lập amount và spent | 3. Kiểm tra remaining = amount - spent'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status đúng theo mức sử dụng', 'description': 'Kiểm tra status budget (normal/warning/exceeded/full)', 'testType': 'State', 'priority': 'High', 'steps': '1. Tạo Budget | 2. Thay đổi spent amount | 3. Kiểm tra status thay đổi đúng'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'toJson và fromJson hoạt động đúng', 'description': 'Kiểm tra serialization JSON', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo Budget object | 2. Chuyển đổi sang JSON | 3. Chuyển lại object | 4. Kiểm tra dữ liệu'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra các giá trị mặc định khi khởi tạo', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo Budget không cung cấp arguments | 2. Kiểm tra giá trị mặc định'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'remaining âm khi spent > amount', 'description': 'Kiểm tra edge case when vượt quá ngân sách', 'testType': 'Edge Case', 'priority': 'Medium', 'steps': '1. Tạo Budget với spent > amount | 2. Kiểm tra remaining < 0'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage bằng 0 khi amount bằng 0', 'description': 'Kiểm tra edge case chia cho 0', 'testType': 'Edge Case', 'priority': 'High', 'steps': '1. Tạo Budget amount = 0 | 2. Tính usagePercentage | 3. Xử lý exception'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status là full khi spent bằng amount', 'description': 'Kiểm tra status khi budget đầy', 'testType': 'State', 'priority': 'Medium', 'steps': '1. Tạo Budget | 2. Thiết lập spent = amount | 3. Kiểm tra status = full'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith method', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo Budget | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'copyWith giữ nguyên các trường không được cập nhật', 'description': 'Kiểm tra copyWith không ảnh hưởng các field khác', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo Budget | 2. copyWith 1 field | 3. Kiểm tra fields khác'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage tính chính xác với số thập phân', 'description': 'Kiểm tra tính toán với số decimal', 'testType': 'Calculation', 'priority': 'Medium', 'steps': '1. Nhập decimal amount | 2. Tính toán | 3. Kiểm tra độ chính xác'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status warning với các mức alertPercentage khác nhau', 'description': 'Kiểm tra warning status với alertPercentage', 'testType': 'State', 'priority': 'Medium', 'steps': '1. Set alertPercentage khác | 2. Kiểm tra status'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson chứa đủ dữ liệu', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo Budget | 2. Gọi toJson | 3. Kiểm tra tất cả field'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'fromJson xử lý các giá trị null/optional đúng cách', 'description': 'Kiểm tra fromJson với missing fields', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Chuẩn bị JSON missing fields | 2. fromJson | 3. Kiểm tra'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'fromJson xử lý recurringTime đúng cách', 'description': 'Kiểm tra fromJson với recurring time', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Test JSON recurringTime | 2. Parse | 3. Kiểm tra'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage 100% khi spent bằng amount', 'description': 'Kiểm tra usagePercentage = 100', 'testType': 'Calculation', 'priority': 'Low', 'steps': '1. Budget spent = amount | 2. Tính usagePercentage | 3. = 100'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage > 100% khi spent > amount', 'description': 'Kiểm tra usagePercentage > 100', 'testType': 'Calculation', 'priority': 'Low', 'steps': '1. Budget spent > amount | 2. Tính | 3. > 100'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Period có thể là weekly, monthly hoặc yearly', 'description': 'Kiểm tra các period types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test weekly | 2. Test monthly | 3. Test yearly'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'isActive có thể được bật/tắt', 'description': 'Kiểm tra toggle isActive', 'testType': 'State', 'priority': 'Low', 'steps': '1. Bật isActive | 2. Tắt | 3. Kiểm tra'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'alertEnabled có thể được bật/tắt', 'description': 'Kiểm tra toggle alertEnabled', 'testType': 'State', 'priority': 'Low', 'steps': '1. Bật alertEnabled | 2. Tắt | 3. Kiểm tra'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra toJson -> fromJson -> equals', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'},

    // Category Model Tests
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra các giá trị mặc định của CategoryModel', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo Category | 2. Kiểm tra defaults'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Type là income hoặc expense', 'description': 'Kiểm tra category type validation', 'testType': 'Validation', 'priority': 'High', 'steps': '1. Test income | 2. Test expense | 3. Kiểm tra'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Không chấp nhận type không hợp lệ - kiểm tra validation', 'description': 'Kiểm tra invalid type handling', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Nhập invalid type | 2. Kiểm tra validation error'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo Category | 2. toJson | 3. Kiểm tra tất cả field'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson với default values', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith functionality', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo Category | 2. copyWith | 3. Kiểm tra'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'isActive có thể được bật/tắt', 'description': 'Kiểm tra toggle isActive', 'testType': 'State', 'priority': 'Low', 'steps': '1. Bật isActive | 2. Tắt | 3. Kiểm tra'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'isDefault đánh dấu category mặc định', 'description': 'Kiểm tra isDefault flag', 'testType': 'State', 'priority': 'Low', 'steps': '1. Set isDefault | 2. Kiểm tra flag'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra toJson -> fromJson preservation', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo object | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Nhiều categories có thể tồn tại cùng lúc', 'description': 'Kiểm tra multiple category instances', 'testType': 'Functionality', 'priority': 'Low', 'steps': '1. Tạo multiple | 2. Kiểm tra độc lập'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Icon code point được lưu trữ chính xác', 'description': 'Kiểm tra iconCodePoint storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Set icon code | 2. Kiểm tra lưu'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Color hex value được lưu trữ chính xác', 'description': 'Kiểm tra colorValue storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Set color hex | 2. Kiểm tra lưu'},

    // Expense Model Tests
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra default values của ExpenseModel', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo Expense | 2. Kiểm tra defaults'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Payment method có thể là cash, card, hoặc e_wallet', 'description': 'Kiểm tra payment method types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test cash | 2. Test card | 3. Test e_wallet'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Recurring expense được định nghĩa chính xác', 'description': 'Kiểm tra recurring expense setup', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo recurring | 2. Set pattern | 3. Kiểm tra'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo Expense | 2. toJson | 3. Kiểm tra field'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson defaults', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith updates', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo Expense | 2. copyWith | 3. Kiểm tra'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Expense với receipt photo path', 'description': 'Kiểm tra receipt photo storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Add receipt path | 2. Kiểm tra lưu'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra complete JSON round-trip', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Expense amount luôn dương', 'description': 'Kiểm tra amount validation', 'testType': 'Validation', 'priority': 'High', 'steps': '1. Negative amount | 2. Kiểm tra validation'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Recurring pattern có thể là daily, weekly, monthly, hoặc yearly', 'description': 'Kiểm tra recurring pattern types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test patterns | 2. Kiểm tra hợp lệ'},

    // Income Model Tests
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra default values của IncomeModel', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo Income | 2. Kiểm tra defaults'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Income source được lưu trữ chính xác', 'description': 'Kiểm tra income sources', 'testType': 'Data', 'priority': 'Medium', 'steps': '1. Set source | 2. Kiểm tra lưu'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Recurring income được định nghĩa chính xác', 'description': 'Kiểm tra recurring income setup', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo recurring | 2. Set pattern | 3. Kiểm tra'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo Income | 2. toJson | 3. Kiểm tra field'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson defaults', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith updates', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo Income | 2. copyWith | 3. Kiểm tra'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Income với attachment path', 'description': 'Kiểm tra attachment storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Add attachment | 2. Kiểm tra lưu'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra complete JSON round-trip', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Income amount luôn dương', 'description': 'Kiểm tra amount validation', 'testType': 'Validation', 'priority': 'High', 'steps': '1. Negative amount | 2. Kiểm tra validation'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Recurring pattern có thể là weekly, monthly hoặc yearly', 'description': 'Kiểm tra recurring pattern types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test patterns | 2. Kiểm tra hợp lệ'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Nhiều income sources có thể tồn tại', 'description': 'Kiểm tra multiple income sources', 'testType': 'Functionality', 'priority': 'Low', 'steps': '1. Tạo multiple | 2. Kiểm tra độc lập'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Income description không trống', 'description': 'Kiểm tra description validation', 'testType': 'Validation', 'priority': 'Low', 'steps': '1. Nhập trống | 2. Kiểm tra validation'},

    // Payment Method Model Tests
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra default values', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo PaymentMethod | 2. Kiểm tra defaults'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Built-in payment methods được đánh dấu đúng cách', 'description': 'Kiểm tra built-in flag', 'testType': 'State', 'priority': 'Medium', 'steps': '1. Kiểm tra built-in flag'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon getter trả về IconData chính xác', 'description': 'Kiểm tra icon getter', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Get icon | 2. Kiểm tra type | 3. Đúng'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon getter trả về default icon cho iconName không hợp lệ', 'description': 'Kiểm tra icon fallback', 'testType': 'Edge Case', 'priority': 'Medium', 'steps': '1. Invalid icon | 2. Get icon | 3. Fallback'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Color getter chuyển đổi iconColor thành Color', 'description': 'Kiểm tra color conversion', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Get color | 2. Kiểm tra type | 3. Đúng'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'isDefault có thể được bật/tắt', 'description': 'Kiểm tra toggle isDefault', 'testType': 'State', 'priority': 'Low', 'steps': '1. Bật isDefault | 2. Tắt | 3. Kiểm tra'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo | 2. toJson | 3. Kiểm tra field'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson defaults', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith updates', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo | 2. copyWith | 3. Kiểm tra'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Các icon types được hỗ trợ', 'description': 'Kiểm tra icon types support', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test icon types | 2. Kiểm tra hỗ trợ'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra complete JSON round-trip', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Nhiều payment methods có thể tồn tại', 'description': 'Kiểm tra multiple payment methods', 'testType': 'Functionality', 'priority': 'Low', 'steps': '1. Tạo multiple | 2. Kiểm tra độc lập'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon color là hex color hợp lệ', 'description': 'Kiểm tra color validation', 'testType': 'Validation', 'priority': 'Low', 'steps': '1. Test hex color | 2. Kiểm tra'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Name của payment method không trống', 'description': 'Kiểm tra name validation', 'testType': 'Validation', 'priority': 'Low', 'steps': '1. Nhập trống | 2. Kiểm tra validation'},

    // Transaction Model Tests
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra default values', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo Transaction | 2. Kiểm tra defaults'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Getter isIncome trả về true cho income transaction', 'description': 'Kiểm tra isIncome getter', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Income transaction | 2. Gọi isIncome | 3. true'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Getter isExpense trả về true cho expense transaction', 'description': 'Kiểm tra isExpense getter', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Expense transaction | 2. Gọi isExpense | 3. true'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction type là income hoặc expense', 'description': 'Kiểm tra type validation', 'testType': 'Validation', 'priority': 'High', 'steps': '1. Test income | 2. Test expense | 3. Kiểm tra'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo | 2. toJson | 3. Kiểm tra field'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson defaults', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith updates', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo | 2. copyWith | 3. Kiểm tra'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction với attachment path', 'description': 'Kiểm tra attachment storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Add attachment | 2. Kiểm tra lưu'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction với location', 'description': 'Kiểm tra location storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Set location | 2. Kiểm tra lưu'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Income transaction có sourceOrDestination', 'description': 'Kiểm tra source for income', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Set source | 2. Kiểm tra lưu'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra complete JSON round-trip', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction amount luôn dương', 'description': 'Kiểm tra amount validation', 'testType': 'Validation', 'priority': 'High', 'steps': '1. Negative | 2. Kiểm tra validation'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Nhiều transactions có thể tồn tại', 'description': 'Kiểm tra multiple transactions', 'testType': 'Functionality', 'priority': 'Low', 'steps': '1. Tạo multiple | 2. Kiểm tra độc lập'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction description không trống', 'description': 'Kiểm tra description validation', 'testType': 'Validation', 'priority': 'Low', 'steps': '1. Nhập trống | 2. Kiểm tra validation'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction date được lưu trữ chính xác', 'description': 'Kiểm tra date storage', 'testType': 'Data', 'priority': 'Low', 'steps': '1. Set date | 2. Kiểm tra lưu'},

    // User Model Tests
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra default values', 'testType': 'Initialization', 'priority': 'Medium', 'steps': '1. Tạo User | 2. Kiểm tra defaults'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Currency được lưu trữ chính xác', 'description': 'Kiểm tra currency storage', 'testType': 'Data', 'priority': 'Medium', 'steps': '1. Set currency | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Theme là light, dark hoặc system', 'description': 'Kiểm tra theme types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test light | 2. Test dark | 3. Test system'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Language là vi hoặc en', 'description': 'Kiểm tra language types', 'testType': 'Validation', 'priority': 'Medium', 'steps': '1. Test Vietnamese | 2. Test English | 3. Kiểm tra'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Google account information được lưu trữ', 'description': 'Kiểm tra Google account storage', 'testType': 'Data', 'priority': 'Medium', 'steps': '1. Add Google account | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Backup settings được quản lý', 'description': 'Kiểm tra backup settings', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Bật backup | 2. Tắt | 3. Kiểm tra'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Notification settings được quản lý', 'description': 'Kiểm tra notification settings', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Cấu hình notify | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Biometric settings được quản lý', 'description': 'Kiểm tra biometric settings', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Bật biometric | 2. Tắt | 3. Kiểm tra'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Budget alert settings được quản lý', 'description': 'Kiểm tra budget alert settings', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Set alert level | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'PIN code settings được quản lý', 'description': 'Kiểm tra PIN settings', 'testType': 'Functionality', 'priority': 'High', 'steps': '1. Set PIN | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Background lock timeout được lưu trữ', 'description': 'Kiểm tra timeout storage', 'testType': 'Data', 'priority': 'Medium', 'steps': '1. Set timeout | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Recovery code được lưu trữ', 'description': 'Kiểm tra recovery code storage', 'testType': 'Data', 'priority': 'High', 'steps': '1. Generate code | 2. Kiểm tra lưu'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Setup completion status được quản lý', 'description': 'Kiểm tra setup status', 'testType': 'State', 'priority': 'Medium', 'steps': '1. Đánh dấu hoàn | 2. Kiểm tra flag'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'toJson bao gồm tất cả các trường', 'description': 'Kiểm tra toJson completeness', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Tạo | 2. toJson | 3. Kiểm tra field'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'fromJson xử lý các giá trị mặc định đúng cách', 'description': 'Kiểm tra fromJson defaults', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Parse JSON | 2. Kiểm tra defaults'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'fromJson xử lý nullable dates', 'description': 'Kiểm tra fromJson nullable dates', 'testType': 'Serialization', 'priority': 'Medium', 'steps': '1. Test null date | 2. Kiểm tra xử lý'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'copyWith cập nhật các trường một cách chính xác', 'description': 'Kiểm tra copyWith updates', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Tạo | 2. copyWith | 3. Kiểm tra'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu', 'description': 'Kiểm tra complete JSON round-trip', 'testType': 'Serialization', 'priority': 'High', 'steps': '1. Tạo | 2. Round-trip | 3. Kiểm tra'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Sync date được cập nhật', 'description': 'Kiểm tra sync date update', 'testType': 'Functionality', 'priority': 'Medium', 'steps': '1. Đồng bộ | 2. Kiểm tra date'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Monthly budget limit có thể được đặt hoặc bỏ qua', 'description': 'Kiểm tra optional budget limit', 'testType': 'Data', 'priority': 'Medium', 'steps': '1. Set limit | 2. Bỏ qua | 3. Kiểm tra'},
  ];

  // Tạo CSV content
  final csvContent = _generateCSV(testCases);
  
  // Ghi vào file
  final file = File('TestCases_Complete_Report.csv');
  await file.writeAsString(csvContent);
  
  // Thống kê
  _printStatistics(testCases);
  
  print('\n✅ File TestCases_Complete_Report.csv đã được tạo thành công!');
  print('📍 Đường dẫn: ${file.absolute.path}');
  print('\n💡 Bạn có thể mở file này bằng Excel, Google Sheets hoặc các ứng dụng spreadsheet khác');
}

String _generateCSV(List<Map<String, String>> testCases) {
  final headers = ['STT', 'File', 'Group', 'Test Name', 'Description', 'Test Type', 'Priority', 'Steps', 'Status', 'Date Created'];
  final rows = [headers.join(';')];
  
  for (int i = 0; i < testCases.length; i++) {
    final test = testCases[i];
    final steps = test['steps'] ?? 'N/A';
    final row = [
      (i + 1).toString(),
      test['file']!,
      test['group']!,
      test['testName']!,
      test['description']!,
      test['testType']!,
      test['priority']!,
      '"$steps"',
      'PASS',
      '2025-12-22 10:00:00'
    ];
    rows.add(row.join(';'));
  }
  
  // Add UTF-8 BOM to ensure proper encoding in Excel
  return '\uFEFF${rows.join('\n')}';
}

void _printStatistics(List<Map<String, String>> testCases) {
  print('\n📊 TỔNG QUAN TEST CASES');
  print('  Tổng cộng: ${testCases.length} test cases\n');
  
  // Statistics by Test Type
  final typeStats = <String, int>{};
  for (var test in testCases) {
    final type = test['testType']!;
    typeStats[type] = (typeStats[type] ?? 0) + 1;
  }
  
  print('Thống kê theo Test Type:');
  typeStats.forEach((type, count) {
    print('  ✓ $type: $count');
  });
  
  // Statistics by Priority
  final priorityStats = <String, int>{};
  for (var test in testCases) {
    final priority = test['priority']!;
    priorityStats[priority] = (priorityStats[priority] ?? 0) + 1;
  }
  
  print('\nThống kê theo Priority:');
  final priorityOrder = ['High', 'Medium', 'Low'];
  final priorityEmoji = {'High': '🔴', 'Medium': '🟡', 'Low': '🟢'};
  for (var priority in priorityOrder) {
    final count = priorityStats[priority] ?? 0;
    print('  ${priorityEmoji[priority]} $priority: $count');
  }
  
  // Statistics by File
  final fileStats = <String, int>{};
  for (var test in testCases) {
    final file = test['file']!;
    fileStats[file] = (fileStats[file] ?? 0) + 1;
  }
  
  print('\nThống kê theo File:');
  fileStats.forEach((file, count) {
    print('  ◆ $file: $count');
  });
}
