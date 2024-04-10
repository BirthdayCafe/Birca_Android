import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/artist_search_model.dart';

class ArtistSearchViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<ArtistSearchModel>? _artistSearchModelList;
  List<ArtistSearchModel>? get artistSearchModelList => _artistSearchModelList;

  // ArtistSearchViewModel(){
  //   _artistSearchModelList =[];
  //   getArtistSearch('IN_PROGRESS',1,2);
  // }



  //아티스트 검색 결과
  Future<void> getArtistSearch(String artistName) async {

    const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    //임시 토큰
    // var token = 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAwLCJpYXQiOjE3MTE2MTM3NDcsImV4cCI6MTcxNDIwNTc0N30.dvpR8o4HRtag_drGpHxXO6GHiejOCxa2v7cygqkQibQ';

    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    //토큰 가져오기
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
      Response response = await dio.get(
          '${baseUrl}api/v1/artists/search',
          queryParameters: {
            'name': artistName,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      // 서버 응답 출력
      log('Response: ${response.data}');


      List<dynamic> jsonData = response.data;
      List<ArtistSearchModel> artistSearcheModels = jsonData.map((e) => ArtistSearchModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _artistSearchModelList?.addAll(artistSearcheModels);

      notifyListeners();

    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getArtistSearch');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getArtistSearch.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getArtistSearch.');

        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getArtistSearch.');

      }
    }

  }
}
