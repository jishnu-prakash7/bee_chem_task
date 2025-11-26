
  import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';

Widget notesField({required BuildContext context, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            buildCounter: (
              context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              return const SizedBox.shrink();
            },
            decoration: InputDecoration(
              hintText: 'Please type',
              hintStyle: TextStyle(
                fontSize: sl<SizeHelper>().getTextSize(13),
                color: Colors.grey[700],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(
                sl<SizeHelper>().getWidgetWidth(12),
              ),
            ),
          ),
        ),
        SizedBox(height: sl<SizeHelper>().getWidgetHeight(4)),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            return Text(
              "${value.text.length}/500",
              style: TextStyle(
                fontSize: sl<SizeHelper>().getTextSize(12),
                color: Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }