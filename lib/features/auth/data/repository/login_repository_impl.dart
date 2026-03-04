import 'package:flutter/foundation.dart';
import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:g3_interactive_task/features/auth/domain/entities/login_entity.dart';
import 'package:g3_interactive_task/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  LoginRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<DataState<LoginEntity>> login(
      {required String email, required String password}) async {
    try {
      final res =
          await _authRemoteDataSource.login(email: email, password: password);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    } 
  }
}
