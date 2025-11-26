import 'dart:convert';

import 'package:flutter/foundation.dart';

PersonnelListModel personnelListModelFromJson(String str) =>
    PersonnelListModel.fromJson(json.decode(str));

String personnelListModelToJson(PersonnelListModel data) =>
    json.encode(data.toJson());

class PersonnelListModel {
  bool status;
  List<PersonnelListDatum> data;

  PersonnelListModel({
    required this.status,
    required this.data,
  });

  factory PersonnelListModel.fromJson(Map<String, dynamic> json) =>
      PersonnelListModel(
        status: json["status"] ?? kFlutterMemoryAllocationsEnabled,
        data: List<PersonnelListDatum>.from(
            (json["data"] ?? []).map((x) => PersonnelListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PersonnelListDatum {
  int id;
  String firstName;
  String lastName;
  String address;
  String latitude;
  String longitude;
  String suburb;
  String state;
  String postcode;
  String country;
  String contactNumber;
  String additionalNotes;
  String status;
  String roleIds;
  String createdBy;
  String? updatedBy;
  List<RoleDetail> roleDetails;
  List<String> apiaryRoleArray;

  PersonnelListDatum({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.suburb,
    required this.state,
    required this.postcode,
    required this.country,
    required this.contactNumber,
    required this.additionalNotes,
    required this.status,
    required this.roleIds,
    required this.createdBy,
    required this.updatedBy,
    required this.roleDetails,
    required this.apiaryRoleArray,
  });

  factory PersonnelListDatum.fromJson(Map<String, dynamic> json) =>
      PersonnelListDatum(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        address: json["address"] ?? '',
        latitude: json["latitude"] ?? '',
        longitude: json["longitude"] ?? '',
        suburb: json["suburb"] ?? '',
        state: json["state"] ?? '',
        postcode: json["postcode"] ?? '',
        country: json["country"] ?? '',
        contactNumber: json["contact_number"] ?? '',
        additionalNotes: json["additional_notes"] ?? '',
        status: json["status"] ?? '',
        roleIds: json["role_ids"] ?? '',
        createdBy: json["created_by"] ?? '',
        updatedBy: json["updated_by"] ?? '',
        roleDetails: List<RoleDetail>.from(
            (json["role_details"] ?? []).map((x) => RoleDetail.fromJson(x))),
        apiaryRoleArray:
            List<String>.from((json["apiary_role_array"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "suburb": suburb,
        "state": state,
        "postcode": postcode,
        "country": country,
        "contact_number": contactNumber,
        "additional_notes": additionalNotes,
        "status": status,
        "role_ids": roleIds,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "role_details": List<dynamic>.from(roleDetails.map((x) => x.toJson())),
        "apiary_role_array": List<dynamic>.from(apiaryRoleArray.map((x) => x)),
      };
}

class RoleDetail {
  int id;
  String role;

  RoleDetail({
    required this.id,
    required this.role,
  });

  factory RoleDetail.fromJson(Map<String, dynamic> json) => RoleDetail(
        id: json["id"] ?? 0,
        role: json["role"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      };
}
