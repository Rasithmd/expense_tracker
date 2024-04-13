// ignore_for_file: must_be_immutable

import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/card11.png"),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Expense",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            ExpenseModel.allExpense.isEmpty
                ? "$CURRENCY 0"
                : "$CURRENCY ${ExpenseModel.allExpense.map((e) => e.amount).reduce((value, element) => value + element)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "No of expenses",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ExpenseModel.allExpense.length.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const ImageIcon(
                        AssetImage(IconPath.outward),
                        color: Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${DateFormat('MMM').format(DateTime.now())} - Outward",
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$CURRENCY${ExpenseModel.allExpense.where((element) => Utils.getMonth(DateTime.now()) == Utils.getMonth(element.expenseDate!.toDate())).isEmpty ? 0 : ExpenseModel.allExpense.where((element) => Utils.getMonth(DateTime.now()) == Utils.getMonth(element.expenseDate!.toDate())).map((e) => e.amount).reduce((value, element) => value + element)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
