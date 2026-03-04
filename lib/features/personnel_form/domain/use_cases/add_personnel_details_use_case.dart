import 'package:g3_interactive_task/core/resources/data_state.dart';
import 'package:g3_interactive_task/core/resources/use_case.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/entities/add_personnel_details_entity.dart';
import 'package:g3_interactive_task/features/personnel_form/domain/repository/presonnel_form_repository.dart';

class AddPersonnelDetailsParams {
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

  AddPersonnelDetailsParams(
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

class AddPersonnelDetailsUseCase extends UseCase<
    DataState<AddPersonnelDetailsEntity>, AddPersonnelDetailsParams> {
  final PersonnelFormRepository _personnelFormRepository;

  AddPersonnelDetailsUseCase(this._personnelFormRepository);
  @override
  Future<DataState<AddPersonnelDetailsEntity>> call(
      {required AddPersonnelDetailsParams params}) async {
    return await _personnelFormRepository.addPersonnelData(
        firstName: params.firstName,
        address: params.address,
        latitude: params.latitude,
        longitude: params.longitude,
        suburb: params.suburb,
        state: params.state,
        postcode: params.postcode,
        country: params.country,
        contactNumber: params.contactNumber,
        roleIds: params.roleIds,
        status: params.status);
  }
}
