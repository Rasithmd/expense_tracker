import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future logOutPopUp(context) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 30,
                bottom: 30,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black26)),
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Are you sure that you want to Logout?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: ButtonWidget(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                title: "Cancel",
                                bgColor: Colors.white,
                                borderColor:
                                    const Color.fromRGBO(92, 124, 124, 1),
                                titleColor:
                                    const Color.fromRGBO(92, 124, 124, 1)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          StatefulBuilder(builder: (context, setState) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: ButtonWidget(
                                title: "Logout",
                                bgColor: const Color.fromRGBO(92, 124, 124, 1),
                                borderColor:
                                    const Color.fromRGBO(92, 124, 124, 1),
                                titleColor: Colors.white,
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                      (Route<dynamic> route) => false,
                                    );
                                  });
                                },
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
