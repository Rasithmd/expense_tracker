import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/color_extension.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/notification_controller.dart';
import 'package:expense_tracker/controller/user_controller.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/model/user_model.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/screens/category_view.dart';
import 'package:expense_tracker/screens/main_screen.dart';
import 'package:expense_tracker/screens/expense_overview.dart';
import 'package:expense_tracker/screens/profile_page.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const MainScreen();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await fetchUsersData(ID);
    await fetchAllRequest();
    await NotificationHelper().initializeNotification();
    await NotificationHelper()
        .scheduledNotification(hour: 23, minutes: 13, id: 0);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchUsersData(String userId) async {
    await UserController().retrieveSingleUsers(userId).then((value) {
      if (value != null) {
        setState(() {
          UserModel.singleUser = value;
        });
      }
    });
  }

  Future<void> fetchAllRequest() async {
    await ExpenseController().fetchExpense().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          ExpenseModel.allExpense = value;
        });
      }
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
    });
  }

  final List<Widget> _pages = [
    const MainScreen(),
    const SpendingByCategoryView(),
    const SalesOverviewPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(76, 116, 116, 0.8),
              ),
            )
          : Stack(children: [
              PageStorage(bucket: pageStorageBucket, child: _pages[selectTab]),
              SafeArea(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "images/img/bottom_bar_bg.png",
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectTab = 0;
                                      });
                                    },
                                    icon: Image.asset(
                                      "images/img/home.png",
                                      width: 20,
                                      height: 20,
                                      color: selectTab == 0
                                          ? AppColor.gray60
                                          : AppColor.gray10,
                                      //  Color(0x42037C7C),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectTab = 1;
                                      });
                                    },
                                    icon: Image.asset(
                                      "images/img/budgets.png",
                                      width: 20,
                                      height: 20,
                                      color: selectTab == 1
                                          ? AppColor.gray60
                                          : AppColor.gray10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                    height: 50,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectTab = 2;
                                      });
                                    },
                                    icon: Image.asset(
                                      "images/img/statistic.png",
                                      width: 25,
                                      height: 25,
                                      color: selectTab == 2
                                          ? AppColor.gray60
                                          : AppColor.gray10,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectTab = 3;
                                      });
                                    },
                                    icon: Image.asset(
                                      "images/img/user.png",
                                      width: 20,
                                      height: 20,
                                      color: selectTab == 3
                                          ? AppColor.gray60
                                          : AppColor.gray10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddExpenseScreen(
                                            isEdit: false,
                                            expenseModel: ExpenseModel(
                                                expenseDate: Timestamp.now(),
                                                userId: '',
                                                description: '',
                                                category: '',
                                                amount: 0,
                                                isRemainder: false),
                                            callBack: refresh,
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: AppColor.secondary.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4))
                              ], borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                "images/img/add_button.png",
                                width: 55,
                                height: 55,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
    );
  }
}
