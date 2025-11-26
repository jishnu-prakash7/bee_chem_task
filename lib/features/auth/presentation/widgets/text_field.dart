import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscure = false,
  VoidCallback? onToggle,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [ 
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: sl<SizeHelper>().getTextSize(13),
                color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: onToggle != null
                ? IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: onToggle,
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: sl<SizeHelper>().getWidgetWidth(10),
            ).copyWith(left: sl<SizeHelper>().getWidgetWidth(65)),
          ),
        ),
      ),
      Positioned(
        top: -5,
        child: Container(
          height: sl<SizeHelper>().getWidgetHeight(52),
          width: sl<SizeHelper>().getWidgetHeight(52),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black87),
        ),
      ),
    ],
  );
}
