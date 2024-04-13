// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(
      {super.key,
      required this.placeholder,
      required this.inputType,
      required this.initialValue,
      required this.isRequired,
      this.onChanged,
      required this.prefix,
      required this.field});
  String placeholder;
  TextInputType inputType;
  bool isRequired;
  String initialValue;
  String field;
  Widget prefix;
  Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: inputType == TextInputType.multiline ? null : 50,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: FormBuilderTextField(
        name: field,
        initialValue:
            initialValue == '' || initialValue == '0' ? null : initialValue,
        keyboardType: inputType,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please $placeholder';
                }
                if (inputType == TextInputType.emailAddress) {
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  return !emailValid
                      ? 'Please Enter valid email address'
                      : null;
                }
                return null;
              }
            : null,
        onChanged: onChanged,
        // style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        decoration: InputDecoration(
            fillColor: Colors.white,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.grey.shade400),
            prefixIcon: prefix,
            prefixIconConstraints: const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(),
            contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 4),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            filled: true,
            hintText: placeholder),
      ),
    );
  }
}
