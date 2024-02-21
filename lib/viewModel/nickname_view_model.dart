import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NickNameViewModel extends ChangeNotifier{

  Dio dio = Dio();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];

  //닉네임 중복 확인
  bool isNickNameCheckOk = false;

  //닉네임
  // String? _nickName;
  // String? get nickName => _nickName;


  Future<void> nickNameCheck(String nickname) async {

    var token = '';
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    //토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }


    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));


    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/join/check-nickname',
          queryParameters: {'nickname' : nickname },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      log(response.toString());

      if(response.data['success']==false){
        isNickNameCheckOk = true;

        log('response.data = ${response.data['success']}');
        log('isNickNameCheckOk : $isNickNameCheckOk');
      } else {
        isNickNameCheckOk = false;
        log('response.data = ${response.data}');

        log('isNickNameCheckOk : $isNickNameCheckOk');

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
            log('Response data: ${e.response!.data}');
            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            log('Response data: ${e.response!.data}');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
      }
    }

}

Future<void> registerNickName(String nickname) async {
  var token = '';
  var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

  //토큰 가져오기
  if (kakaoLoginInfo != null) {
    Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    token = loginData['accessToken'].toString();
  }


  // LogInterceptor 추가
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));


  try {
    // API 엔드포인트 및 업로드
    Response response = await dio.post(
        '${baseUrl}api/v1/join/register-nickname',
        queryParameters: {'nickname' : nickname },
        options: Options(headers: {'Authorization': 'Bearer $token'})
    );

    log(response.toString());

    isNickNameCheckOk = true;

    notifyListeners();

  } catch (e) {
    if (e is DioException) {
      // Dio exception handling
      if (e.response != null) {
        // Server responded with an error
        if (e.response!.statusCode == 400) {
          // Handle HTTP 400 Bad Request error
          log('Bad Request - Server returned 400 status code');
          log('Response data: ${e.response!.data}');
          // Additional error handling logic here if needed
        } else {
          // Handle other HTTP status codes
          log('Server error - Status code: ${e.response!.statusCode}');
          log('Response data: ${e.response!.data}');
          // Additional error handling logic here if needed
        }
      } else {
        // No response from the server (network error, timeout, etc.)
        log('Dio error: ${e.message}');
      }
    } else {
      // Handle other exceptions if necessary
      log('Error: $e');
    }
  }
}
}