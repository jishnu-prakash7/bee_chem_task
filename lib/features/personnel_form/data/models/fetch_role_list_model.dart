// To parse this JSON data, do
//
//     final fetchRoleListModel = fetchRoleListModelFromJson(jsonString);

import 'dart:convert';

List<FetchRoleListModel> fetchRoleListModelFromJson(String str) =>
    List<FetchRoleListModel>.from(
        json.decode(str).map((x) => FetchRoleListModel.fromJson(x)));

String fetchRoleListModelToJson(List<FetchRoleListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchRoleListModel {
  int id;
  String role;

  FetchRoleListModel({
    required this.id,
    required this.role,
  });

  factory FetchRoleListModel.fromJson(Map<String, dynamic> json) =>
      FetchRoleListModel(
        id: json["id"] ?? 0,
        role: json["role"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      };
}
