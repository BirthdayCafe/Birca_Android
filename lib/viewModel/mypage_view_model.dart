import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/my_page_model.dart';

class MypageViewModel extends ChangeNotifier {
  MypageModel? _nickname;

  MypageModel? get nickname => _nickname;

  Dio dio = Dio();

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //닉네임 가져오기
  Future<void> getNickName() async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }
    logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/members/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.toString());

      _nickname = MypageModel.fromJson(response.data);

      notifyListeners();
    } catch (e) {
      errorCheck(e);
    }
  }

  //post role change
  Future<void> postRoleChange(String role) async {
    const storage = FlutterSecureStorage();

    Dio dio = Dio();
    Response response;
    var baseUrl = dotenv.env['BASE_URL'];

    var token = '';
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    logInterceptor();

    //토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    try {
      response = await dio.post('${baseUrl}api/v1/members/role-change',
          data: {'role': role},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      // log('kakaoLoginInfo : $kakaoLoginInfo');

      log('$role 변경 ');

      log(response.data.toString());
    } catch (e) {
      errorCheck(e);
    }
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
