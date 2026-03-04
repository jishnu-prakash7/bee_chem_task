import 'package:flutter/foundation.dart';
import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/personnel_form/data/data_sources/remote/personnel_form_remote_data_source.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/add_personnel_details_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/fetch_role_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/repository/presonnel_form_repository.dart';

class PersonnelFormRepositoryImpl implements PersonnelFormRepository {
  final PersonnelFormRemoteDataSource _personnelFormRemoteDataSource;

  PersonnelFormRepositoryImpl(this._personnelFormRemoteDataSource);
  @override
  Future<DataState<List<FetchRoleListEntity>>> fetchRoleList() async {
    try {
      final res = await _personnelFormRemoteDataSource.fetchRoleList();
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
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
      required String status}) async {
    try {
      final res = await _personnelFormRemoteDataSource.addPersonnelData(
          firstName: firstName,
          address: address,
          latitude: latitude,
          longitude: longitude,
          suburb: suburb,
          state: state,
          postcode: postcode,
          country: country,
          contactNumber: contactNumber,
          roleIds: roleIds,
          status: status);

      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }
}
