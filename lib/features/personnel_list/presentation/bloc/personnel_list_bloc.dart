import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/entities/personnel_list_entity.dart';
import 'package:g3_interactive_task/features/personnel_list/domain/use_cases/fetch_personnel_list_use_case.dart';

part 'personnel_list_event.dart';
part 'personnel_list_state.dart';

class PersonnelListBloc extends Bloc<PersonnelListEvent, PersonnelListState> {


  List<PersonnelListDatumEntity> personnelList = [];
  List<PersonnelListDatumEntity> filteredPersonnel = [];
  PersonnelListBloc()
      : super(PersonnelListInitial()) {
    on<PersonnelListEvent>((event, emit) {});
    on<FetchPersonnelListEvent>(fetchPersonnelListEvent);
  }

  FutureOr<void> fetchPersonnelListEvent(
      FetchPersonnelListEvent event, Emitter<PersonnelListState> emit) async {
    try {
      emit(FetchPersonnelListLoadingState());
      final result = await sl<FetchPersonnelListUseCase>().call();
      if (result.error != null) {
        emit(FetchPersonnelListFailedState(error: result.error!.message));
      } else {
        personnelList = result.data!;
        filteredPersonnel = personnelList;
        emit(FetchPersonnelListSuccessState());
      }
    } catch (e) {
      emit(FetchPersonnelListFailedState(error: e.toString()));
    }
  }
}
