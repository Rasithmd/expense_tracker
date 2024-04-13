// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? id;
  String userId;
  String description;
  String category;
  double amount;
  Timestamp? createdAt;
  Timestamp? expenseDate;
  bool isRemainder;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.description,
    required this.category,
    required this.amount,
    this.createdAt,
    this.expenseDate,
    required this.isRemainder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'description': description,
      'category': category,
      'amount': amount,
      'createdAt': Timestamp.now(),
      'expenseDate': expenseDate,
      'isRemainder': isRemainder,
    };
  }

  factory ExpenseModel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return ExpenseModel(
      id: map.id,
      userId: map['userId'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      createdAt: map['createdAt'] as dynamic,
      expenseDate: map['expenseDate'] as dynamic,
      isRemainder: map['isRemainder'] as bool,
    );
  }

  static List<ExpenseModel> allExpense =
      List<ExpenseModel>.empty(growable: true);
  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) => ExpenseModel.fromMap(
      json.decode(source) as QueryDocumentSnapshot<Map<String, dynamic>>);
}
