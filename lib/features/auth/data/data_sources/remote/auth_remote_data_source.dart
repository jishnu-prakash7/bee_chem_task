import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:g3_interactive_task/core/constants/api_end_points.dart';
import 'package:g3_interactive_task/core/constants/custom_exceptions.dart';
import 'package:g3_interactive_task/features/auth/data/models/login_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = ApiEndPoints.baseUrl + ApiEndPoints.login;

      log("login url $url");

      FormData formData = FormData.fromMap({
        "email": email,
        "password": password,
        "mob_user": 1,
      });

      log('login request body: $formData');
      final response = await dio.post(url, data: formData);
      log('login response: $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          return LoginModel.fromJson(response.data);
        } else {
          throw CustomException("Something went wrong!");
        }
      } else {
        throw CustomException("Something went wrong!");
      }
    } on DioException catch (e) {
      log(("type ${e.type}"));
      log(("reponse ${e.response!}"));
      log(("message ${e.response!.statusMessage}"));
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw CustomException("Connection Error!");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomException("Receive timeout!");
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw CustomException("Send timeout!");
      } else if (e.type == DioExceptionType.badCertificate) {
        throw CustomException("Bad certificate error!");
      } else if (e.type == DioExceptionType.badResponse) {
        throw CustomException("${e.response!.data['message']}!");
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
