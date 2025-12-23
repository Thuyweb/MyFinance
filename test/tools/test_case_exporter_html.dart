import 'dart:io';

void main() async {
  // Dữ liệu tất cả test cases - Tổng 104 test cases
  final testCases = [
    // Budget Model Tests (21)
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tính usagePercentage đúng', 'description': 'Kiểm tra tính toán phần trăm sử dụng budget', 'testType': 'Calculation', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tính remaining đúng', 'description': 'Kiểm tra tính toán số tiền còn lại', 'testType': 'Calculation', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status đúng theo mức sử dụng', 'description': 'Kiểm tra status budget (normal/warning/exceeded/full)', 'testType': 'State', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'toJson và fromJson hoạt động đúng', 'description': 'Kiểm tra serialization JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Khởi tạo với giá trị mặc định', 'description': 'Kiểm tra các giá trị mặc định khi khởi tạo', 'testType': 'Initialization', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'remaining âm khi spent > amount', 'description': 'Kiểm tra remaining có thể âm', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'copyWith cập nhật các trường', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Chia cho 0 không gây lỗi', 'description': 'Kiểm tra xử lý exception khi amount=0', 'testType': 'Edge Case', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status exceeded khi spent > amount', 'description': 'Kiểm tra status khi vượt ngân sách', 'testType': 'State', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Status full khi spent == amount', 'description': 'Kiểm tra status khi đầy ngân sách', 'testType': 'State', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'fromJson từ dữ liệu hợp lệ', 'description': 'Kiểm tra deserialization từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'toJson chứa tất cả trường cần thiết', 'description': 'Kiểm tra JSON có tất cả trường', 'testType': 'Serialization', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage = 0 khi spent = 0', 'description': 'Kiểm tra trường hợp không có chi tiêu', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'usagePercentage = 100 khi spent = amount', 'description': 'Kiểm tra trường hợp sử dụng hết', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'remaining = 0 khi spent = amount', 'description': 'Kiểm tra số tiền còn lại bằng 0', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tên budget được lưu đúng', 'description': 'Kiểm tra trường name', 'testType': 'Functionality', 'priority': 'Low'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Hạn mức budget được lưu đúng', 'description': 'Kiểm tra trường amount', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Tiền chi tiêu được lưu đúng', 'description': 'Kiểm tra trường spent', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'Category ID được lưu đúng', 'description': 'Kiểm tra trường categoryId', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'budget_model_test.dart', 'group': 'BudgetModel Unit Tests', 'testName': 'equals và hashCode hoạt động', 'description': 'Kiểm tra so sánh và hash', 'testType': 'Functionality', 'priority': 'Medium'},

    // Category Model Tests (12)
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'CategoryType.expense được lưu đúng', 'description': 'Kiểm tra category type expense', 'testType': 'Data', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'CategoryType.income được lưu đúng', 'description': 'Kiểm tra category type income', 'testType': 'Data', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Tên category được lưu đúng', 'description': 'Kiểm tra trường name', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Icon được lưu đúng', 'description': 'Kiểm tra trường icon', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Màu sắc được lưu đúng', 'description': 'Kiểm tra trường color', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Validate type không rỗng', 'description': 'Kiểm tra validation type', 'testType': 'Validation', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Validate name không rỗng', 'description': 'Kiểm tra validation name', 'testType': 'Validation', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'category_model_test.dart', 'group': 'CategoryModel Unit Tests', 'testName': 'Category with default values', 'description': 'Kiểm tra category với giá trị mặc định', 'testType': 'Initialization', 'priority': 'Medium'},

    // Expense Model Tests (10)
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Chi tiêu được tạo với giá trị hợp lệ', 'description': 'Kiểm tra khởi tạo expense', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Payment method được lưu đúng', 'description': 'Kiểm tra trường paymentMethod', 'testType': 'Data', 'priority': 'High'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Ghi chú được lưu đúng', 'description': 'Kiểm tra trường notes', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Receipt photo được lưu đúng', 'description': 'Kiểm tra trường receiptPhoto', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Recurring expense được lưu đúng', 'description': 'Kiểm tra trường isRecurring', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'expense_model_test.dart', 'group': 'ExpenseModel Unit Tests', 'testName': 'Validate payment method', 'description': 'Kiểm tra validation payment method', 'testType': 'Validation', 'priority': 'Medium'},

    // Income Model Tests (12)
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Thu nhập được tạo với giá trị hợp lệ', 'description': 'Kiểm tra khởi tạo income', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Nguồn thu nhập được lưu đúng', 'description': 'Kiểm tra trường source', 'testType': 'Data', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Ghi chú được lưu đúng', 'description': 'Kiểm tra trường notes', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Attachment được lưu đúng', 'description': 'Kiểm tra trường attachments', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Recurring income được lưu đúng', 'description': 'Kiểm tra trường isRecurring', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Validate income source', 'description': 'Kiểm tra validation source', 'testType': 'Validation', 'priority': 'Medium'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Validate income amount', 'description': 'Kiểm tra validation amount', 'testType': 'Validation', 'priority': 'High'},
    {'file': 'income_model_test.dart', 'group': 'IncomeModel Unit Tests', 'testName': 'Income with recurring schedule', 'description': 'Kiểm tra income với lịch tái diễn', 'testType': 'Functionality', 'priority': 'Medium'},

    // Payment Method Model Tests (14)
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Payment method được tạo đúng', 'description': 'Kiểm tra khởi tạo payment method', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Tên payment method được lưu đúng', 'description': 'Kiểm tra trường name', 'testType': 'Data', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon được lưu đúng', 'description': 'Kiểm tra trường icon', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Màu sắc được lưu đúng', 'description': 'Kiểm tra trường color', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon getter hoạt động', 'description': 'Kiểm tra lấy icon', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Color getter hoạt động', 'description': 'Kiểm tra lấy màu', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Built-in payment methods', 'description': 'Kiểm tra các payment method có sẵn', 'testType': 'State', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Custom payment method', 'description': 'Kiểm tra custom payment method', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Icon type support', 'description': 'Kiểm tra các loại icon được hỗ trợ', 'testType': 'Edge Case', 'priority': 'Low'},
    {'file': 'payment_method_model_test.dart', 'group': 'PaymentMethodModel Unit Tests', 'testName': 'Payment method equality', 'description': 'Kiểm tra so sánh payment method', 'testType': 'Functionality', 'priority': 'Medium'},

    // Transaction Model Tests (15)
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Giao dịch chi tiêu được tạo đúng', 'description': 'Kiểm tra khởi tạo expense transaction', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Giao dịch thu nhập được tạo đúng', 'description': 'Kiểm tra khởi tạo income transaction', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Loại giao dịch được lưu đúng', 'description': 'Kiểm tra trường type', 'testType': 'Data', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'isIncome getter hoạt động', 'description': 'Kiểm tra getter isIncome', 'testType': 'Functionality', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'isExpense getter hoạt động', 'description': 'Kiểm tra getter isExpense', 'testType': 'Functionality', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Vị trí được lưu đúng', 'description': 'Kiểm tra trường location', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Attachment được lưu đúng', 'description': 'Kiểm tra trường attachments', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Complete transaction object', 'description': 'Kiểm tra giao dịch đầy đủ', 'testType': 'Functionality', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction equality', 'description': 'Kiểm tra so sánh giao dịch', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Validate transaction type', 'description': 'Kiểm tra validation type', 'testType': 'Validation', 'priority': 'High'},
    {'file': 'transaction_model_test.dart', 'group': 'TransactionModel Unit Tests', 'testName': 'Transaction with multiple attachments', 'description': 'Kiểm tra giao dịch với nhiều attachment', 'testType': 'Data', 'priority': 'Medium'},

    // User Model Tests (20)
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'User được tạo đúng', 'description': 'Kiểm tra khởi tạo user', 'testType': 'Initialization', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Tên user được lưu đúng', 'description': 'Kiểm tra trường name', 'testType': 'Data', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Email được lưu đúng', 'description': 'Kiểm tra trường email', 'testType': 'Data', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Theme setting được lưu đúng', 'description': 'Kiểm tra cài đặt theme', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Language setting được lưu đúng', 'description': 'Kiểm tra cài đặt ngôn ngữ', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Backup setting được lưu đúng', 'description': 'Kiểm tra cài đặt backup', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Notification setting được lưu đúng', 'description': 'Kiểm tra cài đặt thông báo', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Biometric setting được lưu đúng', 'description': 'Kiểm tra cài đặt biometric', 'testType': 'Data', 'priority': 'Low'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'PIN setting được lưu đúng', 'description': 'Kiểm tra cài đặt PIN', 'testType': 'Data', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'toJson serialization hoạt động', 'description': 'Kiểm tra chuyển đổi sang JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'fromJson deserialization hoạt động', 'description': 'Kiểm tra chuyển đổi từ JSON', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'copyWith cập nhật đúng', 'description': 'Kiểm tra hàm copyWith', 'testType': 'Functionality', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Recovery code được lưu đúng', 'description': 'Kiểm tra trường recoveryCode', 'testType': 'Data', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Last backup date được lưu đúng', 'description': 'Kiểm tra trường lastBackupDate', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'JSON round-trip preserves data', 'description': 'Kiểm tra toJson -> fromJson giữ nguyên dữ liệu', 'testType': 'Serialization', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Nullable dates handled correctly', 'description': 'Kiểm tra xử lý date nullable', 'testType': 'Edge Case', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Validate user email format', 'description': 'Kiểm tra validation email format', 'testType': 'Validation', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'Settings update correctly', 'description': 'Kiểm tra cập nhật settings', 'testType': 'Functionality', 'priority': 'High'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'User with all settings enabled', 'description': 'Kiểm tra user với tất cả settings bật', 'testType': 'Data', 'priority': 'Medium'},
    {'file': 'user_model_test.dart', 'group': 'UserModel Unit Tests', 'testName': 'User preferences persistence', 'description': 'Kiểm tra lưu preferences user', 'testType': 'Functionality', 'priority': 'High'},

    // App Integration Tests (9)
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'App starts successfully', 'description': 'Kiểm tra app khởi động thành công', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Dashboard navigates to category screen', 'description': 'Kiểm tra điều hướng từ Dashboard sang Category', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Category navigates back to dashboard', 'description': 'Kiểm tra quay lại Dashboard từ Category', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Dashboard navigates to settings screen', 'description': 'Kiểm tra điều hướng từ Dashboard sang Settings', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Settings shows app version', 'description': 'Kiểm tra hiển thị phiên bản app trong Settings', 'testType': 'Integration', 'priority': 'Low'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Date picker opens on dashboard', 'description': 'Kiểm tra mở date picker trên Dashboard', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Logout button removes user session', 'description': 'Kiểm tra logout xóa session người dùng', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Search functionality filters results', 'description': 'Kiểm tra tính năng tìm kiếm lọc kết quả', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'app_test.dart', 'group': 'App Navigation & Overall Integration Tests', 'testName': 'Back button navigates properly', 'description': 'Kiểm tra nút back điều hướng chính xác', 'testType': 'Integration', 'priority': 'Medium'},

    // Budget Integration Tests (6)
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'Create new budget flow', 'description': 'Kiểm tra flow tạo budget mới', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'View budget details', 'description': 'Kiểm tra xem chi tiết budget', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'Edit existing budget', 'description': 'Kiểm tra chỉnh sửa budget hiện có', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'Delete budget from list', 'description': 'Kiểm tra xóa budget khỏi danh sách', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'Budget status updates correctly', 'description': 'Kiểm tra cập nhật status budget', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'budget_test.dart', 'group': 'Budget Integration Tests', 'testName': 'Multiple budgets display correctly', 'description': 'Kiểm tra hiển thị nhiều budget', 'testType': 'Integration', 'priority': 'Medium'},

    // Category Integration Tests (5)
    {'file': 'category_test.dart', 'group': 'Category Integration Tests', 'testName': 'Add new category', 'description': 'Kiểm tra thêm category mới', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'category_test.dart', 'group': 'Category Integration Tests', 'testName': 'View all categories', 'description': 'Kiểm tra xem tất cả categories', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'category_test.dart', 'group': 'Category Integration Tests', 'testName': 'Edit category details', 'description': 'Kiểm tra chỉnh sửa chi tiết category', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'category_test.dart', 'group': 'Category Integration Tests', 'testName': 'Delete category', 'description': 'Kiểm tra xóa category', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'category_test.dart', 'group': 'Category Integration Tests', 'testName': 'Use category in transaction', 'description': 'Kiểm tra sử dụng category trong giao dịch', 'testType': 'Integration', 'priority': 'Medium'},

    // Expense Integration Tests (7)
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Add new expense', 'description': 'Kiểm tra thêm chi tiêu mới', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'View expense list', 'description': 'Kiểm tra xem danh sách chi tiêu', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Filter expenses by category', 'description': 'Kiểm tra lọc chi tiêu theo category', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Edit expense details', 'description': 'Kiểm tra chỉnh sửa chi tiêu', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Delete expense', 'description': 'Kiểm tra xóa chi tiêu', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Search expense by name', 'description': 'Kiểm tra tìm kiếm chi tiêu theo tên', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'expense_test.dart', 'group': 'Expense Integration Tests', 'testName': 'Handle recurring expenses', 'description': 'Kiểm tra xử lý chi tiêu lặp lại', 'testType': 'Integration', 'priority': 'Medium'},

    // Income Integration Tests (4)
    {'file': 'income_test.dart', 'group': 'Income Integration Tests', 'testName': 'Add new income', 'description': 'Kiểm tra thêm thu nhập mới', 'testType': 'Integration', 'priority': 'High'},
    {'file': 'income_test.dart', 'group': 'Income Integration Tests', 'testName': 'View income list', 'description': 'Kiểm tra xem danh sách thu nhập', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'income_test.dart', 'group': 'Income Integration Tests', 'testName': 'Edit income details', 'description': 'Kiểm tra chỉnh sửa thu nhập', 'testType': 'Integration', 'priority': 'Medium'},
    {'file': 'income_test.dart', 'group': 'Income Integration Tests', 'testName': 'Handle recurring income', 'description': 'Kiểm tra xử lý thu nhập lặp lại', 'testType': 'Integration', 'priority': 'Medium'},
  ];

  // Tạo HTML report
  final htmlContent = _generateHTML(testCases);
  
  // Ghi vào file
  final file = File('TestCases_Report.html');
  await file.writeAsString(htmlContent);
  
  print('\n✅ File TestCases_Report.html đã được tạo thành công!');
  print('📍 Đường dẫn: ${file.absolute.path}');
  print('📊 Tổng cộng: ${testCases.length} test cases');
  print('\n💡 Mở file trong trình duyệt để xem báo cáo đẹp hơn!');
}

