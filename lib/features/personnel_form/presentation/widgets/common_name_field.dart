import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';

Widget commonNameField(
  TextEditingController controller,
  String hint, {
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: sl<SizeHelper>().getTextSize(13),
            color: Colors.grey[700],
            fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: sl<SizeHelper>().getWidgetWidth(16),
          vertical: sl<SizeHelper>().getWidgetHeight(12),
        ),
      ),
    ),
  );
}
