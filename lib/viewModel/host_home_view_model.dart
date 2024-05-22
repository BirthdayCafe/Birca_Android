import 'dart:developer';
import 'package:birca/model/host_cafe_home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HostHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<HostCafeHomeModel>? _hostCafeHomeModelList;

  List<HostCafeHomeModel>? get hostCafeHomeModelList =>
      _hostCafeHomeModelList;


  //host 홈 카페 가져오기
  Future<void> getHostHome(int cursor, int size) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

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
      Response response = await dio.get('${baseUrl}api/v1/cafes',
          queryParameters: {
        // 'startDate' : startDate,
        //     'endDate':endDate,
        //     'liked':liked,
            'cursor': cursor,
            'size' : size,
            // 'artistId': artistId,
            // 'cafeId': cafeId,
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

}
