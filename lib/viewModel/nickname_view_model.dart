import 'dart:convert';
import 'dart:developer';
import 'package:birca/designSystem/palette.dart';
import 'package:birca/viewModel/mypage_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class NickNameViewModel extends ChangeNotifier {
  Dio dio = Dio();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];

  //닉네임 중복 확인
  bool isNickNameCheckOk = false;

  Color btnColor = Palette.gray04;

  //닉네임 중복 확인 api
  Future<void> nickNameCheck(String nickname) async {
    var token = '';
    var loginToken = await storage.read(key: 'loginToken');

    //토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/join/check-nickname',
          queryParameters: {'nickname': nickname},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.toString());

      if (response.data['success'] == false) {
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
      errorCheck(e);
    }
  }

//닉네임 등록 api
  Future<void> registerNickName(String nickname) async {
    var token = '';
    var loginToken = await storage.read(key: 'loginToken');

    //토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/join/register-nickname',
          data: {'nickname': nickname},
          options: Options(headers: {'Authorization': 'Bearer $token'}));



      log(response.toString());

      notifyListeners();
    } catch (e) {
      errorCheck(e);
    }
  }

  void isBtnOk(bool isBtnOk, BuildContext context) {
    log('isBtnOk $isBtnOk');
    if (isBtnOk == true) {
      btnColor = Palette.primary;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('사용 가능한 닉네임입니다.')));
    }


    notifyListeners();
  }

  //통신 error 검사
  void errorCheck(e) {
    if (e is DioException) {
      // Dio exception handling
      if (e.response != null) {
        // Server responded with an error
        if (e.response!.statusCode == 400) {
          // Handle HTTP 400 Bad Request error
          log('Bad Request - Server returned 400 status code');
          throw Exception('Failed 1');

          // Additional error handling logic here if needed
        } else {
          // Handle other HTTP status codes
          log('Server error - Status code: ${e.response!.statusCode}');
          throw Exception('Failed 2');
          // Additional error handling logic here if needed
        }
      } else {
        // No response from the server (network error, timeout, etc.)
        log('Dio error: ${e.message}');
        throw Exception('Failed 3');
      }
    } else {
      // Handle other exceptions if necessary
      log('Error: $e');
      throw Exception('Failed 4');
    }
  }

  //LogInterceptor 추가
  void logInterceptor() {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}
