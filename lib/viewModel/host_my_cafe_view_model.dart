import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/host_my_cafe_model.dart';

class HostMyCafeViewModel extends ChangeNotifier{
  Dio dio = Dio();

  List<HostMyCafeModel>? _hostMyCafeModelList;

  List<HostMyCafeModel>? get hostMyCafeModelList =>
      _hostMyCafeModelList;

  HostMyCafeViewModel(){
    _hostMyCafeModelList = [];
  }

  // progressState를 한글로 변환하는 매핑
  Map<String, String> progressStateMapping = {
    'RENTAL_PENDING': '대기중',
    'FINISHED': '완료',
    'IN_PROGRESS': '진행 중',
    'RENTAL_APPROVED': '승인',
    'RENTAL_CANCELED': '취소'
  };

  // progressState를 한글로 변환하는 함수
  String getProgressStateInKorean(String progressState) {
    return progressStateMapping[progressState] ?? '알 수 없음';
  }

  //주최자 카페 홈 가져오기
  Future<void> getHostMyCafe() async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    //
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token ='eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes/me',

          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _hostMyCafeModelList = [];
      List<dynamic> jsonData = response.data;
      List<HostMyCafeModel> cafeHomeModels =
      jsonData.map((e) => HostMyCafeModel.fromJson(e)).toList();


      // _hostCafeHomeModelList 추가
      _hostMyCafeModelList?.addAll(cafeHomeModels);

      log("model  $_hostMyCafeModelList");
      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getHostMyCafe');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getHostMyCafe.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getHostMyCafe.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getHostMyCafe.');
      }
    }
  }

}