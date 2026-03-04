part of 'personnel_form_bloc.dart';

sealed class PersonnelFormState {}

final class PersonnelFormInitial extends PersonnelFormState {}

final class FetchRoleListLoadingState extends PersonnelFormState {}

final class FetchRoleListSuccessState extends PersonnelFormState {
  final List<FetchRoleListEntity> roleList;

  FetchRoleListSuccessState({required this.roleList});
}

final class FetchRoleListFailedState extends PersonnelFormState {
  final String error;

  FetchRoleListFailedState({required this.error});
}

final class AddPersonnelDataLoadingState extends PersonnelFormState {}

final class AddPersonnelDataSuccessState extends PersonnelFormState {}

final class AddPersonnelDataFailedState extends PersonnelFormState {
  final String error;

  AddPersonnelDataFailedState({required this.error});
}
