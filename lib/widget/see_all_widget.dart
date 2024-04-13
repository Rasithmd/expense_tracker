import 'package:flutter/material.dart';

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        "See all",
        style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.outline,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
