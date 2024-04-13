// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LeadingWidget extends StatelessWidget {
  LeadingWidget(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.bgColor,
      required this.isCircle,
      this.onPressed,
      this.imgColor,
      required this.size});
  final String title;
  final String imageUrl;
  final bool isCircle;
  final Color bgColor;
  final double size;
  final Color? imgColor;
  ValueGetter? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(isCircle ? 50 : 5))),
          child: Center(
            child: imageUrl == ''
                ? Text(
                    !isCircle ? title : title.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                : Image.asset(
                    imageUrl,
                    height: 26,
                    width: 26,
                    color: imgColor == null ? null : Colors.white,
                  ),
          )),
    );
  }
}
