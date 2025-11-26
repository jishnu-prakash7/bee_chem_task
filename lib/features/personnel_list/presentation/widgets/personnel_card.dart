
import 'package:flutter/material.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/personnel_list/data/models/personnel_list_model.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_text.dart';

class PersonnelCard extends StatelessWidget {
  final PersonnelListDatum personnel;

  const PersonnelCard({super.key, required this.personnel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sl<SizeHelper>().getWidgetHeight(16)),
      padding: EdgeInsets.all(sl<SizeHelper>().getWidgetWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: sl<SizeHelper>().getWidgetWidth(48),
                height: sl<SizeHelper>().getWidgetHeight(48),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 195, 75),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.people,
                  color: Colors.black,
                  size: sl<SizeHelper>().getWidgetWidth(24),
                ),
              ),
              SizedBox(width: sl<SizeHelper>().getWidgetWidth(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          fontSize: sl<SizeHelper>().getTextSize(15),
                          text: personnel.firstName,
                          textColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: sl<SizeHelper>().getWidgetWidth(8),
                              vertical: sl<SizeHelper>().getWidgetHeight(1)),
                          decoration: BoxDecoration(
                            color: personnel.status == "1"
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: personnel.status == "1"
                                  ? Colors.green
                                  : Colors.red,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: sl<SizeHelper>().getWidgetWidth(6),
                                height: sl<SizeHelper>().getWidgetHeight(6),
                                decoration: BoxDecoration(
                                  color: personnel.status == '1'
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                  width: sl<SizeHelper>().getWidgetWidth(4)),
                              CustomText(
                                fontSize: sl<SizeHelper>().getTextSize(12),
                                text: personnel.status == '1'
                                    ? 'Active'
                                    : 'Inactive',
                                textColor: personnel.status == '1'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                    Row(
                      children: [
                        Icon(Icons.phone,
                            size: sl<SizeHelper>().getWidgetWidth(12),
                            color: Colors.grey[600]),
                        SizedBox(width: sl<SizeHelper>().getWidgetWidth(4)),
                        CustomText(
                          fontSize: sl<SizeHelper>().getTextSize(12),
                          text: personnel.contactNumber,
                          textColor: Colors.grey[600]!,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(width: sl<SizeHelper>().getWidgetWidth(8)),
                        CustomText(
                          fontSize: sl<SizeHelper>().getTextSize(12),
                          text: '•',
                          textColor: Colors.grey[600]!,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(width: sl<SizeHelper>().getWidgetWidth(8)),
                        Icon(Icons.person,
                            size: sl<SizeHelper>().getWidgetWidth(12),
                            color: Colors.grey[600]),
                        SizedBox(width: sl<SizeHelper>().getWidgetWidth(4)),
                        CustomText(
                          fontSize: sl<SizeHelper>().getTextSize(12),
                          text: personnel.roleDetails.isNotEmpty
                              ? personnel.roleDetails.first.role
                              : "No Role",
                          textColor: Colors.grey[600]!,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on,
                  size: sl<SizeHelper>().getWidgetWidth(12),
                  color: Colors.grey[600]),
              SizedBox(width: sl<SizeHelper>().getWidgetWidth(4)),
              Expanded(
                child: CustomText(
                  fontSize: sl<SizeHelper>().getTextSize(12),
                  text: personnel.address,
                  textColor: Colors.grey[600]!,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

