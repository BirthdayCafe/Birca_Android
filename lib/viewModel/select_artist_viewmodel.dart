import 'dart:convert';
import 'dart:developer';

import 'package:birca/model/artist_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SelectArtistViewModel extends ChangeNotifier {
  Dio dio = Dio();
  List<ArtistModel>? _artistModel;
  List<ArtistModel>? get artistModel => _artistModel;

  bool _isSelectGroupArtist = true;
  bool get isSelectGroupArtist => _isSelectGroupArtist;

  bool _isSelectSoloArtist = false;
  bool get isSelectSoloArtist => _isSelectSoloArtist;

  int _groupArtistCount = 0;
  int get groupArtistCount => _groupArtistCount;

  int _soloArtistCount = 0;
  int get soloArtistCount => _soloArtistCount;

  void updateArtistType() {
    _isSelectGroupArtist = !_isSelectGroupArtist;
    _isSelectSoloArtist = !_isSelectSoloArtist;
    notifyListeners();
  }

  SelectArtistViewModel() {
    getGroupArtist();
  }

  Future<void> getGroupArtist() async {
    const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
      token = loginData['accessToken'].toString();
    }

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
          '${baseUrl}api/v1/artists/solo',
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      _artistModel = (response.data as List).map((item) => ArtistModel.fromJson(item)).toList();
      _soloArtistCount = _artistModel!.length;
      notifyListeners();
    } catch (e) {
      log("error:$e");
    }
  }
}