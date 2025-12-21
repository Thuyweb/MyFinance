import 'package:my_finance_app/models/payment_method.dart';
import 'package:my_finance_app/models/transaction.dart';
import 'package:my_finance_app/models/user.dart';

import 'budget.dart';
import 'category.dart';
import 'expense.dart';
import 'income.dart';

class ModelFactory {
  static T fromJson<T>(Map<String, dynamic> json) {
    if (T == ExpenseModel) return ExpenseModel.fromJson(json) as T;
    if (T == IncomeModel) return IncomeModel.fromJson(json) as T;
    if (T == CategoryModel) return CategoryModel.fromJson(json) as T;
    if (T == BudgetModel) return BudgetModel.fromJson(json) as T;
    if (T == TransactionModel) return TransactionModel.fromJson(json) as T;
    if (T == PaymentMethodModel) {
      return PaymentMethodModel.fromJson(json) as T;
    }
    if (T == UserModel) return UserModel.fromJson(json) as T;

    throw Exception('Unknown model type $T');
  }
}
