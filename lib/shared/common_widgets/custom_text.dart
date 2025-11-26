import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final Color? textColor;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final TextAlign? align;
  final TextDecoration? decoration;

  final int? maxLines;

  const CustomText(
      {super.key,
      required this.fontSize,
      required this.text,
      required this.fontWeight,
      this.textColor,
      this.letterSpacing,
      this.overflow,
      this.maxLines,
      this.align,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          color: textColor ?? Colors.black,
          overflow: overflow ?? TextOverflow.ellipsis,
          decoration: decoration,
          decorationColor: textColor),
      maxLines: maxLines ?? 50,
      textAlign: align,
    );
  }
}
