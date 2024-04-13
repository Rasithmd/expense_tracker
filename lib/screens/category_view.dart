// ignore_for_file: unused_local_variable
import 'package:expense_tracker/common/color_extension.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/expense_card_widget.dart';
import 'package:flutter/material.dart';

class SpendingByCategoryView extends StatefulWidget {
  const SpendingByCategoryView({super.key});

  @override
  State<SpendingByCategoryView> createState() => _SpendingByCategoryViewState();
}

class _SpendingByCategoryViewState extends State<SpendingByCategoryView> {
  List items = [
    {
      "name": "Entertainement",
      "icon": "images/Entertainement.png",
    },
    {
      "name": "Food & Drink",
      "icon": "images/Food & Drink.png",
    },
    {
      "name": "General",
      "icon": "images/General.png",
    },
    {
      "name": "Home",
      "icon": "images/Home.png",
    },
    {
      "name": "Life",
      "icon": "images/Life.png",
    },
    {
      "name": "Transportation",
      "icon": "images/Transportation.png",
    },
    {
      "name": "Utilities",
      "icon": "images/Utilities.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AppTopBar(
            context: context,
            title: 'Category',
            height: 0.3,
            isVisibleBackArrow: false,
            isVisibleAction: false,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var data = items[index];
                        return ExpenseCardWidget(
                            leading: Image.asset(
                              data['icon'],
                              height: 40,
                              width: 40,
                              // color: AppColor.gray40,
                            ),
                            title: data['name'],
                            trailing: Text(
                              "$CURRENCY${ExpenseModel.allExpense.where((element) => element.category == data['name']).isEmpty ? 0 : ExpenseModel.allExpense.where((element) => element.category == data['name']).map((e) => e.amount).reduce((value, element) => value + element)}",
                              style: TextStyle(
                                  color: AppColor.gray80,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {});
                      }),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
