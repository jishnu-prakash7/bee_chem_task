import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/fetch_role_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/use_cases/add_personnel_details_use_case.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/use_cases/fetch_role_list_use_case.dart';

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

      final result = await sl<FetchRoleListUseCase>().call();
      if (result.error != null) {
        emit(FetchRoleListFailedState(error: result.error!.message));
      } else {
        emit(FetchRoleListSuccessState(roleList: result.data!));
      }
    } catch (e) {
      emit(FetchRoleListFailedState(error: e.toString()));
    }
  }

  FutureOr<void> addPersonnelDataEvent(
      AddPersonnelDataEvent event, Emitter<PersonnelFormState> emit) async {
    try {
      emit(AddPersonnelDataLoadingState());
      final result = await sl<AddPersonnelDetailsUseCase>().call(
          params: AddPersonnelDetailsParams(
              firstName: event.firstName,
              address: event.address,
              latitude: event.latitude,
              longitude: event.longitude,
              suburb: event.suburb,
              state: event.state,
              postcode: event.postcode,
              country: event.country,
              contactNumber: event.contactNumber,
              roleIds: event.roleIds,
              status: event.status));

      if (result.error != null) {
        emit(AddPersonnelDataFailedState(error: result.error!.message));
      } else {
        emit(AddPersonnelDataSuccessState());
      }
    } catch (e) {
      emit(AddPersonnelDataFailedState(error: e.toString()));
    }
  }
}
