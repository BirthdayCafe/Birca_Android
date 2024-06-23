import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:birca/model/host_cafe_home_detail_model.dart';
import 'package:birca/model/host_cafe_home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HostHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();

  List<HostCafeHomeModel>? _hostCafeHomeModelList;

  List<HostCafeHomeModel>? get hostCafeHomeModelList => _hostCafeHomeModelList;

  HostCafeHomeDetailModel? _hostCafeHomeDetailModel;

  HostCafeHomeDetailModel? get hostCafeHomeDetailModel =>
      _hostCafeHomeDetailModel;

  List<RentalSchedule>? _rentalScheduleList;

  List<RentalSchedule>? get rentalScheduleList => _rentalScheduleList;

  List<Map<String, DateTime>> _dateRanges = [];

  List<Map<String, DateTime>> get dateRanges => _dateRanges;

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //host 홈 카페 가져오기
  Future<void> getHostHome(int cursor, int size, String name, bool liked,
      String startDate, String endDate) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      Response? response;
      if (liked) {
        // API 엔드포인트 및 업로드
        response = await dio.get('${baseUrl}api/v1/cafes',
            queryParameters: {
              'startDate': startDate,
              'endDate': endDate,
              'liked': liked,
              'cursor': cursor,
              'size': size,
              'name': name
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      } else {
        // API 엔드포인트 및 업로드
        response = await dio.get('${baseUrl}api/v1/cafes',
            queryParameters: {
              'startDate': startDate,
              'endDate': endDate,
              'cursor': cursor,
              'size': size,
              'name': name
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      }
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
      api.errorCheck(e);
    }
  }

  //load more
  Future<void> updateHostHome(int cursor, int size, String name, bool liked,
      String startDate, String endDate) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      Response? response;
      if (liked) {
        // API 엔드포인트 및 업로드
        response = await dio.get('${baseUrl}api/v1/cafes',
            queryParameters: {
              'startDate': startDate,
              'endDate': endDate,
              'liked': liked,
              'cursor': cursor,
              'size': size,
              'name': name
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      } else {
        // API 엔드포인트 및 업로드
        response = await dio.get('${baseUrl}api/v1/cafes',
            queryParameters: {
              'startDate': startDate,
              'endDate': endDate,
              'cursor': cursor,
              'size': size,
              'name': name
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      }
      // 서버 응답 출력
      log('Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<HostCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => HostCafeHomeModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _hostCafeHomeModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //카페 찜하기
  Future<void> postLike(int cafeId) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post('${baseUrl}api/v1/cafes/$cafeId/like',
          queryParameters: {},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //카페 찜 취소
  Future<void> deleteLike(int cafeId) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.delete(
          '${baseUrl}api/v1/cafes/$cafeId/like',
          queryParameters: {},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //카페 상세
  Future<void> getCafeDetail(int cafeId) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/cafes/$cafeId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      _hostCafeHomeDetailModel =
          HostCafeHomeDetailModel.fromJson(response.data);

      // _hostCafeHomeDetailModelList 추가
      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //카페 대관 신청
  Future<void> postRequest(HostRequestModel hostRequestModel) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post('${baseUrl}api/v1/birthday-cafes',
          data: hostRequestModel.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('postRequest Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  Future<void> getSchedule(int cafeId, int year, int month) async {
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    // 토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/cafes/$cafeId/schedules',
          queryParameters: {'year': year, 'month': month},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _rentalScheduleList = [];

      List<dynamic> jsonData = response.data;
      List<RentalSchedule> models =
          jsonData.map((e) => RentalSchedule.fromJson(e)).toList();

      _rentalScheduleList?.addAll(models);
      // 서버 응답 출력
      log('getSchedule Response: ${response.data}');

      _dateRanges = [];
      for (int i = 0; i < _rentalScheduleList!.length; i++) {
        _dateRanges.add(
          {
            'start': DateTime(
                _rentalScheduleList![i].startYear,
                _rentalScheduleList![i].startMonth,
                _rentalScheduleList![i].startDay),
            'end': DateTime(
                _rentalScheduleList![i].endYear,
                _rentalScheduleList![i].endMonth,
                _rentalScheduleList![i].endDay)
          },
        );
      }

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
