import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g3_interactive_task/core/constants/api_end_points.dart';
import 'package:g3_interactive_task/core/constants/custom_exceptions.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';
import 'package:g3_interactive_task/features/personnel_form/data/models/add_personnel_details_model.dart';
import 'package:g3_interactive_task/features/personnel_form/data/models/fetch_role_list_model.dart';

class PersonnelFormRemoteDataSource {
  final Dio dio;

  PersonnelFormRemoteDataSource(this.dio);

  Future<List<FetchRoleListModel>> fetchRoleList() async {
    try {
      final url =
          ApiEndPoints.baseUrl + ApiEndPoints.roles + ApiEndPoints.roleList;
      final token = await SharedPrefsData.getToken();

      log("fetch role list url $url");
      log("fetch role token $token");

      final response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      log('fetch role list response: $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List)
            .map((json) => FetchRoleListModel.fromJson(json))
            .toList();
      } else {
        throw CustomException("Something went wrong!");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.badCertificate ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout) {
        throw CustomException("Connection Error!");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomException("Receive timeout!");
      } else {
        if (e.response == null || e.response!.statusCode == null) {
          throw CustomException();
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! < 500) {
          if (e.response!.statusCode == null) {
            throw CustomException("oops An Unexpected Error Occured");
          } else {
            throw CustomException(e.response!.data["message"] ??
                "oops An Unexpected Error Occured");
          }
        } else {
          throw CustomException("oops An Unexpected Error Occured");
        }
      }
    }
  }

  Future<AddPersonnelDetailsModel> addPersonnelData({
    required String firstName,
    required String address,
    required String latitude,
    required String longitude,
    required String suburb,
    required String state,
    required String postcode,
    required String country,
    required String contactNumber,
    required String roleIds,
    required String status,
  }) async {
    try {
      final url = ApiEndPoints.baseUrl +
          ApiEndPoints.personnelDetails +
          ApiEndPoints.personnelDetailsAdd;
      final token = await SharedPrefsData.getToken();

      log("add personnel data url $url");
      log("add personnel data token $token");

      FormData formData = FormData.fromMap({
        "first_name": firstName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "suburb": suburb,
        "state": state,
        "postcode": postcode,
        "country": country,
        "contact_number": contactNumber,
        "role_ids": roleIds,
        "status": status,
      });

      log('add personnel data request body: ${formData.toString()}');
      final response = await dio.post(url,
          data: formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      log('add personnel data response: $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddPersonnelDetailsModel.fromJson(response.data);
      } else {
        throw CustomException("Something went wrong!");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.badCertificate ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout) {
        throw CustomException("Connection Error!");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomException("Receive timeout!");
      } else {
        if (e.response == null || e.response!.statusCode == null) {
          throw CustomException();
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! < 500) {
          if (e.response!.statusCode == null) {
            throw CustomException("oops An Unexpected Error Occured");
          } else {
            throw CustomException(e.response!.data["message"] ??
                "oops An Unexpected Error Occured");
          }
        } else {
          throw CustomException("oops An Unexpected Error Occured");
        }
      }
    }
  }
}
