import 'package:g3_interactive_task/features/personnel_form/domain/entities/fetch_role_list_entity.dart';

class FetchRoleListModel extends FetchRoleListEntity {
  FetchRoleListModel({
    required super.id,
    required super.role,
  });

  factory FetchRoleListModel.fromJson(Map<String, dynamic> json) =>
      FetchRoleListModel(
        id: json["id"] ?? 0,
        role: json["role"] ?? '',
      );
  factory FetchRoleListModel.fromEntity(FetchRoleListEntity entity) =>
      FetchRoleListModel(
        id: entity.id,
        role: entity.role,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      }; 
  FetchRoleListEntity toEntity() => FetchRoleListEntity(
        id: id,
        role: role,
      );
}
