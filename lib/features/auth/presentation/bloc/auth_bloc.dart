import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/api_functions.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginEvent>(loginEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoadingState());
      Response response = await ApiFunctions()
          .login(email: event.email, password: event.password);
      log('login response is $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          await SharedPrefsData.saveUserToken(
              token: response.data["access_token"]);
          if (event.isRememberUser) {
            await SharedPrefsData.rememberUser(
                email: event.email, token: response.data["access_token"]);
          }
          emit(LoginSuccessState());
        } else {
          emit(LoginFailedState(error: response.data["message"]));
        }
      }
    } catch (e) {
      emit(LoginFailedState(error: e.toString()));
    }
  }
}
