import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:birca/model/owner_request_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OwnerRequestDetailViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  OwnerRequestDetailModel? _ownerRequestDetailModel;

  OwnerRequestDetailModel? get ownerRequestDetailModel =>
      _ownerRequestDetailModel;

  //사장님 대관 요청 상세 가져오기
  Future<void> getRequestDetailHome(int birthdayCafeId) async {
    var loginToken = await storage.read(key: 'loginToken');

    // 토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();
    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/owners/birthday-cafes/$birthdayCafeId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      _ownerRequestDetailModel =
          OwnerRequestDetailModel.fromJson(response.data);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일 카페 신청 수락
  Future<void> postApprove(int birthdayCafeId) async {
    var loginToken = await storage.read(key: 'loginToken');

    // 토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/owners/birthday-cafes/$birthdayCafeId/approve',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일 카페 신청 수락
  Future<void> postCancel(int birthdayCafeId) async {
    var loginToken = await storage.read(key: 'loginToken');

    // 토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/owners/birthday-cafes/$birthdayCafeId/cancel',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
