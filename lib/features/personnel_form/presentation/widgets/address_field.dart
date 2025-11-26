
  import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';

Widget addressField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ), 
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: sl<SizeHelper>().getTextSize(13),
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
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
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.grey,
            size: sl<SizeHelper>().getWidgetWidth(20),
          ),
          suffixIcon: Icon(
            Icons.gps_fixed,
            color: Colors.grey,
            size: sl<SizeHelper>().getWidgetWidth(20),
          ),
        ),
      ),
    );
  }
