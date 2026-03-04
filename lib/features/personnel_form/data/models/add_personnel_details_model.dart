import 'package:g3_interactive_task/features/personnel_form/domain/entities/add_personnel_details_entity.dart';

class AddPersonnelDetailsModel extends AddPersonnelDetailsEntity {
  AddPersonnelDetailsModel({
    required super.status,
    required super.id,
    required super.message,
  });

  factory AddPersonnelDetailsModel.fromJson(Map<String, dynamic> json) =>
      AddPersonnelDetailsModel(
        status: json["status"] ?? false,
        id: json["id"] ?? 0,
        message: json["message"] ?? "",
      );
  factory AddPersonnelDetailsModel.fromEntiry(
          AddPersonnelDetailsEntity entity) =>
      AddPersonnelDetailsModel(
        status: entity.status,
        id: entity.id,
        message: entity.message,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "message": message,
      };
  AddPersonnelDetailsEntity toEntity() => AddPersonnelDetailsEntity(
        id: id,
        status: status,
        message: message,
      );
}
