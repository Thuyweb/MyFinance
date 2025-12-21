import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String currency; // Default currency (VNĐ, USD, ...)

  @HiveField(2)
  String? googleAccountEmail;

  @HiveField(3)
  String? googleAccountName;

  @HiveField(4)
  bool isBackupEnabled;

  @HiveField(5)
  DateTime? lastBackupDate;

  @HiveField(6)
  DateTime? lastSyncDate;

  @HiveField(7)
  bool notificationEnabled;

  @HiveField(8)
  String? notificationTime;

  @HiveField(9)
  bool biometricEnabled;

  @HiveField(10)
  String theme; // 'light', 'dark', 'system'

  @HiveField(11)
  String language; // 'vi', 'en'

  @HiveField(12)
  DateTime createdAt;

  @HiveField(13)
  DateTime updatedAt;

  @HiveField(14)
  double? monthlyBudgetLimit;

  @HiveField(15)
  bool budgetAlertEnabled;

  @HiveField(16)
  int budgetAlertPercentage;

  @HiveField(17)
  String? pinCode; // HASHED PIN

  @HiveField(18)
  bool pinEnabled;

  @HiveField(19)
  bool isSetupCompleted;

  @HiveField(20)
  int backgroundLockTimeout;

  /// 🔑 RECOVERY CODE (QUAN TRỌNG)
  @HiveField(21)
  String? recoveryCode;

  UserModel({
    required this.id,
    this.currency = 'VNĐ',
    this.googleAccountEmail,
    this.googleAccountName,
    this.isBackupEnabled = false,
    this.lastBackupDate,
    this.lastSyncDate,
    this.notificationEnabled = true,
    this.notificationTime,
    this.biometricEnabled = false,
    this.theme = 'system',
    this.language = 'vi',
    required this.createdAt,
    required this.updatedAt,
    this.monthlyBudgetLimit,
    this.budgetAlertEnabled = true,
    this.budgetAlertPercentage = 80,
    this.pinCode,
    this.pinEnabled = false,
    this.isSetupCompleted = false,
    this.backgroundLockTimeout = 120,
    this.recoveryCode,
  });

  // =========================
  // 🔁 BACKUP → JSON
  // =========================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency': currency,
      'googleAccountEmail': googleAccountEmail,
      'googleAccountName': googleAccountName,
      'isBackupEnabled': isBackupEnabled,
      'lastBackupDate': lastBackupDate?.toIso8601String(),
      'lastSyncDate': lastSyncDate?.toIso8601String(),
      'notificationEnabled': notificationEnabled,
      'notificationTime': notificationTime,
      'biometricEnabled': biometricEnabled,
      'theme': theme,
      'language': language,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'monthlyBudgetLimit': monthlyBudgetLimit,
      'budgetAlertEnabled': budgetAlertEnabled,
      'budgetAlertPercentage': budgetAlertPercentage,
      'pinCode': pinCode,
      'pinEnabled': pinEnabled,
      'isSetupCompleted': isSetupCompleted,
      'backgroundLockTimeout': backgroundLockTimeout,
      'recoveryCode': recoveryCode,
    };
  }

  // =========================
  // 🔁 RESTORE ← JSON
  // =========================
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      currency: json['currency'] ?? 'VNĐ',
      googleAccountEmail: json['googleAccountEmail'],
      googleAccountName: json['googleAccountName'],
      isBackupEnabled: json['isBackupEnabled'] ?? false,
      lastBackupDate: json['lastBackupDate'] != null
          ? DateTime.parse(json['lastBackupDate'])
          : null,
      lastSyncDate: json['lastSyncDate'] != null
          ? DateTime.parse(json['lastSyncDate'])
          : null,
      notificationEnabled: json['notificationEnabled'] ?? true,
      notificationTime: json['notificationTime'],
      biometricEnabled: json['biometricEnabled'] ?? false,
      theme: json['theme'] ?? 'system',
      language: json['language'] ?? 'vi',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      monthlyBudgetLimit: json['monthlyBudgetLimit']?.toDouble(),
      budgetAlertEnabled: json['budgetAlertEnabled'] ?? true,
      budgetAlertPercentage: json['budgetAlertPercentage'] ?? 80,
      pinCode: json['pinCode'],
      pinEnabled: json['pinEnabled'] ?? false,
      isSetupCompleted: json['isSetupCompleted'] ?? false,
      backgroundLockTimeout: json['backgroundLockTimeout'] ?? 120,
      recoveryCode: json['recoveryCode'],
    );
  }

  // =========================
  // ✏️ COPY WITH
  // =========================
  UserModel copyWith({
    String? currency,
    String? googleAccountEmail,
    String? googleAccountName,
    bool? isBackupEnabled,
    DateTime? lastBackupDate,
    DateTime? lastSyncDate,
    bool? notificationEnabled,
    String? notificationTime,
    bool? biometricEnabled,
    String? theme,
    String? language,
    DateTime? updatedAt,
    double? monthlyBudgetLimit,
    bool? budgetAlertEnabled,
    int? budgetAlertPercentage,
    String? pinCode,
    bool? pinEnabled,
    bool? isSetupCompleted,
    int? backgroundLockTimeout,
    String? recoveryCode,
  }) {
    return UserModel(
      id: id,
      currency: currency ?? this.currency,
      googleAccountEmail: googleAccountEmail ?? this.googleAccountEmail,
      googleAccountName: googleAccountName ?? this.googleAccountName,
      isBackupEnabled: isBackupEnabled ?? this.isBackupEnabled,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      lastSyncDate: lastSyncDate ?? this.lastSyncDate,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      monthlyBudgetLimit: monthlyBudgetLimit ?? this.monthlyBudgetLimit,
      budgetAlertEnabled: budgetAlertEnabled ?? this.budgetAlertEnabled,
      budgetAlertPercentage:
          budgetAlertPercentage ?? this.budgetAlertPercentage,
      pinCode: pinCode ?? this.pinCode,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
      backgroundLockTimeout:
          backgroundLockTimeout ?? this.backgroundLockTimeout,
      recoveryCode: recoveryCode ?? this.recoveryCode,
    );
  }

  bool get hasRecoveryCode => recoveryCode != null && recoveryCode!.isNotEmpty;

  // =========================
  bool get isGoogleLinked =>
      googleAccountEmail != null && googleAccountEmail!.isNotEmpty;
}
