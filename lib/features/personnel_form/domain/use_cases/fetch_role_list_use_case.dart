import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/core/resources/use_case.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/fetch_role_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/repository/presonnel_form_repository.dart';

class FetchRoleListUseCase
    extends UseCase<DataState<List<FetchRoleListEntity>>, void> {
  final PersonnelFormRepository _personnelFormRepository;

  FetchRoleListUseCase(this._personnelFormRepository);
  @override
  Future<DataState<List<FetchRoleListEntity>>> call(
      { void params}) async {
    return await _personnelFormRepository.fetchRoleList();
  }
}
 