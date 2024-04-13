// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: must_be_immutable
class FormDropdownWidget extends StatefulWidget {
  const FormDropdownWidget({
    super.key,
    required this.callBack,
    required this.initialValue,
    required this.text,
    required this.field,
  });
  final Function callBack;
  final String initialValue;
  final String field;
  final String text;

  @override
  State<FormDropdownWidget> createState() => _FormDropdownWidgetState();
}

class _FormDropdownWidgetState extends State<FormDropdownWidget> {
  final List<String> _item = [
    'Entertainement',
    'Food & Drink',
    'General',
    'Home',
    'Life',
    'Transportation',
    'Utilities',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.of(context).size.width * 0.75,
      child: FormBuilderDropdown(
          initialValue: widget.initialValue == '' ? null : widget.initialValue,
          enabled: true,
          name: widget.field,
          validator: (value) {
            if (value == null) {
              return 'Please Select Category';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              widget.callBack(value);
            });
          },
          decoration: InputDecoration(
              hoverColor: Colors.grey.shade500,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey.shade400),
              errorBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(92, 124, 124, 1))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xffC5C5C5))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff368983))),
              suffixIconConstraints: const BoxConstraints(),
              contentPadding:
                  const EdgeInsets.only(left: 10, top: 20, bottom: 4),
              floatingLabelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              hintText: "Select Category"),
          items: _item.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'images/$item.png',
                      height: 40,
                      // width: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
            );
          }).toList()),
    );
  }
}
