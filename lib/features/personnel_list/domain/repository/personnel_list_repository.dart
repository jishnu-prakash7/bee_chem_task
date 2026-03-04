import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/entities/personnel_list_entity.dart';

abstract class PersonnelListRepository {
  Future<DataState<List<PersonnelListDatumEntity>>> fetchPersonnelList();
}