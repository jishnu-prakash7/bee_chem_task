import 'package:g3_interactive_task/features/personnel_list/domain/entities/personnel_list_entity.dart';

class PersonnelListModel extends PersonnelListEntity {
  PersonnelListModel({
    required super.status,
    required super.data,
  });

  factory PersonnelListModel.fromJson(Map<String, dynamic> json) =>
      PersonnelListModel(
        status: json["status"] ?? false,
        data: List<PersonnelListDatumModel>.from(
          (json["data"] ?? []).map((x) => PersonnelListDatumModel.fromJson(x)),
        ),
      );

  factory PersonnelListModel.fromEntity(PersonnelListEntity entity) =>
      PersonnelListModel(
        status: entity.status,
        data: entity.data
            .map((datum) => PersonnelListDatumModel.fromEntity(datum))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(
          data.map((x) => (x as PersonnelListDatumModel).toJson()),
        ),
      };

  PersonnelListEntity toEntity() => PersonnelListEntity(
        status: status,
        data: data,
      );
}

class PersonnelListDatumModel extends PersonnelListDatumEntity {
  PersonnelListDatumModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.suburb,
    required super.state,
    required super.postcode,
    required super.country,
    required super.contactNumber,
    required super.additionalNotes,
    required super.status,
    required super.roleIds,
    required super.createdBy,
    required super.updatedBy,
    required super.roleDetails,
    required super.apiaryRoleArray,
  });

  factory PersonnelListDatumModel.fromJson(Map<String, dynamic> json) =>
      PersonnelListDatumModel(
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
        updatedBy: json["updated_by"],
        roleDetails: List<RoleDetailModel>.from(
          (json["role_details"] ?? []).map((x) => RoleDetailModel.fromJson(x)),
        ),
        apiaryRoleArray: List<String>.from(
          (json["apiary_role_array"] ?? []).map((x) => x.toString()),
        ),
      );

  factory PersonnelListDatumModel.fromEntity(PersonnelListDatumEntity entity) =>
      PersonnelListDatumModel(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        address: entity.address,
        latitude: entity.latitude,
        longitude: entity.longitude,
        suburb: entity.suburb,
        state: entity.state,
        postcode: entity.postcode,
        country: entity.country,
        contactNumber: entity.contactNumber,
        additionalNotes: entity.additionalNotes,
        status: entity.status,
        roleIds: entity.roleIds,
        createdBy: entity.createdBy,
        updatedBy: entity.updatedBy,
        roleDetails: entity.roleDetails
            .map((role) => RoleDetailModel.fromEntity(role))
            .toList(),
        apiaryRoleArray: entity.apiaryRoleArray,
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
        "role_details": List<dynamic>.from(
          roleDetails.map((x) => (x as RoleDetailModel).toJson()),
        ),
        "apiary_role_array": List<dynamic>.from(apiaryRoleArray.map((x) => x)),
      };

  PersonnelListDatumEntity toEntity() => PersonnelListDatumEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        address: address,
        latitude: latitude,
        longitude: longitude,
        suburb: suburb,
        state: state,
        postcode: postcode,
        country: country,
        contactNumber: contactNumber,
        additionalNotes: additionalNotes,
        status: status,
        roleIds: roleIds,
        createdBy: createdBy,
        updatedBy: updatedBy,
        roleDetails: roleDetails,
        apiaryRoleArray: apiaryRoleArray,
      );
}

class RoleDetailModel extends RoleDetailEntity {
  RoleDetailModel({
    required super.id,
    required super.role,
  });

  factory RoleDetailModel.fromJson(Map<String, dynamic> json) =>
      RoleDetailModel(
        id: json["id"] ?? 0,
        role: json["role"] ?? '',
      );

  factory RoleDetailModel.fromEntity(RoleDetailEntity entity) =>
      RoleDetailModel(
        id: entity.id,
        role: entity.role,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      };

  RoleDetailEntity toEntity() => RoleDetailEntity(
        id: id,
        role: role,
      );
}