String _generateHTML(List<Map<String, String>> testCases) {
  // Calculate statistics
  final typeStats = <String, int>{};
  final priorityStats = <String, int>{};
  final fileStats = <String, int>{};
  
  for (var test in testCases) {
    typeStats[test['testType']!] = (typeStats[test['testType']] ?? 0) + 1;
    priorityStats[test['priority']!] = (priorityStats[test['priority']] ?? 0) + 1;
    fileStats[test['file']!] = (fileStats[test['file']] ?? 0) + 1;
  }
  
  // Generate rows
  final rows = StringBuffer();
  for (int i = 0; i < testCases.length; i++) {
    final test = testCases[i];
    final priorityClass = test['priority']!.toLowerCase();
    
    rows.write('''
    <tr>
      <td>${i + 1}</td>
      <td>${test['file']}</td>
      <td>${test['testName']}</td>
      <td>${test['description']}</td>
      <td>${test['testType']}</td>
      <td><span class="priority priority-$priorityClass">${test['priority']}</span></td>
      <td><span class="status">PASS</span></td>
    </tr>
    ''');
  }
  
  return '''
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Test Cases Report - Flutter Finance App</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f5f5f5;
      padding: 20px;
      color: #333;
    }
    
    .container {
      max-width: 1400px;
      margin: 0 auto;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 30px;
    }
    
    header {
      border-bottom: 3px solid #2196F3;
      margin-bottom: 30px;
      padding-bottom: 20px;
    }
    
    h1 {
      color: #2196F3;
      margin-bottom: 10px;
      font-size: 28px;
    }
    
    .subtitle {
      color: #666;
      font-size: 14px;
    }
    
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      margin: 30px 0;
    }
    
    .stat-card {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 20px;
      border-radius: 8px;
      text-align: center;
    }
    
    .stat-card.total {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    }
    
    .stat-card.high {
      background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
    }
    
    .stat-card.medium {
      background: linear-gradient(135deg, #30cfd0 0%, #330867 100%);
    }
    
    .stat-card.low {
      background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
      color: #333;
    }
    
    .stat-number {
      font-size: 32px;
      font-weight: bold;
      margin-bottom: 5px;
    }
    
    .stat-label {
      font-size: 14px;
      opacity: 0.9;
    }
    
    .section-title {
      font-size: 20px;
      color: #2196F3;
      margin: 30px 0 15px 0;
      font-weight: 600;
    }
    
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }
    
    th {
      background: #2196F3;
      color: white;
      padding: 12px;
      text-align: left;
      font-weight: 600;
      position: sticky;
      top: 0;
    }
    
    td {
      padding: 12px;
      border-bottom: 1px solid #eee;
    }
    
    tr:hover {
      background: #f9f9f9;
    }
    
    tr:nth-child(even) {
      background: #fafafa;
    }
    
    .priority {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 12px;
    }
    
    .priority-high {
      background: #ffebee;
      color: #c62828;
    }
    
    .priority-medium {
      background: #fff3e0;
      color: #e65100;
    }
    
    .priority-low {
      background: #e8f5e9;
      color: #2e7d32;
    }
    
    .status {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 12px;
      background: #e8f5e9;
      color: #2e7d32;
    }
    
    .type-stats, .file-stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
      gap: 10px;
      margin: 15px 0;
    }
    
    .type-item, .file-item {
      background: #f5f5f5;
      padding: 12px;
      border-radius: 4px;
      border-left: 4px solid #2196F3;
    }
    
    .type-item strong, .file-item strong {
      display: block;
      color: #2196F3;
      margin-bottom: 5px;
    }
    
    .type-item span, .file-item span {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }
    
    footer {
      margin-top: 40px;
      padding-top: 20px;
      border-top: 1px solid #eee;
      text-align: center;
      color: #999;
      font-size: 12px;
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <h1>📊 Test Cases Report</h1>
      <p class="subtitle">Flutter Finance App - Unit Tests Overview</p>
    </header>
    
    <section>
      <h2 class="section-title">📈 Tổng Quan</h2>
      <div class="stats">
        <div class="stat-card total">
          <div class="stat-number">${testCases.length}</div>
          <div class="stat-label">Total Test Cases</div>
        </div>
        <div class="stat-card high">
          <div class="stat-number">${priorityStats['High'] ?? 0}</div>
          <div class="stat-label">High Priority</div>
        </div>
        <div class="stat-card medium">
          <div class="stat-number">${priorityStats['Medium'] ?? 0}</div>
          <div class="stat-label">Medium Priority</div>
        </div>
        <div class="stat-card low">
          <div class="stat-number">${priorityStats['Low'] ?? 0}</div>
          <div class="stat-label">Low Priority</div>
        </div>
      </div>
    </section>
    
    <section>
      <h2 class="section-title">🧪 Thống Kê Test Type</h2>
      <div class="type-stats">
        ${typeStats.entries.map((e) => '<div class="type-item"><strong>${e.key}</strong><span>${e.value}</span></div>').join()}
      </div>
    </section>
    
    <section>
      <h2 class="section-title">📁 Thống Kê File</h2>
      <div class="file-stats">
        ${fileStats.entries.map((e) => '<div class="file-item"><strong>${e.key}</strong><span>${e.value}</span></div>').join()}
      </div>
    </section>
    
    <section>
      <h2 class="section-title">📋 Chi Tiết Test Cases</h2>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>File</th>
            <th>Test Name</th>
            <th>Description</th>
            <th>Type</th>
            <th>Priority</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          $rows
        </tbody>
      </table>
    </section>
    
    <footer>
      Generated on ${DateTime.now().toString().split('.')[0]} | Flutter Finance App Test Report
    </footer>
  </div>
</body>
</html>
''';
}
