class PersonnelListEntity {
  bool status;
  List<PersonnelListDatumEntity> data;

  PersonnelListEntity({
    required this.status,
    required this.data,
  });
}

class PersonnelListDatumEntity {
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
  List<RoleDetailEntity> roleDetails;
  List<String> apiaryRoleArray;

  PersonnelListDatumEntity({
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
}

class RoleDetailEntity {
  int id;
  String role;

  RoleDetailEntity({
    required this.id,
    required this.role,
  });
}
