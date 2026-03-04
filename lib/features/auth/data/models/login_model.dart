import 'package:g3_interactive_task/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.status,
    required super.accessToken,
    required super.refreshToken,
    required super.expiresInSec,
    required super.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] ?? false,
        accessToken: json["access_token"] ?? '',
        refreshToken: json["refresh_token"] ?? '',
        expiresInSec: json["expires_in_sec"]?.toDouble() ?? 0.0,
        user: UserModel.fromJson(json["user"] ?? {}),
      );

  factory LoginModel.fromEntity(LoginEntity entity) => LoginModel(
        status: entity.status,
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
        expiresInSec: entity.expiresInSec,
        user: UserModel.fromEntity(entity.user),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in_sec": expiresInSec,
        "user": (user as UserModel).toJson(),
      };

  LoginEntity toEntity() => LoginEntity(
        status: status,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresInSec: expiresInSec,
        user: user,
      );
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.roleId,
    required super.role,
    required super.firstName,
    required super.lastName,
    required super.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        roleId: json["role_id"] ?? '',
        role: json["role"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        profileImageUrl: json["profile_image_url"] ?? '',
      );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        roleId: entity.roleId,
        role: entity.role,
        firstName: entity.firstName,
        lastName: entity.lastName,
        profileImageUrl: entity.profileImageUrl,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "role": role,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image_url": profileImageUrl,
      };

  UserEntity toEntity() => UserEntity(
        id: id,
        roleId: roleId,
        role: role,
        firstName: firstName,
        lastName: lastName,
        profileImageUrl: profileImageUrl,
      );
}
