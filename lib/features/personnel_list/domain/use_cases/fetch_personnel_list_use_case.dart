import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/core/resources/use_case.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/entities/personnel_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/repository/personnel_list_repository.dart';

class FetchPersonnelListUseCase
    implements UseCase<DataState<List<PersonnelListDatumEntity>>, void> {
  final PersonnelListRepository _personnelListRepository;

  FetchPersonnelListUseCase(this._personnelListRepository);

  @override
  Future<DataState<List<PersonnelListDatumEntity>>> call({void params}) async {
    return await _personnelListRepository.fetchPersonnelList();
  }
}
