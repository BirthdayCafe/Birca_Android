import 'dart:developer';
import 'package:birca/model/visitor_cafe_like_model.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/api.dart';

class VisitorCafeLikeViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  Token tokenInstance = Token();

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
    String token = await tokenInstance.getToken();

    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //찜한 카페 삭제
  Future<void> deleteCafeLike(int index) async {
    String token = await tokenInstance.getToken();

    notifyListeners();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.delete(
          '${baseUrl}api/v1/birthday-cafes/$index/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      notifyListeners();

      // 서버 응답 출력
      log('Response: ${response.data}');
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
