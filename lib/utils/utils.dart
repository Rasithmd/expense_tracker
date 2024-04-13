// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Utils {
  static void displaySnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20.0),
        content: Text(msg),
      ),
    );
  }

  static DateTime getMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  static DateTime getDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // static String requestTitle(RequestFormModel newRequest) {
  //   return USER_TYPE == UserType.member
  //       ? newRequest.category
  //       : "${newRequest.category} ($CURRENCY${newRequest.amountRequired.toInt().toString()})";
  // }
}
