import 'dart:developer';
import 'package:birca/model/visitor_cafe_home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VisitorCafeHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<VisitorCafeHomeModel>? _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? get visitorCafeHomeModelList =>
      _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? _visitorCafeSearchModelList;

  List<VisitorCafeHomeModel>? get visitorCafeSearchModelList =>
      _visitorCafeSearchModelList;

  //방문자 홈 카페 가져오기
  Future<void> getCafeHome(String progressState) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token ='eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            // 'cursor' : cursor,
            // 'size' : size,
            // 'name' : name,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _visitorCafeHomeModelList = [];

      List<dynamic> jsonData = response.data;
      List<VisitorCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => VisitorCafeHomeModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _visitorCafeHomeModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getCafeHome');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getCafeHome.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getCafeHome.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getCafeHome.');
      }
    }
  }

  //방문자 검색
  Future<void> getCafeSearch(String progressState,String name) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token ='eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            // 'cursor' : cursor,
            // 'size' : size,
            'name' : name,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _visitorCafeSearchModelList = [];

      List<dynamic> jsonData = response.data;
      List<VisitorCafeHomeModel> cafeHomeModels =
      jsonData.map((e) => VisitorCafeHomeModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _visitorCafeSearchModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getCafeSearch');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getCafeSearch.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getCafeSearch.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getCafeSearch.');
      }
    }
  }
  //찜하기
  Future<void> like(int birthdayCafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token ='eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post('${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/like',

          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');


      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to like');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to like.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to like.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to like.');
      }
    }
  }
}
