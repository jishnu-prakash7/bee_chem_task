import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/api_functions.dart';
import 'package:g3_interactive_task/features/personnel_form/data/models/fetch_role_list_model.dart';

part 'personnel_form_event.dart';
part 'personnel_form_state.dart';

class PersonnelFormBloc extends Bloc<PersonnelFormEvent, PersonnelFormState> {
  PersonnelFormBloc() : super(PersonnelFormInitial()) {
    on<PersonnelFormEvent>((event, emit) {});
    on<FetchRoleListEvent>(fetchRoleEvent);
    on<AddPersonnelDataEvent>(addPersonnelDataEvent);
  }

  FutureOr<void> fetchRoleEvent(
      FetchRoleListEvent event, Emitter<PersonnelFormState> emit) async {
    try {
      emit(FetchRoleListLoadingState());
      Response response = await ApiFunctions().fetchRoleList();
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<FetchRoleListModel> roleList = (response.data as List)
            .map((json) => FetchRoleListModel.fromJson(json))
            .toList();
        emit(FetchRoleListSuccessState(roleList: roleList));
      }
    } catch (e) {
      emit(FetchRoleListFailedState(error: e.toString()));
    }
  }

  FutureOr<void> addPersonnelDataEvent(
      AddPersonnelDataEvent event, Emitter<PersonnelFormState> emit) async {
    try {
      emit(AddPersonnelDataLoadingState());
      Response response = await ApiFunctions().addPersonnelData(
          firstName:event. firstName,
          address: event.address, 
          latitude:event. latitude,
          longitude:event. longitude,
          suburb:event. suburb,
          state: event.state,
          postcode:event. postcode,
          country:event. country,
          contactNumber:event. contactNumber,
          roleIds:event. roleIds,
          status:event. status);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddPersonnelDataSuccessState());
      }
    } catch (e) {
      emit(AddPersonnelDataFailedState(error: e.toString()));
    }
  }
}
