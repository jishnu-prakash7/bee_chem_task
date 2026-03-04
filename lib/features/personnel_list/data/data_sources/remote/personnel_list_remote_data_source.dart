import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g3_interactive_task/core/constants/api_end_points.dart';
import 'package:g3_interactive_task/core/constants/custom_exceptions.dart';
import 'package:g3_interactive_task/core/constants/shared_preferences.dart';
import 'package:g3_interactive_task/features/personnel_list/data/models/personnel_list_model.dart';

class PersonnelListRemoteDataSource {
  final Dio dio;

  PersonnelListRemoteDataSource(this.dio);
  //fetch personnel list
  Future<List<PersonnelListDatumModel>> fetchPersonnelList() async {
    try {
      final url = ApiEndPoints.baseUrl + ApiEndPoints.personnelDetails;
      final token = await SharedPrefsData.getToken();

      log("fetch personnel list url $url");
      log("fetch personnel token $token");

      final response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      log('fetch personnel list response: $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          return (response.data['data'] as List)
              .map((json) => PersonnelListDatumModel.fromJson(json))
              .toList();
        } else {
          throw CustomException("Something went wrong");
        }
      } else {
        throw CustomException("Something went wrong");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw CustomException("Connection Error!");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomException("Receive timeout!");
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw CustomException("Send timeout!");
      } else if (e.type == DioExceptionType.badCertificate) {
        throw CustomException("${e.message}!");
      } else if (e.type == DioExceptionType.badResponse) {
        throw CustomException("${e.message}!");
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
