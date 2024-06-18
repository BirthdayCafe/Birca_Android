import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/visitor_cafe_home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class VisitorCafeHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<VisitorCafeHomeModel>? _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? get visitorCafeHomeModelList =>
      _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? _visitorCafeSearchModelList;

  List<VisitorCafeHomeModel>? get visitorCafeSearchModelList =>
      _visitorCafeSearchModelList;

  List<HomeArtists>? _homeArtistsList;

  List<HomeArtists>? get homeArtistsList => _homeArtistsList;

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //방문자 최애 아티스트 가져오기
  Future<void> getFavoriteArtist() async {

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
      Response response = await dio.get('${baseUrl}api/v1/artists/favorite',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _homeArtistsList = [];

      if (response.data != null) {
        _homeArtistsList?.add(HomeArtists.fromJson(response.data));
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

  //방문자 관심 아티스트 가져오기
  Future<void> getInterestArtist() async {

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
      Response response = await dio.get('${baseUrl}api/v1/artists/interest',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<HomeArtists> artists =
          jsonData.map((e) => HomeArtists.fromJson(e)).toList();

      homeArtistsList?.addAll(artists);

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

  //방문자 홈 카페 가져오기
  Future<void> getCafeHome(
      int cursor, int size, String name, String progressState) async {

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            'cursor': cursor,
            'size': size,
            'name': name,
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
  Future<void> getCafeSearch(String progressState, String name) async {

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            // 'cursor' : cursor,
            // 'size' : size,
            'name': name,
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


    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/like',
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


  //찜 취소
  Future<void> dislike(int birthdayCafeId) async {

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
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
      Response response = await dio.delete(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/like',
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

  void heart(int id,int index,BuildContext context) {
    if (visitorCafeHomeModelList![index].isLiked) {
      Provider.of<VisitorCafeHomeViewModel>(context,
          listen: false)
          .dislike(id);

      visitorCafeHomeModelList![index]
          .isLiked = false;
    } else {
      Provider.of<VisitorCafeHomeViewModel>(context,
          listen: false)
          .like(id);

      visitorCafeHomeModelList![index]
          .isLiked = true;
    }
    notifyListeners();
  }
}
