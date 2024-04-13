// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  ProfileMenuWidget(
      {super.key,
      required this.text,
      required this.avatar,
      required this.onTap});

  String text;
  String avatar;
  ValueGetter onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 45,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        avatar,
                        width: 20,
                        height: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 25,
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xDB343333),
                          ),
                        )),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Color(0xFF403737),
                    )
                  ]))),
    );
  }
}
