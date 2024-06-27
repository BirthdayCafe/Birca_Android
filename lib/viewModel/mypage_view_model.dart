import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/api.dart';
import '../model/my_page_model.dart';
import '../view/login/token.dart';

class MypageViewModel extends ChangeNotifier {
  MypageModel? _nickname;

  MypageModel? get nickname => _nickname;

  Dio dio = Dio();
  Api api = Api();
  Token tokenInstance = Token();

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //닉네임 가져오기
  Future<void> getNickName() async {
    String token = await tokenInstance.getToken();

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
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      Response response = await dio.post('${baseUrl}api/v1/members/role-change',
          data: {'role': role},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log('$role 변경 ');

      log(response.data.toString());
    } catch (e) {
      api.errorCheck(e);
    }
  }

  Future<String> getRole() async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/members/role',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      // JSON 문자열을 Map으로 파싱
      Map<String, dynamic> decodedResponse = response.data;

      // "role" 값 추출
      return decodedResponse['role'] as String;
    } catch (e) {
      api.errorCheck(e);
      throw Exception('Failed to getRole.');
    }
  }
}
