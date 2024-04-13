import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/button_widget.dart';
import 'package:expense_tracker/widget/expense_chart.dart';
import 'package:expense_tracker/widget/indicator.dart';
import 'package:flutter/material.dart';

class SalesOverviewPage extends StatefulWidget {
  const SalesOverviewPage({super.key});

  @override
  State<SalesOverviewPage> createState() => _SalesOverviewPageState();
}

class _SalesOverviewPageState extends State<SalesOverviewPage> {
  List<ExpenseModel> allExpense = ExpenseModel.allExpense;
  List items = [
    {
      "color": Colors.blue,
      "name": "Entertainement",
      "icon": "images/Entertainement.png",
    },
    {
      "color": Colors.yellow,
      "name": "Food & Drink",
      "icon": "images/Food & Drink.png",
    },
    {
      "color": Colors.red,
      "name": "General",
      "icon": "images/General.png",
    },
    {
      "color": Colors.purple,
      "name": "Home",
      "icon": "images/Home.png",
    },
    {
      "color": Colors.orange,
      "name": "Life",
      "icon": "images/Life.png",
    },
    {
      "color": Colors.brown,
      "name": "Transportation",
      "icon": "images/Transportation.png",
    },
    {
      "color": Colors.grey,
      "name": "Utilities",
      "icon": "images/Utilities.png",
    },
  ];
  int selectedIndex = -1;
  void getTodayData() {
    setState(() {
      allExpense = ExpenseModel.allExpense
          .where((element) =>
              Utils.getDay(element.expenseDate!.toDate()) ==
              Utils.getDay(DateTime.now()))
          .toList();
      selectedIndex = 0;
      getData();
    });
  }

  void getWeeklyData() {
    setState(() {
      allExpense = ExpenseModel.allExpense
          .where((element) => element.expenseDate!.toDate().isAfter(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 7)))
          .toList();
      selectedIndex = 1;
      getData();
    });
  }

  void getMonthlyData() {
    setState(() {
      allExpense = ExpenseModel.allExpense
          .where((element) =>
              Utils.getMonth(element.expenseDate!.toDate()) ==
              Utils.getMonth(DateTime.now()))
          .toList();
      selectedIndex = 2;
      getData();
    });
  }

  void clear() {
    setState(() {
      allExpense = ExpenseModel.allExpense;
      selectedIndex = -1;
      getData();
    });
  }

  List cat = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    setState(() {
      cat = [];
      for (int i = 0; i < items.length; i++) {
        if (allExpense
            .where((element) => element.category == items[i]['name'])
            .isNotEmpty) {
          cat.add(items[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppTopBar(
              context: context,
              title: "Summery",
              height: 0.3,
              isVisibleBackArrow: false,
              isVisibleAction: false),
          // TopBackGround(
          //   height: 0.3,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (ExpenseModel.allExpense.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonWidget(
                          title: 'All',
                          bgColor: selectedIndex == -1
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1),
                          borderColor: const Color.fromRGBO(92, 124, 124, 1),
                          onPressed: clear,
                          titleColor: selectedIndex != -1
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1)),
                      ButtonWidget(
                          title: 'Today',
                          bgColor: selectedIndex == 0
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1),
                          borderColor: const Color.fromRGBO(92, 124, 124, 1),
                          onPressed: getTodayData,
                          titleColor: selectedIndex != 0
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1)),
                      ButtonWidget(
                          title: 'Weekly',
                          bgColor: selectedIndex == 1
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1),
                          borderColor: const Color.fromRGBO(92, 124, 124, 1),
                          onPressed: getWeeklyData,
                          titleColor: selectedIndex != 1
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1)),
                      ButtonWidget(
                          title: 'Monthly',
                          bgColor: selectedIndex == 2
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1),
                          borderColor: const Color.fromRGBO(92, 124, 124, 1),
                          onPressed: getMonthlyData,
                          titleColor: selectedIndex != 2
                              ? Colors.white
                              : const Color.fromRGBO(92, 124, 124, 1)),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (allExpense.isNotEmpty)
                  ExpenseChart(
                    expenseList: allExpense,
                    category: cat,
                  ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 10,
                    children: <Widget>[
                      for (int i = 0; i < cat.length; i++)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Indicator(
                            color: cat[i]['color'],
                            text: cat[i]['name'],
                            isSquare: false,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (allExpense.isNotEmpty)
                  Text(
                    "Total Expense: $CURRENCY${allExpense.map((element) => element.amount).reduce((value, element) => value + element)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
