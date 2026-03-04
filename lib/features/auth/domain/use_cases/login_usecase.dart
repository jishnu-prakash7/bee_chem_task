import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/core/resources/use_case.dart';
import 'package:g3_interactive_task/features/auth/domain/entities/login_entity.dart';
import 'package:g3_interactive_task/features/auth/domain/repository/login_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<DataState<LoginEntity>, LoginParams> {
  final LoginRepository _loginRepository;
  LoginUseCase(this._loginRepository);
  @override
  Future<DataState<LoginEntity>> call({required LoginParams params}) async {
    return await _loginRepository.login(
        email: params.email, password: params.password);
  }
}
