// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imgPath,
    required this.height,
    required this.width,
  });

  final String imgPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/${imgPath}.png",
      height: height,
      width: width,
    );
  }
}
