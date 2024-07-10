import 'dart:developer';
import 'package:birca/model/visitor_cafe_home_model.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../model/api.dart';

class VisitorCafeHomeViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();
  Token tokenInstance = Token();

  List<VisitorCafeHomeModel>? _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? get visitorCafeHomeModelList =>
      _visitorCafeHomeModelList;

  List<VisitorCafeHomeModel>? _visitorCafeSearchModelList;

  List<VisitorCafeHomeModel>? get visitorCafeSearchModelList =>
      _visitorCafeSearchModelList;

  List<HomeArtists>? _homeArtistsList;

  List<HomeArtists>? get homeArtistsList => _homeArtistsList;

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  //방문자 최애 아티스트 가져오기
  Future<void> getFavoriteArtist() async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();
    _homeArtistsList = [];
    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/artists/favorite',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getFavoriteArtist: ${response.data}');

        homeArtistsList?.add(HomeArtists.fromJson(response.data));

        getInterestArtist();
      log('getFavoriteArtist id: ${homeArtistsList![0].artistId}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //방문자 관심 아티스트 가져오기
  Future<void> getInterestArtist() async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/artists/interest',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getInterestArtist: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<HomeArtists> artists =
          jsonData.map((e) => HomeArtists.fromJson(e)).toList();

      for(int i=0; i<artists.length;i++){
        if(homeArtistsList![0].artistId!=artists[i].artistId){
          homeArtistsList?.add(artists[i]);
        }
      }
      // homeArtistsList?.addAll(artists);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //방문자 홈 카페 가져오기
  Future<void> getCafeHome(
      int cursor, int size, String name, String progressState) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            'cursor': cursor,
            'size': size,
            'name': name,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');
      _visitorCafeHomeModelList = [];

      List<dynamic> jsonData = response.data;
      List<VisitorCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => VisitorCafeHomeModel.fromJson(e)).toList();

      _visitorCafeHomeModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //방문자 카페 더 가져오기
  Future<void> updateCafeHome(
      int cursor, int size, String name, String progressState) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            'cursor': cursor,
            'size': size,
            'name': name,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<VisitorCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => VisitorCafeHomeModel.fromJson(e)).toList();

      _visitorCafeHomeModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //방문자 검색
  Future<void> getCafeSearch(String progressState, String name) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get('${baseUrl}api/v1/birthday-cafes',
          queryParameters: {
            'progressState': progressState,
            // 'cursor' : cursor,
            // 'size' : size,
            'name': name,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<VisitorCafeHomeModel> cafeHomeModels =
          jsonData.map((e) => VisitorCafeHomeModel.fromJson(e)).toList();

      _visitorCafeSearchModelList = [];
      _visitorCafeSearchModelList?.addAll(cafeHomeModels);

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //찜하기
  Future<void> like(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //찜 취소
  Future<void> dislike(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.delete(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  void heart(int id, int index, BuildContext context) {
    if (visitorCafeHomeModelList![index].isLiked) {
      Provider.of<VisitorCafeHomeViewModel>(context, listen: false).dislike(id);

      visitorCafeHomeModelList![index].isLiked = false;
    } else {
      Provider.of<VisitorCafeHomeViewModel>(context, listen: false).like(id);

      visitorCafeHomeModelList![index].isLiked = true;
    }
    notifyListeners();
  }
}
