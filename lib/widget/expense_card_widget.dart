import 'package:flutter/material.dart';

class ExpenseCardWidget extends StatelessWidget {
  const ExpenseCardWidget(
      {super.key,
      required this.leading,
      required this.title,
      required this.trailing,
      required this.onTap});
  final Widget leading;
  final String title;

  final Widget trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          removeRight: true,
          child: ListTile(
            onTap: onTap,
            leading: leading,
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w500),
            ),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
