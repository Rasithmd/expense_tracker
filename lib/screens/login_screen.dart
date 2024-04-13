import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/screens/create_user_screen.dart';
import 'package:expense_tracker/sereens/landing_screen.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/utils/session_manager.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:expense_tracker/widget/login_text_field.dart';

import 'package:expense_tracker/widget/password_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isLoading = false;

  void userValidation() async {
    if (emailId.text.isEmpty || password.text.isEmpty) {
      Utils.displaySnackBar(context, "User Name and password is Required");
    } else {
      await FirebaseFirestore.instance.collection("Users").get().then((value) {
        var users = value.docs
            .where((element) => element['emailId'] == emailId.text)
            .toList();
        if (users.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          SessionManager().setUserId(users.first.id);
          Timer(const Duration(seconds: 3), () {
            setState(() {
              ID = users.first.id;
              _isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingScreen()),
                (route) => false);
          });
        } else {
          Utils.displaySnackBar(context, "No User Found!!");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(143, 190, 170, 0.9),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Sign in to your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: LoginTextField(
                      placeholder: "E-mail",
                      inputType: TextInputType.emailAddress,
                      initialValue: '',
                      onChanged: (value) {
                        setState(() {
                          emailId.text = value!;
                        });
                      },
                      isRequired: true,
                      prefix: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey.shade600,
                          )),
                      field: 'email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                PasswordWidet(
                  placeholder: "Password",
                  inputType: TextInputType.text,
                  width: double.infinity,
                  borderRadius: 10,
                  initialValue: '',
                  field: "password",
                  onChanged: (value) {
                    setState(() {
                      password.text = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    IconButton(
                        onPressed: userValidation,
                        icon: _isLoading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : const Icon(
                                Icons.arrow_circle_right_sharp,
                                color: Colors.white,
                                size: 40,
                              ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateUserScreen(),
                        ));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't you have account?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Create",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
