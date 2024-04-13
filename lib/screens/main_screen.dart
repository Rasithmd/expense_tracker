import 'dart:async';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/model/user_model.dart';
import 'package:expense_tracker/screens/all_transaction.dart';
import 'package:expense_tracker/screens/expense_info_view.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/card_widget.dart';
import 'package:expense_tracker/widget/image_widget.dart';
import 'package:expense_tracker/widget/leading_widget.dart';
import 'package:expense_tracker/widget/see_all_widget.dart';
import 'package:expense_tracker/widget/top_background.dart';
import 'package:expense_tracker/widget/expense_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  void refresh() {
    setState(() {
      isLoading = true;
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ExpenseModel.allExpense
        .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
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
          TopBackGround(
            height: 0.3,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 10,
            ),
            child: ListTile(
              title: const Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                UserModel.singleUser.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              trailing: LeadingWidget(
                title: '',
                imgColor: Colors.white,
                imageUrl: IconPath.notification,
                bgColor: const Color.fromRGBO(255, 255, 255, 0.333),
                isCircle: false,
                size: 38,
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(76, 116, 116, 0.8),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 140,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.24,
                        child: const CardWidget(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transactions',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold),
                          ),
                          SeeAllWidget(onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllTransaction(
                                          callBack: refresh,
                                        )));
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              itemCount: ExpenseModel.allExpense.length >= 4
                                  ? 4
                                  : ExpenseModel.allExpense.length,
                              itemBuilder: (context, int index) {
                                var userExpense =
                                    ExpenseModel.allExpense[index];

                                return ExpenseCardWidget(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ExpenseInfoView(
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
                                              userExpense.expenseDate!
                                                  .toDate()),
                                          style: dateStyle),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
