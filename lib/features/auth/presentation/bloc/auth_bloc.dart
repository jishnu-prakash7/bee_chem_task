import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/features/auth/domain/use_cases/login_usecase.dart';

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

      final result = await sl<LoginUseCase>().call(
          params: LoginParams(email: event.email, password: event.password));

      if (result.error != null) {
        emit(LoginFailedState(error: result.error!.message));
      } else {
        await SharedPrefsData.saveUserToken(token: result.data!.accessToken);
        if (event.isRememberUser) {
          await SharedPrefsData.rememberUser(
              email: event.email, token: result.data!.accessToken);
        } else {
          await SharedPrefsData.clearEmail();
        }
        emit(LoginSuccessState());
      }
    } catch (e) {
      emit(LoginFailedState(error: e.toString()));
    }
  }
}
