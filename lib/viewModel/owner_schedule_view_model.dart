import 'dart:developer';
import 'package:birca/model/owner_schedule_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OwnerScheduleViewModel extends ChangeNotifier {
  Dio dio = Dio();

  OwnerScheduleModel? _ownerScheduleModel;

  OwnerScheduleModel? get ownerScheduleModel => _ownerScheduleModel;

  //사장님 스케줄 추가
  Future<void> postSchedule(OwnerScheduleAddModel ownerScheduleAddModel) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywiaWF0IjoxNzE1NjQ4MTk1LCJleHAiOjE3MjA4MzIxOTV9.yFY9Y18aPo4t1XA5ANsnfvqqnJsmq7kalNfj7FcGEi4";
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/owners/birthday-cafes/schedules',
          data: ownerScheduleAddModel.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('postSchedule Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postSchedule');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postSchedule.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postSchedule.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postSchedule.');
      }
    }
  }

  //사장님 스케줄 가져오기
  Future<void> getSchedule(String dateTime) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywiaWF0IjoxNzE1NjQ4MTk1LCJleHAiOjE3MjA4MzIxOTV9.yFY9Y18aPo4t1XA5ANsnfvqqnJsmq7kalNfj7FcGEi4";
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/owners/birthday-cafes/schedules',
          queryParameters: {'date': dateTime},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _ownerScheduleModel = null;

      // 서버 응답 출력
      log('getSchedule Response: ${response.data}');

      if (response.data != null && response.data.isNotEmpty) {
        _ownerScheduleModel = OwnerScheduleModel.fromJson(response.data);
      }

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getSchedule');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getSchedule.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getSchedule.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getSchedule.');
      }
    }
  }
}
