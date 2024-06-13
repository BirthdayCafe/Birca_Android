import 'dart:developer';
import 'package:birca/model/host_cafe_home_detail_model.dart';
import 'package:birca/model/host_cafe_home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HostHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<HostCafeHomeModel>? _hostCafeHomeModelList;

  List<HostCafeHomeModel>? get hostCafeHomeModelList => _hostCafeHomeModelList;

  HostCafeHomeDetailModel? _hostCafeHomeDetailModel;

  HostCafeHomeDetailModel? get hostCafeHomeDetailModel =>
      _hostCafeHomeDetailModel;

  //host 홈 카페 가져오기
  Future<void> getHostHome(int cursor, int size,String name) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/cafes',
          queryParameters: {
            // 'startDate' : startDate,
            //     'endDate':endDate,
            //     'liked':liked,
            'cursor': cursor,
            'size': size,
            'name' : name
            // 'artistId': artistId,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      _hostCafeHomeModelList = [];

      List<dynamic> jsonData = response.data;
      List<HostCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => HostCafeHomeModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _hostCafeHomeModelList?.addAll(cafeHomeModels);

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

  //카페 찜하기
  Future<void> postLike(int cafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post('${baseUrl}api/v1/cafes/$cafeId/like',
          queryParameters: {},
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
            throw Exception('Failed to postLike');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postLike.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postLike.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postLike.');
      }
    }
  }

  //카페 찜 취소
  Future<void> deleteLike(int cafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.delete(
          '${baseUrl}api/v1/cafes/$cafeId/like',
          queryParameters: {},
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
            throw Exception('Failed to postLike');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postLike.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postLike.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postLike.');
      }
    }
  }

  //카페 상세
  Future<void> getCafeDetail(int cafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/cafes/$cafeId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      _hostCafeHomeDetailModel =
          HostCafeHomeDetailModel.fromJson(response.data);

      // _hostCafeHomeDetailModelList 추가
      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getCafeDatail');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getCafeDatail.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getCafeDatail.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getCafeDatail.');
      }
    }
  }

  //카페 대관 신청
  Future<void> postRequest(HostRequestModel hostRequestModel) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzE2MjkwNDAxLCJleHAiOjE3MjE0NzQ0MDF9.8BaCgTdEVbBMf1tApT9le3_LtBU69QW6SESucv6jiM0';
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
          '${baseUrl}api/v1/birthday-cafes',
          data: hostRequestModel.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('postRequest Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postRequest');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postRequest.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postRequest.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postRequest.');
      }
    }
  }
}
