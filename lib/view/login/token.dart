import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  static const storage = FlutterSecureStorage();
  var token = '';

  Future<String> getToken() async {
    var loginToken = await storage.read(key: 'loginToken');

    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    return token;
  }
}