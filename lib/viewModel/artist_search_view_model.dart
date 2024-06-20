import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/artist_search_model.dart';

class ArtistSearchViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();

  List<ArtistSearchModel>? _artistSearchModelList;

  List<ArtistSearchModel>? get artistSearchModelList => _artistSearchModelList;

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //아티스트 검색 결과
  Future<void> getArtistSearch(String artistName) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    //토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/artists/search',
          queryParameters: {
            'name': artistName,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _artistSearchModelList = [];

      List<dynamic> jsonData = response.data;
      List<ArtistSearchModel> artistSearcheModels =
          jsonData.map((e) => ArtistSearchModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _artistSearchModelList?.addAll(artistSearcheModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
