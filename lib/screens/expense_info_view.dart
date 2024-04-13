import 'package:expense_tracker/common/color_extension.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/image_widget.dart';
import 'package:expense_tracker/widget/item_row.dart';
import 'package:expense_tracker/widget/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

class ExpenseInfoView extends StatefulWidget {
  final ExpenseModel data;
  final Function callBack;
  const ExpenseInfoView(
      {super.key, required this.data, required this.callBack});

  @override
  State<ExpenseInfoView> createState() => _ExpenseInfoViewState();
}

class _ExpenseInfoViewState extends State<ExpenseInfoView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppTopBar(
              context: context,
              title: 'Expense Info',
              height: 0.3,
              isVisibleBackArrow: true,
              isVisibleAction: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      height: media.width * 0.75,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddExpenseScreen(
                                                isEdit: true,
                                                expenseModel: widget.data,
                                                callBack: () {
                                                  widget.callBack();
                                                },
                                              )));
                                },
                                icon: Icon(Icons.edit_note_rounded,
                                    size: 35, color: AppColor.gray30),
                              ),
                              IconButton(
                                onPressed: () {
                                  deletePopUp(
                                      context, widget.data.id, widget.callBack);
                                },
                                icon: Image.asset("images/img/Trash.png",
                                    width: 25,
                                    height: 25,
                                    color: AppColor.gray30),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ImageWidget(
                              imgPath: widget.data.category,
                              height: media.width * 0.25,
                              width: media.width * 0.25),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.data.description,
                            style: TextStyle(
                                color: AppColor.secondaryText,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "$CURRENCY${widget.data.amount}",
                            style: TextStyle(
                                color: AppColor.gray30,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.border.withOpacity(0.1),
                              ),
                              color: AppColor.gray10.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ItemRow(
                                  title: "Name",
                                  value: widget.data.description,
                                ),
                                // ItemRow(
                                //   title: "Description",
                                //   value: "Music app",
                                // ),
                                ItemRow(
                                  title: "Category",
                                  value: widget.data.category,
                                ),
                                ItemRow(
                                  title: "Date",
                                  value: DateFormat('dd.MM.yyyy').format(
                                      widget.data.expenseDate!.toDate()),
                                ),
                                const ItemRow(
                                  title: "Reminder",
                                  value: "Never",
                                ),
                                ItemRow(
                                  title: "Currency",
                                  value: "INR ($CURRENCY)",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 45, left: 4, right: 4),
              height: media.width * 0.96 + 15,
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30)),
                ),
                Expanded(
                    child: DottedBorder(
                  dashPattern: const [5, 10],
                  padding: EdgeInsets.zero,
                  strokeWidth: 1,
                  radius: const Radius.circular(16),
                  color: AppColor.gray30,
                  child: const SizedBox(
                    height: 0,
                  ),
                )),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
