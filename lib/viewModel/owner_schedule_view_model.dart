import 'dart:developer';
import 'package:birca/model/owner_schedule_model.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/api.dart';

class OwnerScheduleViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  Token tokenInstance = Token();

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

  final TextEditingController _memoController = TextEditingController();

  TextEditingController get memoController => _memoController;

  int? _nowBirthdayCafeId;

  int? get nowBirthdayCafeId => _nowBirthdayCafeId;

  bool _isScheduleExist = false;

  bool get isScheduleExist => _isScheduleExist;

  //사장님 스케줄 추가
  Future<void> postSchedule(OwnerScheduleAddModel ownerScheduleAddModel) async {
    String token = await tokenInstance.getToken();

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
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v2/owners/birthday-cafes/schedules/detail',
          queryParameters: {'date': dateTime},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _ownerScheduleModel = null;

      // 서버 응답 출력
      log('getScheduleDetail Response: ${response.data}');

      if (response.data != null && response.data.isNotEmpty) {
        _ownerScheduleModel = OwnerScheduleModel.fromJson(response.data);
        _nowBirthdayCafeId = _ownerScheduleModel!.birthdayCafeId;
        _isScheduleExist = true;
        _memoController.text = _ownerScheduleModel!.memo;
      } else {
        _nowBirthdayCafeId = 0;
        _isScheduleExist = false;
      }

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //대관 취소
  Future<void> postCancel(int cafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/birthday-cafes/$cafeId/cancel',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      _ownerScheduleModel = null;
      _memoController.text = '';
      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //memo 작성
  Future<void> postMemo() async {
    String token = await tokenInstance.getToken();
    api.logInterceptor();

    log(_nowBirthdayCafeId.toString());
    try {
      Response response = await dio.post(
          '${baseUrl}api/v1/$_nowBirthdayCafeId/memo',
          data: {'content': memoController.text},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      notifyListeners();

      log(response.data);
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //사장님 예약 날짜 가져오기
  Future<void> getSchedule(int year, int month) async {
    String token = await tokenInstance.getToken();

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

  void updateMemo() {
    notifyListeners();
  }
}
