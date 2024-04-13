// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PasswordWidet extends StatefulWidget {
  PasswordWidet(
      {super.key,
      required this.placeholder,
      required this.inputType,
      required this.width,
      required this.borderRadius,
      this.bgColor,
      required this.initialValue,
      this.onChanged,
      required this.field});
  String placeholder;
  TextInputType inputType;
  double borderRadius;
  double width;
  String initialValue;
  Color? bgColor;
  String field;
  Function(String?)? onChanged;

  @override
  State<PasswordWidet> createState() => _PasswordWidetState();
}

class _PasswordWidetState extends State<PasswordWidet> {
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width * widget.width,
      child: FormBuilderTextField(
        obscureText: isVisibility,
        name: widget.field,
        initialValue: widget.initialValue == '' ? null : widget.initialValue,
        keyboardType: widget.inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter ${widget.placeholder}';
          }

          return null;
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.grey.shade400),
            prefixIcon: Container(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.lock,
                  color: Colors.grey.shade600,
                )),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isVisibility = !isVisibility;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: !isVisibility
                    ? Image.asset(
                        "images/icons/close-eye.png",
                        width: 15,
                        height: 20,
                      )
                    : Image.asset(
                        "images/icons/eye.png",
                        width: 15,
                        height: 20,
                      ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(),
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            floatingLabelStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
