import 'dart:developer';
import 'package:birca/model/group_artist_model.dart';
import 'package:birca/model/solo_artist_model.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SelectFavoriteArtistViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Token tokenInstance = Token();
  List<SoloArtistModel>? _soloArtist;

  List<SoloArtistModel>? get soloArtist => _soloArtist;

  List<GroupArtistModel>? _groupArtist;

  List<GroupArtistModel>? get groupArtist => _groupArtist;

  List<SoloArtistModel>? _groupMember;

  List<SoloArtistModel>? get groupMember => _groupMember;

  bool _isSelectGroupArtist = true;

  bool get isSelectGroupArtist => _isSelectGroupArtist;

  bool _isSelectSoloArtist = false;

  bool get isSelectSoloArtist => _isSelectSoloArtist;

  int _groupArtistCount = 0;

  int get groupArtistCount => _groupArtistCount;

  int _soloArtistCount = 0;

  int get soloArtistCount => _soloArtistCount;

  int _groupMemberCount = 0;

  int get groupMemberCount => _groupMemberCount;

  List<SoloArtistModel> _selectedArtist = [];

  List<SoloArtistModel> get selectedArtist => _selectedArtist;

  void updateArtistType() {
    _isSelectGroupArtist = !_isSelectGroupArtist;
    _isSelectSoloArtist = !_isSelectSoloArtist;
    notifyListeners();
  }

  void updateSelectedArtist(SoloArtistModel artist) {
    if (!_selectedArtist.contains(artist) && _selectedArtist.isEmpty) {
      _selectedArtist.add(artist);
      log(_selectedArtist.toString());
      notifyListeners();
    }
  }

  void removeSelectedArtist(SoloArtistModel artist) {
    _selectedArtist.remove(artist);
    notifyListeners();
  }

  SelectFavoriteArtistViewModel() {
    getSoloArtist();
    getGroupArtist();
  }

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';

  Future<void> getSoloArtist() async {
    String token = await tokenInstance.getToken();

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get('${baseUrl}api/v1/artists/solo',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      _soloArtist = (response.data as List)
          .map((item) => SoloArtistModel.fromJson(item))
          .toList();
      _soloArtistCount = _soloArtist!.length;
      notifyListeners();
    } catch (e) {
      log("error:$e");
    }
  }

  Future<void> getGroupArtist() async {
    String token = await tokenInstance.getToken();

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get('${baseUrl}api/v1/artist-groups',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      _groupArtist = (response.data as List)
          .map((item) => GroupArtistModel.fromJson(item))
          .toList();
      _groupArtistCount = _groupArtist!.length;
      notifyListeners();
    } catch (e) {
      log("error:$e");
    }
  }

  Future<void> getGroupMember(int groupId) async {
    String token = await tokenInstance.getToken();

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
          '${baseUrl}api/v1/artist-groups/$groupId/artists',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      _groupMember = (response.data as List)
          .map((item) => SoloArtistModel.fromJson(item))
          .toList();
      _groupMemberCount = _groupMember!.length;
      notifyListeners();
    } catch (e) {
      log("error:$e");
    }
  }

  Future<void> postFavoriteArtist() async {
    String token = await tokenInstance.getToken();

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      await dio.post('${baseUrl}api/v1/artists/favorite',
          data: {'artistId': _selectedArtist[0].groupId},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log("error: $e");
    }
  }
}
