import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/add_personnel_details_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/fetch_role_list_entity.dart';

abstract class PersonnelFormRepository {
  Future<DataState<List<FetchRoleListEntity>>> fetchRoleList();
  Future<DataState<AddPersonnelDetailsEntity>> addPersonnelData(
      {required String firstName,
      required String address,
      required String latitude,
      required String longitude,
      required String suburb,
      required String state,
      required String postcode,
      required String country,
      required String contactNumber,
      required String roleIds,
      required String status});
}
