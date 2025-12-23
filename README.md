Ứng dụng Theo Dõi Chi Tiêu Cá nhân

Một ứng dụng quản lý tài chính cá nhân với chức năng sao lưu dữ liệu lên FirebaseStore.

# Các màn hình của ứng dụng

Màn hình Splash – Hiển thị khi khởi động, kèm animation

Onboarding – Thiết lập ứng dụng ban đầu

Dashboard – Trang chính với 5 tab:

Home: Tổng quan số dư và danh sách giao dịch gần đây, có các phần tử tương tác

Transactions: Danh sách giao dịch đầy đủ, có bộ lọc và tìm kiếm

Budget: Quản lý ngân sách với thanh tiến trình trực quan

Reports: Báo cáo và phân tích

Settings: Cài đặt ứng dụng

💾 Kiến trúc dữ liệu

Models: ExpenseModel, IncomeModel, CategoryModel, UserModel, BudgetModel, TransactionModel, SyncDataModel

Services: DatabaseService, GoogleDriveService, SyncService, NotificationService, ImagePickerService

Providers: ExpenseProvider, IncomeProvider, CategoryProvider, BudgetProvider, SyncProvider, UserSettingsProvider

🎨 Tính năng UI/UX

Material Design 3

Hỗ trợ chế độ Sáng / Tối

Tích hợp Google Fonts

Thiết kế responsive

Hỗ trợ ngôn ngữ Tiếng Anh Tiếng Việt

Định dạng tiền tệ (VNĐ) với dấu phân cách hàng nghìn

Animation và transition mượt mà

Bố cục sliver tùy chỉnh giúp tối ưu cuộn

Bottom sheet và modal tương tác


Công nghệ sử dụng

Flutter – Framework UI

Hive – Cơ sở dữ liệu nội bộ

Firebase - Lưu trữ phục vụ backup và restore

Provider – Quản lý trạng thái

Local Notifications – Thông báo nội bộ

Image Picker – Chụp ảnh hóa đơn

Cài đặt và thiết lập

Clone repository

Cài đặt thư viện:

flutter pub get

Chạy ứng dụng:

flutter run

Cấu trúc dự án
lib/
├── l10n/            # Đa ngôn ngữ
├── models/          # Các model dữ liệu (Hive kết hợp FireBase)
├── services/        # Các service backend
├── providers/       # State management
├── screens/         # Các màn hình UI
├── widgets/         # Các widget có thể tái sử dụng
└── utils/           # Tiện ích và theme
