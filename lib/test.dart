import 'package:expense_tracker/model/expense_model.dart';

class Expense {
  List<ExpenseModel> expenseList = [];
  List<ExpenseModel> newList = [
    ExpenseModel(
        userId: 'userId',
        description: '',
        category: '',
        amount: 0,
        isRemainder: false),
    ExpenseModel(
        userId: 'userId1',
        description: '',
        category: '',
        amount: 0,
        isRemainder: false)
  ];

  final expense = ExpenseModel(
      userId: 'userId',
      description: '',
      category: '',
      amount: 0,
      isRemainder: false);
  void addExpense() {
    expenseList.add(expense);
  }

  void fetchData() {
    expenseList.addAll(newList);
  }

  void deleteExpense() {
    expenseList.removeWhere((element) => element.userId == 'userId');
  }
}
