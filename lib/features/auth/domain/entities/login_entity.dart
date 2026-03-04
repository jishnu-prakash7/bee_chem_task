class LoginEntity {
  bool status;
  String accessToken;
  String refreshToken;
  double expiresInSec;
  UserEntity user;

  LoginEntity({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresInSec,
    required this.user,
  });
}

class UserEntity {
  int id;
  String roleId;
  String role;
  String firstName;
  String lastName;
  String profileImageUrl;

  UserEntity({
    required this.id,
    required this.roleId,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
  });
}
