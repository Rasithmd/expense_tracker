import 'dart:async';

import 'package:expense_tracker/controller/notification_controller.dart';
import 'package:expense_tracker/screens/landing_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';

import 'package:expense_tracker/utils/const.dart';

import 'package:expense_tracker/utils/session_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // String id = '';

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    NotificationHelper().requestPermissionForNotification();

    await getUserData();
    Timer(const Duration(seconds: 3), () {
      if (ID == '') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (route) => false);
      }
    });
  }

  Future<void> getUserData() async {
    ID = (await SessionManager().getUserId()) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(143, 190, 170, 0.9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "EXPENSE MANAGER",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              Text(
                "---------------------------------------------",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ),
        ));
  }
}
