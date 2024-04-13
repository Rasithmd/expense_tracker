// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormTextFieldWidget extends StatelessWidget {
  FormTextFieldWidget(
      {super.key,
      required this.placeholder,
      required this.inputType,
      required this.initialValue,
      required this.isRequired,
      this.onChanged,
      this.controller,
      required this.field});
  String placeholder;
  TextInputType inputType;
  bool isRequired;
  String initialValue;
  String field;

  TextEditingController? controller;
  Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      height: inputType == TextInputType.multiline ? null : 50,
      child: FormBuilderTextField(
        controller: controller,
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
        minLines: 4, // Set this
        maxLines: 5, // and this
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        decoration: InputDecoration(
          hoverColor: Colors.grey.shade500,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.grey.shade400),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 4),
          floatingLabelStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          label: Text(
            placeholder,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
