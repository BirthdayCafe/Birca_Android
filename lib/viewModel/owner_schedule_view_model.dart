import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/owner_schedule_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/api.dart';

class OwnerScheduleViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  OwnerScheduleModel? _ownerScheduleModel;

  OwnerScheduleModel? get ownerScheduleModel => _ownerScheduleModel;

  List<OwnerScheduleExistModel>? _ownerScheduleExistModel;

  List<OwnerScheduleExistModel>? get ownerScheduleExistModel =>
      _ownerScheduleExistModel;

  List<Map<String, DateTime>> _dateRanges = [];

  List<Map<String, DateTime>> get dateRanges => _dateRanges;

  //사장님 스케줄 추가
  Future<void> postSchedule(OwnerScheduleAddModel ownerScheduleAddModel) async {
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
          '${baseUrl}api/v1/owners/birthday-cafes/schedules',
          data: ownerScheduleAddModel.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('postSchedule Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //사장님 스케줄 가져오기
  Future<void> getScheduleDetail(String dateTime) async {
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
          '${baseUrl}api/v1/owners/birthday-cafes/schedules/detail',
          queryParameters: {'date': dateTime},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _ownerScheduleModel = null;

      // 서버 응답 출력
      log('getScheduleDetail Response: ${response.data}');

      if (response.data != null && response.data.isNotEmpty) {
        _ownerScheduleModel = OwnerScheduleModel.fromJson(response.data);
      }

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //사장님 예약 날짜 가져오기
  Future<void> getSchedule(int year, int month) async {
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
          '${baseUrl}api/v1/owners/birthday-cafes/schedules',
          queryParameters: {'year': year, 'month': month},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _ownerScheduleExistModel = [];

      List<dynamic> jsonData = response.data;
      List<OwnerScheduleExistModel> cafeHomeModels =
          jsonData.map((e) => OwnerScheduleExistModel.fromJson(e)).toList();

      // _hostCafeHomeModelList 추가
      _ownerScheduleExistModel?.addAll(cafeHomeModels);
      // 서버 응답 출력
      log('getSchedule Response: ${response.data}');

      _dateRanges = [];
      for (int i = 0; i < ownerScheduleExistModel!.length; i++) {
        _dateRanges.add(
          {
            'start': DateTime(
                ownerScheduleExistModel![i].startYear,
                ownerScheduleExistModel![i].startMonth,
                ownerScheduleExistModel![i].startDay),
            'end': DateTime(
                ownerScheduleExistModel![i].endYear,
                ownerScheduleExistModel![i].endMonth,
                ownerScheduleExistModel![i].endDay)
          },
        );
      }

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }
}
