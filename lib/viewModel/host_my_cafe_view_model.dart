import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/host_my_cafe_model.dart';

class HostMyCafeViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  Token tokenInstance = Token();

  List<HostMyCafeModel>? _hostMyCafeModelList;

  List<HostMyCafeModel>? get hostMyCafeModelList => _hostMyCafeModelList;

  HostMyCafeViewModel() {
    _hostMyCafeModelList = [];
  }

  // progressState를 한글로 변환하는 매핑
  Map<String, String> progressStateMapping = {
    'RENTAL_PENDING': '대기중',
    'FINISHED': '완료',
    'IN_PROGRESS': '진행 중',
    'RENTAL_APPROVED': '승인',
    'RENTAL_CANCELED': '취소'
  };

  // progressState를 한글로 변환하는 함수
  String getProgressStateInKorean(String progressState) {
    return progressStateMapping[progressState] ?? '알 수 없음';
  }

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //주최자 나의 생일 카페 목록 가져오기
  Future<void> getHostMyCafe() async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _hostMyCafeModelList = [];
      List<dynamic> jsonData = response.data;
      List<HostMyCafeModel> cafeHomeModels =
          jsonData.map((e) => HostMyCafeModel.fromJson(e)).toList();

      // _hostCafeHomeModelList 추가
      _hostMyCafeModelList?.addAll(cafeHomeModels);

      log("model  $_hostMyCafeModelList");
      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //주최자 나의 생일 카페 대관 신청 취소 가져오기
  Future<void> postCancel(int cafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/birthday-cafes/$cafeId/cancel',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
