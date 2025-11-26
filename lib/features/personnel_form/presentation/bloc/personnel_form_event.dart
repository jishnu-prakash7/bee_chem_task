part of 'personnel_form_bloc.dart';

sealed class PersonnelFormEvent {}

final class FetchRoleListEvent extends PersonnelFormEvent {}

final class AddPersonnelDataEvent extends PersonnelFormEvent {
  final String firstName;
  final String address;
  final String latitude;
  final String longitude;
  final String suburb;
  final String state;
  final String postcode;
  final String country;
  final String contactNumber;
  final String roleIds;
  final String status;

  AddPersonnelDataEvent(
      {required this.firstName,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.suburb,
      required this.state,
      required this.postcode,
      required this.country,
      required this.contactNumber,
      required this.roleIds,
      required this.status});
}
