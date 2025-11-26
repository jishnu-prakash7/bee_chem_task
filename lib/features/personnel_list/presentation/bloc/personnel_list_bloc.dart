import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/api_functions.dart';
import 'package:g3_interactive_task/features/personnel_list/data/models/personnel_list_model.dart';

part 'personnel_list_event.dart';
part 'personnel_list_state.dart';

class PersonnelListBloc extends Bloc<PersonnelListEvent, PersonnelListState> {
  PersonnelListModel personnelListData = PersonnelListModel.fromJson({});
  List<PersonnelListDatum> filteredPersonnel = [];
  PersonnelListBloc() : super(PersonnelListInitial()) {
    on<PersonnelListEvent>((event, emit) {});
    on<FetchPersonnelListEvent>(fetchPersonnelListEvent);
  }

  FutureOr<void> fetchPersonnelListEvent(
      FetchPersonnelListEvent event, Emitter<PersonnelListState> emit) async {
    try {
      emit(FetchPersonnelListLoadingState());
      Response response = await ApiFunctions().fetchPersonnelList();
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          personnelListData = PersonnelListModel.fromJson(response.data);
          filteredPersonnel = personnelListData.data;
          emit(FetchPersonnelListSuccessState());
        } else {
          emit(FetchPersonnelListFailedState(error: response.data["message"]));
        }
      }
    } catch (e) {
      emit(FetchPersonnelListFailedState(error: e.toString()));
    }
  }
}
