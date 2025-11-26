part of 'personnel_list_bloc.dart';

sealed class PersonnelListState {}

final class PersonnelListInitial extends PersonnelListState {}

final class FetchPersonnelListLoadingState extends PersonnelListState {}

final class FetchPersonnelListSuccessState extends PersonnelListState {}

final class FetchPersonnelListFailedState extends PersonnelListState {
  final String error;

  FetchPersonnelListFailedState({required this.error});
}
 