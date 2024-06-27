import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/api.dart';
import '../model/owner_home_model.dart';

class OwnerHomeViewModel extends ChangeNotifier{
  Dio dio = Dio();
  Api api = Api();

  List<OwnerHomeModel>? _ownerHomeModelList;
  List<OwnerHomeModel>? get ownerHomeModelList =>
      _ownerHomeModelList;

  OwnerHomeViewModel(){
    _ownerHomeModelList = [];
  }

  //홈 가져오기
  Future<void> getOwnerHome(String progressState) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    //
    // var loginToken = await storage.read(key: 'loginToken');

    // 토큰 가져오기
    // if (loginToken != null) {
    //   Map<String, dynamic> loginData = json.decode(loginToken);
    //   token = loginData['accessToken'].toString();
    // }

    api.logInterceptor();

    _ownerHomeModelList = [];

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/owners/birthday-cafes',

          queryParameters: {
            'progressState': progressState,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<OwnerHomeModel> cafeHomeModels =
      jsonData.map((e) => OwnerHomeModel.fromJson(e)).toList();

      // _hostCafeHomeModelList 추가
      _ownerHomeModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}