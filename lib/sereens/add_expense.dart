// ignore_for_file: unnecessary_new, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/color_extension.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/button_widget.dart';
import 'package:expense_tracker/widget/form_dropdown_widget.dart';
import 'package:expense_tracker/widget/form_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen(
      {super.key,
      required this.isEdit,
      required this.expenseModel,
      required this.callBack});
  final bool isEdit;
  final ExpenseModel expenseModel;
  final Function callBack;
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime date = new DateTime.now();
  String? selctedItem;
  void setExpenseId(String expenseId) {
    setState(() {
      widget.expenseModel.id = expenseId;
    });
  }

  void onSave() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      setState(() {
        if (widget.isEdit) {
          ExpenseController().updateExpense(widget.expenseModel);
        } else {
          widget.expenseModel.createdAt = Timestamp.now();
          ExpenseController().addExpense(widget.expenseModel, setExpenseId);

          ExpenseModel.allExpense.add(widget.expenseModel);
        }
      });
      widget.callBack();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormBuilderState>();

  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppTopBar(
              context: context,
              title: widget.isEdit ? "Edit Expense" : 'Add Expense',
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
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        height: media.width * 1.2,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            FormDropdownWidget(
                                callBack: (value) {
                                  setState(() {
                                    widget.expenseModel.category = value;
                                  });
                                },
                                initialValue: widget.expenseModel.category,
                                text: 'Select Category',
                                field: 'selectCategory'),
                            const SizedBox(height: 30),
                            FormTextFieldWidget(
                                onChanged: (value) {
                                  setState(() {
                                    widget.expenseModel.description = value!;
                                  });
                                },
                                placeholder: "Description",
                                inputType: TextInputType.name,
                                initialValue: widget.expenseModel.description,
                                isRequired: true,
                                field: "description"),
                            const SizedBox(height: 30),
                            FormTextFieldWidget(
                                onChanged: (value) {
                                  setState(() {
                                    widget.expenseModel.amount =
                                        double.parse(value!);
                                  });
                                },
                                placeholder: "Amount",
                                inputType: TextInputType.number,
                                initialValue: widget.expenseModel.amount == 0
                                    ? ''
                                    : widget.expenseModel.amount.toString(),
                                isRequired: true,
                                field: "amount"),
                            const SizedBox(height: 30),
                            date_time(),
                            const Spacer(),
                            SizedBox(
                              width: media.width * 0.7,
                              child: ButtonWidget(
                                onPressed: onSave,
                                title: "Save",
                                bgColor: Color(0xFF5C7C7C),
                                borderColor: Color(0xFF5C7C7C),
                                titleColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))),
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime.now());
          if (newDate == null) return;
          setState(() {
            date = newDate;
            widget.expenseModel.expenseDate = Timestamp.fromDate(date);
          });
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            'Date : ${date.day}.${date.month}.${date.year}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
