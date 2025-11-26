part of 'auth_bloc.dart';


abstract class AuthEvent {}

final class LoginEvent extends AuthEvent{
  final String email;
  final String password;
  final bool isRememberUser;

  LoginEvent({required this.email, required this.password,required this.isRememberUser});
}
