import 'package:flutter/foundation.dart';
import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/features/personnel_list/data/data_sources/remote/personnel_list_remote_data_source.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/entities/personnel_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/repository/personnel_list_repository.dart';

class PersonnelListRepositoryImpl implements PersonnelListRepository {
  final PersonnelListRemoteDataSource _personnelListRemoteDataSource;

  PersonnelListRepositoryImpl(this._personnelListRemoteDataSource);

  @override 
  Future<DataState<List<PersonnelListDatumEntity>>> fetchPersonnelList() async {
    try {
      final res = await _personnelListRemoteDataSource.fetchPersonnelList();
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }
}
