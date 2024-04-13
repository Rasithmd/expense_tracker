import 'package:expense_tracker/test.dart';
import 'package:test/test.dart';

void main() {
  test('Add Data to List', () {
    final testExpense = Expense();
    testExpense.addExpense();
    expect(testExpense.expenseList.first, testExpense.expense);
  });
  test('Delete Data From list', () {
    final testExpense = Expense();
    testExpense.deleteExpense();
    expect(testExpense.expenseList.length, 0);
  });
  test('Fetch All data', () {
    final testExpense = Expense();
    testExpense.fetchData();
    expect(testExpense.expenseList.length, 2);
  });
}
