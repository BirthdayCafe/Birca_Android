import 'dart:developer';
import 'package:birca/model/visitor_cafe_like_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VisitorCafeLikeViewModel extends ChangeNotifier{
  Dio dio = Dio();

  List<VisitorCafeLikeModel> _visitorCafeLikeModelList = [];
  List<VisitorCafeLikeModel> get visitorCafeLikeModelList=>_visitorCafeLikeModelList;

  VisitorCafeLikeViewModel(){
    getCafeLike();
  }

  //찜한 카페 가져오기
  Future<void> getCafeLike() async {

    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];

    //임시 토큰
    var token = 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // //토큰 가져오기
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
          '${baseUrl}api/v1/birthday-cafes/like',
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      // 서버 응답 출력
      log('Response: ${response.data}');


      // List<dynamic> data = json.decode(response.data);
      // _visitorCafeLikeModelList?.addAll(List<VisitorCafeLikeModel>.from(jsonDecode(response.data).map((e) => VisitorCafeLikeModel.fromJson(e))));

      // _visitorCafeLikeModelList = response.data;
      List<dynamic> jsonData = response.data;
      List<VisitorCafeLikeModel> cafeLikeModels = jsonData.map((e) => VisitorCafeLikeModel.fromJson(e)).toList();

      // _visitorCafeLikeModelList에 추가
      _visitorCafeLikeModelList = cafeLikeModels;
      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getCafeLike');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getCafeLike.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getCafeLike.');

        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getCafeLike.');

      }
    }
  }

  //찜한 카페 삭제
  Future<void> deleteCafeLike(int index) async {
    _visitorCafeLikeModelList.removeAt(index);
    notifyListeners();

    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];

    //임시 토큰
    var token = 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // //토큰 가져오기
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
      Response response = await dio.delete(
          '${baseUrl}api/v1/birthday-cafes/${_visitorCafeLikeModelList[index].birthdayCafeId}/like',
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      // 서버 응답 출력
      log('Response: ${response.data}');

    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getCafeLike');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getCafeLike.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getCafeLike.');

        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getCafeLike.');

      }
    }

  }
}