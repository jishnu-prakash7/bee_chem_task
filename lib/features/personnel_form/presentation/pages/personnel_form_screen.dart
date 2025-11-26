import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/fetch_location.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/personnel_form/data/models/fetch_role_list_model.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/bloc/personnel_form_bloc.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/widgets/address_field.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/widgets/common_name_field.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/widgets/notes_field.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_snackbar.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_text.dart';
import 'package:geolocator/geolocator.dart';

class PersonnelFormScreen extends StatefulWidget {
  const PersonnelFormScreen({super.key});

  @override
  State<PersonnelFormScreen> createState() => _PersonnelFormScreenState();
}

class _PersonnelFormScreenState extends State<PersonnelFormScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _suburbController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool _status = true;
  FetchRoleListModel? _selectedRole;

  Position? position;

  @override
  void initState() {
    sl<PersonnelFormBloc>().add(FetchRoleListEvent());
    fetchLocation();
    super.initState();
  }

  fetchLocation() async {
    position = await fetchLocationDetails(context);
    log("lat ${position?.latitude} lang ${position?.longitude}");
  }

  bool validateForm() {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (_fullNameController.text.trim().isEmpty) {
      customSnackbar(context, "Full name is required");
      return false;
    } else if (_addressController.text.trim().isEmpty) {
      customSnackbar(context, "Address is required");
      return false;
    } else if (_suburbController.text.trim().isEmpty) {
      customSnackbar(context, "Suburb is required");
      return false;
    } else if (_countryController.text.trim().isEmpty) {
      customSnackbar(context, "Country is required");
      return false;
    } else if (_stateController.text.trim().isEmpty) {
      customSnackbar(context, "State is required");
      return false;
    } else if (_postCodeController.text.trim().isEmpty) {
      customSnackbar(context, "Postcode is required");
      return false;
    } else if (_contactController.text.trim().isEmpty) {
      customSnackbar(context, "Contact number is required");
      return false;
    } else if (_contactController.text.length < 10) {
      customSnackbar(context, "Enter a valid phone number");
      return false;
    } else if (_notesController.text.trim().isEmpty) {
      customSnackbar(context, "Notes cannot be empty");
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _suburbController.dispose();
    _stateController.dispose();
    _postCodeController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<PersonnelFormBloc, PersonnelFormState>(
        bloc: sl<PersonnelFormBloc>(),
        listener: (context, state) {
          if (state is AddPersonnelDataSuccessState) {
            customSnackbar(context, "Personnel details added successfully.");
            Navigator.pop(context);
            _fullNameController.clear();
            _addressController.clear();
            _suburbController.clear();
            _stateController.clear();
            _postCodeController.clear();
            _contactController.clear();
            _notesController.clear();
            _countryController.clear();
          } else if (state is AddPersonnelDataFailedState) {
            customSnackbar(
                context, "Failed to add personnel details. Please try again.");
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: sl<SizeHelper>().getWidgetHeight(180),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/registration/registration_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sl<SizeHelper>().getWidgetWidth(30)),
                    child: Column(
                      children: [
                        SizedBox(height: sl<SizeHelper>().getWidgetHeight(35)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: sl<SizeHelper>().getWidgetHeight(30),
                              height: sl<SizeHelper>().getWidgetHeight(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.grid_view_outlined,
                                size: sl<SizeHelper>().getWidgetWidth(18),
                              ),
                            ),
                            Container(
                              width: sl<SizeHelper>().getWidgetHeight(30),
                              height: sl<SizeHelper>().getWidgetHeight(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                size: sl<SizeHelper>().getWidgetWidth(18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                        CustomText(
                          fontSize: sl<SizeHelper>().getTextSize(20),
                          text: 'Personnel Details',
                          textColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(sl<SizeHelper>().getWidgetWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Full name',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      commonNameField(_fullNameController, 'Please type'),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Address',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      addressField(_addressController, 'Please type'),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Suburb',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      commonNameField(_suburbController, 'Please type'),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Country',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      commonNameField(_countryController, 'Please type'),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  fontSize: sl<SizeHelper>().getTextSize(13),
                                  text: 'State',
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                    height:
                                        sl<SizeHelper>().getWidgetHeight(8)),
                                commonNameField(
                                    _stateController, 'Please type'),
                              ],
                            ),
                          ),
                          SizedBox(width: sl<SizeHelper>().getWidgetWidth(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  fontSize: sl<SizeHelper>().getTextSize(13),
                                  text: 'Post code',
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ), 
                                SizedBox(
                                    height:
                                        sl<SizeHelper>().getWidgetHeight(8)),
                                commonNameField(
                                    _postCodeController, 'Please type'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Contact number',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      commonNameField(_contactController, 'Please type',
                          keyboardType: TextInputType.phone),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Role',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(12)),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        constraints: BoxConstraints(
                          maxHeight: sl<SizeHelper>().getWidgetHeight(150),
                        ),
                        child: state is FetchRoleListLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 3,
                                ),
                              )
                            : state is FetchRoleListSuccessState
                                ? SingleChildScrollView(
                                    child: Column(children: [
                                      SizedBox(
                                        height: sl<SizeHelper>()
                                            .getWidgetHeight(10),
                                      ),
                                      ...state.roleList.map((role) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedRole = role;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: sl<SizeHelper>()
                                                    .getWidgetHeight(12)),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: sl<SizeHelper>()
                                                  .getWidgetWidth(16),
                                              vertical: sl<SizeHelper>()
                                                  .getWidgetHeight(3),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: sl<SizeHelper>()
                                                      .getWidgetWidth(18),
                                                  height: sl<SizeHelper>()
                                                      .getWidgetHeight(18),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _selectedRole ==
                                                              role
                                                          ? Colors.green
                                                          : Colors.grey[700]!,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: _selectedRole == role
                                                      ? Icon(
                                                          Icons.check,
                                                          size: sl<SizeHelper>()
                                                              .getWidgetWidth(
                                                                  14),
                                                          color: Colors.green,
                                                        )
                                                      : null,
                                                ),
                                                SizedBox(
                                                    width: sl<SizeHelper>()
                                                        .getWidgetWidth(12)),
                                                CustomText(
                                                  fontSize: sl<SizeHelper>()
                                                      .getTextSize(14),
                                                  text: role.role,
                                                  textColor: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ]),
                                  )
                                : state is FetchRoleListFailedState
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              fontSize: sl<SizeHelper>()
                                                  .getTextSize(15),
                                              text: state.error,
                                              textColor: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.amber),
                                              onPressed: () {
                                                sl<PersonnelFormBloc>()
                                                    .add(FetchRoleListEvent());
                                              },
                                              child: CustomText(
                                                fontSize: sl<SizeHelper>()
                                                    .getTextSize(16),
                                                text: "Retry",
                                                textColor: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(13),
                        text: 'Additional Notes',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(8)),
                      notesField(
                          context: context, controller: _notesController),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sl<SizeHelper>().getWidgetWidth(16),
                          vertical: sl<SizeHelper>().getWidgetHeight(12),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              fontSize: sl<SizeHelper>().getTextSize(13),
                              text: 'Status',
                              textColor: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            CupertinoSwitch(
                              value: _status,
                              onChanged: (value) {
                                setState(() {
                                  _status = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(30)),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                _fullNameController.clear();
                                _addressController.clear();
                                _suburbController.clear();
                                _stateController.clear();
                                _postCodeController.clear();
                                _contactController.clear();
                                _notesController.clear();
                                _countryController.clear();
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: sl<SizeHelper>().getWidgetHeight(50),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: CustomText(
                                    fontSize: sl<SizeHelper>().getTextSize(16),
                                    text: 'CANCEL',
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: sl<SizeHelper>().getWidgetWidth(16)),
                          Expanded(
                            child: state is AddPersonnelDataLoadingState
                                ? InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () async {},
                                    child: Container(
                                      height:
                                          sl<SizeHelper>().getWidgetHeight(50),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFDB514),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () async {
                                      if (validateForm()) {
                                        if (position != null) {
                                          sl<PersonnelFormBloc>().add(
                                              AddPersonnelDataEvent(
                                                  firstName: _fullNameController
                                                      .text
                                                      .trim(),
                                                  address: _addressController.text
                                                      .trim(),
                                                  latitude:
                                                      "${position?.latitude}",
                                                  longitude:
                                                      "${position?.longitude}",
                                                  suburb: _suburbController.text
                                                      .trim(),
                                                  state: _stateController.text
                                                      .trim(),
                                                  postcode: _postCodeController
                                                      .text
                                                      .trim(),
                                                  contactNumber:
                                                      _contactController.text
                                                          .trim(),
                                                  roleIds: _selectedRole?.id
                                                          .toString() ??
                                                      '',
                                                  status: _status ? "1" : "0",
                                                  country: _countryController
                                                      .text
                                                      .trim()));
                                        } else {
                                          position = await fetchLocationDetails(
                                              context);
                                          if (!context.mounted) return;
                                          customSnackbar(context,
                                              "Please enable location");
                                        }
                                      }
                                    },
                                    child: Container(
                                      height:
                                          sl<SizeHelper>().getWidgetHeight(50),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFDB514),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          fontSize:
                                              sl<SizeHelper>().getTextSize(16),
                                          text: 'SAVE',
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
