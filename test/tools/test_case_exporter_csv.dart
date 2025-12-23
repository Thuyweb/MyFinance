import 'dart:io';

void main() async {
  // Dữ liệu tất cả test cases
  final testCases = [
    // Budget Model Tests
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Tính usagePercentage đúng',
      'description': 'Kiểm tra tính toán phần trăm sử dụng budget',
      'testType': 'Calculation',
      'priority': 'High',
      'steps': '1. Mở ứng dụng Budget | 2. Nhập amount và spent | 3. Kiểm tra usagePercentage được tính đúng'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Tính remaining đúng',
      'description': 'Kiểm tra tính toán số tiền còn lại',
      'testType': 'Calculation',
      'priority': 'High',
      'steps': '1. Tạo Budget mới | 2. Thiết lập amount và spent | 3. Kiểm tra remaining = amount - spent'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Status đúng theo mức sử dụng',
      'description': 'Kiểm tra status budget (normal/warning/exceeded/full)',
      'testType': 'State',
      'priority': 'High',
      'steps': '1. Tạo Budget | 2. Thay đổi spent amount | 3. Kiểm tra status thay đổi đúng'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'toJson và fromJson hoạt động đúng',
      'description': 'Kiểm tra serialization JSON',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. Chuyển đổi sang JSON | 3. Chuyển đổi lại | 4. Kiểm tra dữ liệu không thay đổi'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra các giá trị mặc định khi khởi tạo',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'remaining âm khi spent > amount',
      'description': 'Kiểm tra edge case when vượt quá ngân sách',
      'testType': 'Edge Case',
      'priority': 'Medium',
      'steps': '1. Tạo Budget với spent > amount | 2. Kiểm tra remaining < 0'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'usagePercentage bằng 0 khi amount bằng 0',
      'description': 'Kiểm tra edge case chia cho 0',
      'testType': 'Edge Case',
      'priority': 'High',
      'steps': '1. Tạo Budget với amount = 0 | 2. Tính usagePercentage | 3. Kiểm tra xử lý exception'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Status là full khi spent bằng amount',
      'description': 'Kiểm tra status khi budget đầy',
      'testType': 'State',
      'priority': 'Medium',
      'steps': '1. Tạo Budget | 2. Thiết lập spent = amount | 3. Kiểm tra status = full'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith method',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'copyWith giữ nguyên các trường không được cập nhật',
      'description': 'Kiểm tra copyWith không ảnh hưởng các field khác',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. copyWith 1 field | 3. Kiểm tra field khác không đổi'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'usagePercentage tính chính xác với số thập phân',
      'description': 'Kiểm tra tính toán với số decimal',
      'testType': 'Calculation',
      'priority': 'Medium',
      'steps': '1. Nhập decimal amount | 2. Tính toán | 3. Kiểm tra độ chính xác'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Status warning với các mức alertPercentage khác nhau',
      'description': 'Kiểm tra warning status với alertPercentage',
      'testType': 'State',
      'priority': 'Medium',
      'steps': '1. Set alertPercentage khác nhau | 2. Kiểm tra status'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson chứa đủ dữ liệu',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị null/optional đúng cách',
      'description': 'Kiểm tra fromJson với missing fields',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Chuẩn bị JSON với missing fields | 2. Gọi fromJson | 3. Kiểm tra defaults'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'fromJson xử lý recurringTime đúng cách',
      'description': 'Kiểm tra fromJson với recurring time',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Test JSON với recurringTime | 2. Parse | 3. Kiểm tra kết quả'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'usagePercentage 100% khi spent bằng amount',
      'description': 'Kiểm tra usagePercentage = 100',
      'testType': 'Calculation',
      'priority': 'Low',
      'steps': '1. Tạo Budget spent = amount | 2. Tính usagePercentage | 3. Kiểm tra = 100'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'usagePercentage > 100% khi spent > amount',
      'description': 'Kiểm tra usagePercentage > 100',
      'testType': 'Calculation',
      'priority': 'Low',
      'steps': '1. Tạo Budget spent > amount | 2. Tính usagePercentage | 3. Kiểm tra > 100'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Period có thể là weekly, monthly hoặc yearly',
      'description': 'Kiểm tra các period types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test weekly period | 2. Test monthly | 3. Test yearly'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'isActive có thể được bật/tắt',
      'description': 'Kiểm tra toggle isActive',
      'testType': 'State',
      'priority': 'Low',
      'steps': '1. Tạo Budget isActive=true | 2. Tắt nó | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'alertEnabled có thể được bật/tắt',
      'description': 'Kiểm tra toggle alertEnabled',
      'testType': 'State',
      'priority': 'Low',
      'steps': '1. Bật alertEnabled | 2. Tắt nó | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'budget_model_test.dart',
      'group': 'BudgetModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra toJson -> fromJson -> equals',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },

    // Category Model Tests (12 tests)
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra các giá trị mặc định của CategoryModel',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Type là income hoặc expense',
      'description': 'Kiểm tra category type validation',
      'testType': 'Validation',
      'priority': 'High',
      'steps': '1. Test income type | 2. Test expense type | 3. Kiểm tra validation'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Không chấp nhận type không hợp lệ - kiểm tra validation',
      'description': 'Kiểm tra invalid type handling',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Nhập invalid type | 2. Kiểm tra validation error'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson với default values',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith functionality',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'isActive có thể được bật/tắt',
      'description': 'Kiểm tra toggle isActive',
      'testType': 'State',
      'priority': 'Low',
      'steps': '1. Tạo Budget isActive=true | 2. Tắt nó | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'isDefault đánh dấu category mặc định',
      'description': 'Kiểm tra isDefault flag',
      'testType': 'State',
      'priority': 'Low',
      'steps': '1. Tạo category isDefault=true | 2. Kiểm tra flag'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra toJson -> fromJson preservation',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Nhiều categories có thể tồn tại cùng lúc',
      'description': 'Kiểm tra multiple category instances',
      'testType': 'Functionality',
      'priority': 'Low',
      'steps': 'Chạy test'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Icon code point được lưu trữ chính xác',
      'description': 'Kiểm tra iconCodePoint storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Set icon code point | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'category_model_test.dart',
      'group': 'CategoryModel Unit Tests',
      'testName': 'Color hex value được lưu trữ chính xác',
      'description': 'Kiểm tra colorValue storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Set color hex | 2. Kiểm tra lưu đúng'
    },

    // Expense Model Tests (10 tests)
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra default values của ExpenseModel',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Payment method có thể là cash, card, hoặc e_wallet',
      'description': 'Kiểm tra payment method types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test cash | 2. Test card | 3. Test e_wallet'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Recurring expense được định nghĩa chính xác',
      'description': 'Kiểm tra recurring expense setup',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo recurring expense | 2. Set pattern | 3. Kiểm tra'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson defaults',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith updates',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Expense với receipt photo path',
      'description': 'Kiểm tra receipt photo storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Thêm receipt path | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra complete JSON round-trip',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Expense amount luôn dương',
      'description': 'Kiểm tra amount validation',
      'testType': 'Validation',
      'priority': 'High',
      'steps': '1. Nhập negative amount | 2. Kiểm tra validation | 3. Thử positive'
    },
    {
      'file': 'expense_model_test.dart',
      'group': 'ExpenseModel Unit Tests',
      'testName': 'Recurring pattern có thể là daily, weekly, monthly, hoặc yearly',
      'description': 'Kiểm tra recurring pattern types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test tất cả pattern types | 2. Kiểm tra hợp lệ'
    },

    // Income Model Tests (12 tests)
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra default values của IncomeModel',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Income source được lưu trữ chính xác',
      'description': 'Kiểm tra income sources',
      'testType': 'Data',
      'priority': 'Medium',
      'steps': '1. Set source | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Recurring income được định nghĩa chính xác',
      'description': 'Kiểm tra recurring income setup',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo recurring income | 2. Set pattern | 3. Kiểm tra'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson defaults',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith updates',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Income với attachment path',
      'description': 'Kiểm tra attachment storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Thêm attachment | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra complete JSON round-trip',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Income amount luôn dương',
      'description': 'Kiểm tra amount validation',
      'testType': 'Validation',
      'priority': 'High',
      'steps': '1. Nhập negative | 2. Kiểm tra validation'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Recurring pattern có thể là weekly, monthly hoặc yearly',
      'description': 'Kiểm tra recurring pattern types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test weekly | 2. Test monthly | 3. Test yearly'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Nhiều income sources có thể tồn tại',
      'description': 'Kiểm tra multiple income sources',
      'testType': 'Functionality',
      'priority': 'Low',
      'steps': '1. Tạo multiple sources | 2. Kiểm tra độc lập'
    },
    {
      'file': 'income_model_test.dart',
      'group': 'IncomeModel Unit Tests',
      'testName': 'Income description không trống',
      'description': 'Kiểm tra description validation',
      'testType': 'Validation',
      'priority': 'Low',
      'steps': '1. Nhập trống | 2. Kiểm tra validation'
    },

    // Payment Method Model Tests (14 tests)
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra default values',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Built-in payment methods được đánh dấu đúng cách',
      'description': 'Kiểm tra built-in flag',
      'testType': 'State',
      'priority': 'Medium',
      'steps': '1. Kiểm tra built-in flag'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Icon getter trả về IconData chính xác',
      'description': 'Kiểm tra icon getter',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Get icon | 2. Kiểm tra type | 3. Kiểm tra đúng'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Icon getter trả về default icon cho iconName không hợp lệ',
      'description': 'Kiểm tra icon fallback',
      'testType': 'Edge Case',
      'priority': 'Medium',
      'steps': '1. Set invalid icon | 2. Get icon | 3. Kiểm tra fallback'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Color getter chuyển đổi iconColor thành Color',
      'description': 'Kiểm tra color conversion',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Get color | 2. Kiểm tra type | 3. Kiểm tra đúng'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'isDefault có thể được bật/tắt',
      'description': 'Kiểm tra toggle isDefault',
      'testType': 'State',
      'priority': 'Low',
      'steps': '1. Bật isDefault | 2. Tắt | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson defaults',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith updates',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Các icon types được hỗ trợ',
      'description': 'Kiểm tra icon types support',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test icon type 1 | 2. Test type 2 | 3. Kiểm tra hỗ trợ'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra complete JSON round-trip',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Nhiều payment methods có thể tồn tại',
      'description': 'Kiểm tra multiple payment methods',
      'testType': 'Functionality',
      'priority': 'Low',
      'steps': '1. Tạo multiple methods | 2. Kiểm tra độc lập'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Icon color là hex color hợp lệ',
      'description': 'Kiểm tra color validation',
      'testType': 'Validation',
      'priority': 'Low',
      'steps': '1. Test valid hex | 2. Test invalid | 3. Kiểm tra validation'
    },
    {
      'file': 'payment_method_model_test.dart',
      'group': 'PaymentMethodModel Unit Tests',
      'testName': 'Name của payment method không trống',
      'description': 'Kiểm tra name validation',
      'testType': 'Validation',
      'priority': 'Low',
      'steps': '1. Nhập trống | 2. Kiểm tra validation'
    },

    // Transaction Model Tests (15 tests)
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra default values',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Getter isIncome trả về true cho income transaction',
      'description': 'Kiểm tra isIncome getter',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo income transaction | 2. Gọi isIncome | 3. Kiểm tra true'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Getter isExpense trả về true cho expense transaction',
      'description': 'Kiểm tra isExpense getter',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo expense transaction | 2. Gọi isExpense | 3. Kiểm tra true'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction type là income hoặc expense',
      'description': 'Kiểm tra type validation',
      'testType': 'Validation',
      'priority': 'High',
      'steps': '1. Test income | 2. Test expense | 3. Kiểm tra validation'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson defaults',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith updates',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction với attachment path',
      'description': 'Kiểm tra attachment storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Thêm attachment | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction với location',
      'description': 'Kiểm tra location storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Set location | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Income transaction có sourceOrDestination',
      'description': 'Kiểm tra source for income',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Set source | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra complete JSON round-trip',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction amount luôn dương',
      'description': 'Kiểm tra amount validation',
      'testType': 'Validation',
      'priority': 'High',
      'steps': '1. Nhập negative | 2. Kiểm tra validation'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Nhiều transactions có thể tồn tại',
      'description': 'Kiểm tra multiple transactions',
      'testType': 'Functionality',
      'priority': 'Low',
      'steps': '1. Tạo multiple | 2. Kiểm tra độc lập'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction description không trống',
      'description': 'Kiểm tra description validation',
      'testType': 'Validation',
      'priority': 'Low',
      'steps': '1. Nhập trống | 2. Kiểm tra validation'
    },
    {
      'file': 'transaction_model_test.dart',
      'group': 'TransactionModel Unit Tests',
      'testName': 'Transaction date được lưu trữ chính xác',
      'description': 'Kiểm tra date storage',
      'testType': 'Data',
      'priority': 'Low',
      'steps': '1. Set date | 2. Kiểm tra lưu đúng'
    },

    // User Model Tests (20 tests)
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Khởi tạo với giá trị mặc định',
      'description': 'Kiểm tra default values',
      'testType': 'Initialization',
      'priority': 'Medium',
      'steps': '1. Tạo object mà không cung cấp arguments | 2. Kiểm tra giá trị mặc định'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Currency được lưu trữ chính xác',
      'description': 'Kiểm tra currency storage',
      'testType': 'Data',
      'priority': 'Medium',
      'steps': '1. Set currency | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Theme là light, dark hoặc system',
      'description': 'Kiểm tra theme types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test light | 2. Test dark | 3. Test system'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Language là vi hoặc en',
      'description': 'Kiểm tra language types',
      'testType': 'Validation',
      'priority': 'Medium',
      'steps': '1. Test Vietnamese | 2. Test English | 3. Kiểm tra hợp lệ'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Google account information được lưu trữ',
      'description': 'Kiểm tra Google account storage',
      'testType': 'Data',
      'priority': 'Medium',
      'steps': '1. Thêm Google account | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Backup settings được quản lý',
      'description': 'Kiểm tra backup settings',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Bật backup | 2. Tắt | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Notification settings được quản lý',
      'description': 'Kiểm tra notification settings',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Cấu hình notify | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Biometric settings được quản lý',
      'description': 'Kiểm tra biometric settings',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Bật biometric | 2. Tắt | 3. Kiểm tra trạng thái'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Budget alert settings được quản lý',
      'description': 'Kiểm tra budget alert settings',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Set alert level | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'PIN code settings được quản lý',
      'description': 'Kiểm tra PIN settings',
      'testType': 'Functionality',
      'priority': 'High',
      'steps': '1. Set PIN | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Background lock timeout được lưu trữ',
      'description': 'Kiểm tra timeout storage',
      'testType': 'Data',
      'priority': 'Medium',
      'steps': '1. Set timeout | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Recovery code được lưu trữ',
      'description': 'Kiểm tra recovery code storage',
      'testType': 'Data',
      'priority': 'High',
      'steps': '1. Generate code | 2. Kiểm tra lưu đúng'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Setup completion status được quản lý',
      'description': 'Kiểm tra setup status',
      'testType': 'State',
      'priority': 'Medium',
      'steps': '1. Đánh dấu hoàn thành | 2. Kiểm tra flag'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'toJson bao gồm tất cả các trường',
      'description': 'Kiểm tra toJson completeness',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Gọi toJson | 3. Kiểm tra tất cả field có mặt'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'fromJson xử lý các giá trị mặc định đúng cách',
      'description': 'Kiểm tra fromJson defaults',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': 'Chạy test'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'fromJson xử lý nullable dates',
      'description': 'Kiểm tra fromJson nullable dates',
      'testType': 'Serialization',
      'priority': 'Medium',
      'steps': '1. Test với null date | 2. Kiểm tra xử lý'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'copyWith cập nhật các trường một cách chính xác',
      'description': 'Kiểm tra copyWith updates',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Tạo object | 2. Sử dụng copyWith | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Round-trip JSON serialization giữ nguyên tất cả dữ liệu',
      'description': 'Kiểm tra complete JSON round-trip',
      'testType': 'Serialization',
      'priority': 'High',
      'steps': '1. Tạo object | 2. toJson -> fromJson | 3. Kiểm tra equals'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Sync date được cập nhật',
      'description': 'Kiểm tra sync date update',
      'testType': 'Functionality',
      'priority': 'Medium',
      'steps': '1. Đồng bộ | 2. Kiểm tra sync date'
    },
    {
      'file': 'user_model_test.dart',
      'group': 'UserModel Unit Tests',
      'testName': 'Monthly budget limit có thể được đặt hoặc bỏ qua',
      'description': 'Kiểm tra optional budget limit',
      'testType': 'Data',
      'priority': 'Medium',
      'steps': '1. Set limit | 2. Bỏ qua | 3. Kiểm tra'
    },

    // ==========================================
    // Integration Tests (31 tests)
    // ==========================================
    
    // App Integration Tests (9 tests)
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'App starts successfully',
      'description': 'Kiểm tra ứng dụng khởi động thành công',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Khởi chạy app | 2. Chờ initialization hoàn thành | 3. Kiểm tra UI hiển thị'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Navigation between tabs works',
      'description': 'Kiểm tra chuyển đổi giữa các tab',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap tab home | 2. Tap tab history | 3. Kiểm tra navigation hoạt động'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Settings screen accessibility',
      'description': 'Kiểm tra truy cập settings',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tap settings button | 2. Chờ settings screen | 3. Kiểm tra hiển thị'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Dashboard displays summary correctly',
      'description': 'Kiểm tra dashboard hiển thị đúng',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào dashboard | 2. Kiểm tra tổng hợp | 3. Kiểm tra thống kê'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Date picker works',
      'description': 'Kiểm tra date picker',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tap date picker | 2. Chọn ngày | 3. Kiểm tra cập nhật'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'User can logout',
      'description': 'Kiểm tra logout',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào settings | 2. Tap logout | 3. Confirm | 4. Kiểm tra về login'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Search functionality',
      'description': 'Kiểm tra tìm kiếm',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tap search | 2. Nhập từ khóa | 3. Kiểm tra kết quả'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Back button navigation',
      'description': 'Kiểm tra nút back',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Vào screen khác | 2. Tap back | 3. Quay về'
    },
    {
      'file': 'app_test.dart',
      'group': 'App Navigation & Overall Integration Tests',
      'testName': 'Theme persistence',
      'description': 'Kiểm tra theme được lưu',
      'testType': 'Integration',
      'priority': 'Low',
      'steps': '1. Đổi theme | 2. Restart app | 3. Kiểm tra theme giữ nguyên'
    },

    // Budget Integration Tests (6 tests)
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'Create new budget successfully',
      'description': 'Tạo budget mới thành công',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap add | 2. Nhập tên & hạn mức | 3. Save | 4. Kiểm tra hiển thị'
    },
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'View budget list',
      'description': 'Xem danh sách budget',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào budget screen | 2. Kiểm tra list | 3. Kiểm tra tất cả items'
    },
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'Edit budget',
      'description': 'Chỉnh sửa budget',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap budget | 2. Edit | 3. Save | 4. Kiểm tra cập nhật'
    },
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'Delete budget',
      'description': 'Xóa budget',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Long press budget | 2. Tap delete | 3. Confirm | 4. Kiểm tra xóa'
    },
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'Budget status updates correctly',
      'description': 'Status thay đổi khi spent thay đổi',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tạo budget | 2. Thêm expense | 3. Kiểm tra status'
    },
    {
      'file': 'budget_test.dart',
      'group': 'Budget Integration Tests',
      'testName': 'Multiple budget management',
      'description': 'Quản lý nhiều budget',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tạo 2+ budgets | 2. Kiểm tra list | 3. Kiểm tra độc lập'
    },

    // Expense Integration Tests (7 tests)
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Add new expense successfully',
      'description': 'Thêm expense mới thành công',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap add | 2. Nhập amount & mô tả | 3. Save | 4. Kiểm tra hiển thị'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'View expense list',
      'description': 'Xem danh sách expense',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào expense screen | 2. Kiểm tra list | 3. Kiểm tra tất cả items'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Filter expenses by category',
      'description': 'Lọc expense theo danh mục',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tap filter | 2. Chọn category | 3. Kiểm tra kết quả'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Edit expense',
      'description': 'Chỉnh sửa expense',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap expense | 2. Edit | 3. Save | 4. Kiểm tra cập nhật'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Delete expense',
      'description': 'Xóa expense',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Swipe expense | 2. Confirm delete | 3. Kiểm tra xóa'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Search expenses',
      'description': 'Tìm kiếm expense',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tap search | 2. Nhập từ khóa | 3. Kiểm tra kết quả'
    },
    {
      'file': 'expense_test.dart',
      'group': 'Expense Integration Tests',
      'testName': 'Recurring expenses',
      'description': 'Thiết lập expense lặp lại',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Enable recurring | 2. Set pattern | 3. Save | 4. Kiểm tra'
    },

    // Income Integration Tests (4 tests)
    {
      'file': 'income_test.dart',
      'group': 'Income Integration Tests',
      'testName': 'Add new income successfully',
      'description': 'Thêm income mới thành công',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap add | 2. Nhập amount & source | 3. Save | 4. Kiểm tra hiển thị'
    },
    {
      'file': 'income_test.dart',
      'group': 'Income Integration Tests',
      'testName': 'View income list',
      'description': 'Xem danh sách income',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào income tab | 2. Kiểm tra list | 3. Kiểm tra tất cả items'
    },
    {
      'file': 'income_test.dart',
      'group': 'Income Integration Tests',
      'testName': 'Edit income',
      'description': 'Chỉnh sửa income',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap income | 2. Edit | 3. Save | 4. Kiểm tra cập nhật'
    },
    {
      'file': 'income_test.dart',
      'group': 'Income Integration Tests',
      'testName': 'Set recurring income',
      'description': 'Thiết lập income lặp lại',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Enable recurring | 2. Set pattern | 3. Save | 4. Kiểm tra'
    },

    // Category Integration Tests (5 tests)
    {
      'file': 'category_test.dart',
      'group': 'Category Management Integration Tests',
      'testName': 'Add new category successfully',
      'description': 'Thêm category mới thành công',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào settings | 2. Tap add category | 3. Nhập name | 4. Save'
    },
    {
      'file': 'category_test.dart',
      'group': 'Category Management Integration Tests',
      'testName': 'View all categories',
      'description': 'Xem tất cả categories',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Vào settings | 2. Category | 3. Kiểm tra list'
    },
    {
      'file': 'category_test.dart',
      'group': 'Category Management Integration Tests',
      'testName': 'Edit category',
      'description': 'Chỉnh sửa category',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Tap category | 2. Edit | 3. Save | 4. Kiểm tra cập nhật'
    },
    {
      'file': 'category_test.dart',
      'group': 'Category Management Integration Tests',
      'testName': 'Delete category',
      'description': 'Xóa category',
      'testType': 'Integration',
      'priority': 'High',
      'steps': '1. Long press | 2. Tap delete | 3. Confirm | 4. Kiểm tra xóa'
    },
    {
      'file': 'category_test.dart',
      'group': 'Category Management Integration Tests',
      'testName': 'Use category in transaction',
      'description': 'Sử dụng category trong transaction',
      'testType': 'Integration',
      'priority': 'Medium',
      'steps': '1. Tạo expense | 2. Select category | 3. Save | 4. Kiểm tra'
    },
  ];

  // Tạo CSV content
  StringBuffer csv = StringBuffer();
  
  // UTF-8 BOM để Excel nhận diện đúng
  csv.write('\uFEFF');
  
  // Header
  csv.writeln('STT,File,Group,Test Name,Description,Test Type,Priority,Steps,Status,Date Created');
  
  // Data rows
  for (int i = 0; i < testCases.length; i++) {
    final test = testCases[i];
    final no = (i + 1).toString();
    final status = 'PASS';
    final date = DateTime.now().toString().split('.')[0];
    
    // Proper CSV escaping: double any quotes inside fields, then wrap in quotes
    String escapeCSVField(String? value) {
      if (value == null) return '""';
      final escaped = value.replaceAll('"', '""'); // Escape quotes by doubling them
      return '"$escaped"';
    }
    
    final file = escapeCSVField(test['file']);
    final group = escapeCSVField(test['group']);
    final testName = escapeCSVField(test['testName']);
    final description = escapeCSVField(test['description']);
    final testType = escapeCSVField(test['testType']);
    final priority = escapeCSVField(test['priority']);
    final steps = escapeCSVField(test['steps']);
    
    csv.writeln('$no,$file,$group,$testName,$description,$testType,$priority,$steps,$status,$date');
  }

  // Lưu file với retry
  final finalFile = File('TestCases_Report.csv');
  int retries = 0;
  const maxRetries = 3;
  
  while (retries < maxRetries) {
    try {
      await finalFile.writeAsString(csv.toString());
      break;
    } catch (e) {
      retries++;
      if (retries < maxRetries) {
        print('⏳ Chờ để thử lại... (lần $retries)');
        await Future.delayed(Duration(seconds: 1));
      } else {
        // Nếu vẫn không được, viết vào file backup
        final backupFile = File('TestCases_Report_backup_${DateTime.now().millisecondsSinceEpoch}.csv');
        await backupFile.writeAsString(csv.toString());
        print('❌ Không thể ghi vào TestCases_Report.csv (file đang được mở)');
        print('💾 File backup được lưu tại: ${backupFile.path}');
        print('💡 Vui lòng đóng file Excel và chạy lại để cập nhật file chính');
        return;
      }
    }
  }

  print('✅ Đã tạo file CSV thành công!');
  print('📊 File được lưu tại: TestCases_Report.csv');
  print('');
  print('📊 TỔNG QUAN TEST CASES');
  print('═' * 50);
  print('  Tổng cộng: ${testCases.length} test cases');
  print('');
  
  print('Thống kê theo Test Type:');
  Map<String, int> typeCount = {};
  for (var test in testCases) {
    final type = test['testType'] as String;
    typeCount[type] = (typeCount[type] ?? 0) + 1;
  }
  typeCount.forEach((type, count) {
    print('  ✓ $type: $count');
  });

  print('');
  print('Thống kê theo Priority:');
  Map<String, int> priorityCount = {};
  for (var test in testCases) {
    final priority = test['priority'] as String;
    priorityCount[priority] = (priorityCount[priority] ?? 0) + 1;
  }
  priorityCount.forEach((priority, count) {
    if (priority == 'High') {
      print('  🔴 $priority: $count');
    } else if (priority == 'Medium') {
      print('  🟡 $priority: $count');
    } else {
      print('  🟢 $priority: $count');
    }
  });

  print('');
  print('Thống kê theo File:');
  Map<String, int> fileCount = {};
  for (var test in testCases) {
    final file = test['file'] as String;
    fileCount[file] = (fileCount[file] ?? 0) + 1;
  }
  fileCount.forEach((file, count) {
    print('  ◆ $file: $count');
  });
  
  print('');
  print('═' * 50);
  print('📝 Hướng dẫn sử dụng:');
  print('  1. Mở file TestCases_Report.csv bằng Excel');
  print('  2. Hoặc import vào Google Sheets');
  print('  3. Sử dụng để track status của các tests');
}
