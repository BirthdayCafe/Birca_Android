import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import '../model/owner_my_cafe_detail_model.dart';

class OwnerMyCafeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  OwnerMyCafeDetailModel? _ownerMyCafeDetailModel;

  OwnerMyCafeDetailModel? get ownerMyCafeDetailModel => _ownerMyCafeDetailModel;

  //사장님 나의 카페 가져오기
  Future<void> getMyCafe() async {
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
      Response response = await dio.get('${baseUrl}api/v1/cafes/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getMyCafe Response: ${response.data}');

      _ownerMyCafeDetailModel = OwnerMyCafeDetailModel.fromJson(response.data);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getMyCafe');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getMyCafe.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getMyCafe.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getMyCafe.');
      }
    }
  }

  //사장님 카페 기본 정보 수정
  Future<void> patchMyCafe(
      String cafeName, String cafeAddress, String twitter, String hours) async {
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
      Response response = await dio.patch('${baseUrl}api/v1/cafes',
          data: {
            'cafeName': cafeName,
            'cafeAddress': cafeAddress,
            'twitterAccount': twitter,
            'businessHours': hours,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('patchMyCafe Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to patchMyCafe');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to patchMyCafe.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to patchMyCafe.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to patchMyCafe.');
      }
    }
  }

  //사장님 휴무일 편집
  Future<void> postDayOff(int cafeId, Map<String, dynamic> data) async {
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
          '${baseUrl}api/v1/cafes/$cafeId/day-off',
          data: jsonEncode(data),
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              contentType: Headers.jsonContentType));

      // 서버 응답 출력
      log('postDayOff Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postDayOff');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postDayOff.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postDayOff.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postDayOff.');
      }
    }
  }

  //사장님 카페 사진 편집
  Future<void> postImage(int cafeId, List<PickedFile> pickedFiles) async {
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

    // PickedFile 리스트를 File 리스트로 변환
    List<File> cafeImages =
        pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();

    // 업로드할 파일을 FormData로 변환
    FormData formData = FormData();
    for (int i = 0; i < cafeImages.length; i++) {
      formData.files.add(MapEntry(
          'cafeImages', await MultipartFile.fromFile(cafeImages[i].path)));
    }
    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    log(formData.toString());

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/cafes/$cafeId/images',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('postImage Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postImage');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postImage.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postImage.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postImage.');
      }
    }
  }
}
