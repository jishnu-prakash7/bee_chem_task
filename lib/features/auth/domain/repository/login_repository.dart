import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/auth/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<DataState<LoginEntity>> login(
      {required String email, required String password});
}
