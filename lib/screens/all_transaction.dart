// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/screens/expense_info_view.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/expense_card_widget.dart';
import 'package:expense_tracker/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllTransaction extends StatefulWidget {
  AllTransaction({super.key, required this.callBack});
  Function callBack;

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  Iterable<ExpenseModel> allExpense = ExpenseModel.allExpense;
  bool isLoading = false;

  void sortByNameAsc() {
    setState(() {
      allExpense = ExpenseModel.allExpense.toList()
        ..sort((a, b) => a.description.compareTo(b.description));
    });
  }

  void sortByNameDesc() {
    setState(() {
      allExpense = ExpenseModel.allExpense.toList()
        ..sort((a, b) => b.description.compareTo(a.description));
    });
  }

  void clear() {
    setState(() {
      allExpense = ExpenseModel.allExpense.toList();
    });
  }

  void refresh() {
    setState(() {
      isLoading = true;
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          isLoading = false;
        });
      });
      widget.callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    var amountStyle = TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onBackground,
        fontWeight: FontWeight.w400);
    var dateStyle = TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.outline,
        fontWeight: FontWeight.w400);
    return Scaffold(
      body: Stack(
        children: [
          AppTopBar(
            context: context,
            title: 'Transactions',
            height: 0.3,
            isVisibleBackArrow: true,
            isVisibleAction: true,
            sortByAsc: sortByNameAsc,
            sortByDesc: sortByNameDesc,
            clear: clear,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(76, 116, 116, 0.8),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
                  child: Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount: allExpense.length,
                          itemBuilder: (context, int index) {
                            var userExpense = allExpense.toList()[index];
                            return ExpenseCardWidget(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExpenseInfoView(
                                            callBack: refresh,
                                            data: userExpense)));
                              },
                              leading: ImageWidget(
                                imgPath: userExpense.category,
                                height: 40,
                                width: 40,
                              ),
                              title: userExpense.description,
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("$CURRENCY${userExpense.amount}",
                                      style: amountStyle),
                                  Text(
                                      DateFormat('dd.MM.yyyy').format(
                                          userExpense.expenseDate!.toDate()),
                                      style: dateStyle),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
