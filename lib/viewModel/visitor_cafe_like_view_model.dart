import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/visitor_cafe_like_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VisitorCafeLikeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<VisitorCafeLikeModel> _visitorCafeLikeModelList = [];

  List<VisitorCafeLikeModel> get visitorCafeLikeModelList =>
      _visitorCafeLikeModelList;

  VisitorCafeLikeViewModel() {
    getCafeLike();
  }

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //찜한 카페 가져오기
  Future<void> getCafeLike() async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }
    logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      _visitorCafeLikeModelList = [];
      List<dynamic> jsonData = response.data;
      List<VisitorCafeLikeModel> cafeLikeModels =
          jsonData.map((e) => VisitorCafeLikeModel.fromJson(e)).toList();
      _visitorCafeLikeModelList = cafeLikeModels;
      notifyListeners();
    } catch (e) {
      errorCheck(e);
    }
  }

  //찜한 카페 삭제
  Future<void> deleteCafeLike(int index) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }
    notifyListeners();

    logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.delete(
          '${baseUrl}api/v1/birthday-cafes/$index/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      notifyListeners();

      // 서버 응답 출력
      log('Response: ${response.data}');
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
