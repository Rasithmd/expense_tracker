import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/session_manager.dart';

String collectionName = 'Expense';

class ExpenseController {
  final _db = FirebaseFirestore.instance.collection(collectionName).doc();
  final _db_ref = FirebaseFirestore.instance.collection(collectionName);

  addExpense(ExpenseModel expenseModel, Function getExpense) async {
    expenseModel.userId = await SessionManager().getUserId() ?? '';
    expenseModel.id = _db.id;
    getExpense(_db.id);
    await _db.set(expenseModel.toMap());
  }

  Future<List<ExpenseModel>> fetchExpense() async {
    var userId = await SessionManager().getUserId() ?? '';
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db_ref.where('userId', isEqualTo: userId).get();
    return snapshot.docs
        .map((docSnapshot) => ExpenseModel.fromMap(docSnapshot))
        .toList();
  }

  updateExpense(ExpenseModel expenseModel) async =>
      await _db_ref.doc(expenseModel.id).update(expenseModel.toMap());

  deleteExpense(String expense) async => await _db_ref.doc(expense).delete();
}
