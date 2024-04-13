import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
