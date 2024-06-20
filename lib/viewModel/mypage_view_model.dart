import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/api.dart';
import '../model/my_page_model.dart';

class MypageViewModel extends ChangeNotifier {
  MypageModel? _nickname;

  MypageModel? get nickname => _nickname;

  Dio dio = Dio();
  Api api = Api();

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //닉네임 가져오기
  Future<void> getNickName() async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }
    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/members/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.toString());

      _nickname = MypageModel.fromJson(response.data);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //post role change
  Future<void> postRoleChange(String role) async {
    const storage = FlutterSecureStorage();

    Dio dio = Dio();
    Response response;
    var baseUrl = dotenv.env['BASE_URL'];

    var token = '';
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    api.logInterceptor();

    //토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    try {
      response = await dio.post('${baseUrl}api/v1/members/role-change',
          data: {'role': role},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      // log('kakaoLoginInfo : $kakaoLoginInfo');

      log('$role 변경 ');

      log(response.data.toString());
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
