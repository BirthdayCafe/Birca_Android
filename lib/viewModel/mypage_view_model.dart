import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/my_page_model.dart';

class MypageViewModel extends ChangeNotifier {
  MypageModel? _nickname;

  MypageModel? get nickname => _nickname;

  Dio dio = Dio();

  // FlutterSecureStorage storage = const FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];

  //닉네임 가져오기
  Future<void> getNickName() async {
    var token = '';
    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywiaWF0IjoxNzE1NjQ4MTk1LCJleHAiOjE3MjA4MzIxOTV9.yFY9Y18aPo4t1XA5ANsnfvqqnJsmq7kalNfj7FcGEi4";

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    //토큰 가져오기
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
      Response response = await dio.get('${baseUrl}api/v1/members/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.toString());

      _nickname = MypageModel.fromJson(response.data);

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
