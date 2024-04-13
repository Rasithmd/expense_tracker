import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.borderColor,
      required this.onPressed,
      required this.titleColor});
  final String title;
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: borderColor)))),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.bold),
          )),
    );
  }
}
