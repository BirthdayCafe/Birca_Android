import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/businessLicenseModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BusinessLicenseViewModel extends ChangeNotifier {
  Dio dio = Dio();

  String? _filePath;

  String? get filePath => _filePath;

  String? _fileName;

  String? get fileName => _fileName;

  // int? _uploadCount;
  // int? get uploadCount => _uploadCount;

  BusinessLicenseModel? _businessLicenseModel;

  BusinessLicenseModel? get businessLicenseModel => _businessLicenseModel;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      //post business license
      const storage = FlutterSecureStorage();
      var baseUrl = dotenv.env['BASE_URL'];

      var token = '';
      var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

      //토큰 가져오기
      if (kakaoLoginInfo != null) {
        Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
        token = loginData['accessToken'].toString();
      }

      _filePath = result.files.single.path!;
      _fileName = result.files.single.name;

      // FormData 생성
      FormData businessLicense = FormData.fromMap({
        'businessLicense':
            await MultipartFile.fromFile(_filePath!, filename: _fileName),
      });

      // LogInterceptor 추가
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));

      //파일 전송 api
      try {
        // API 엔드포인트 및 업로드
        Response response = await dio.post(
            '${baseUrl}api/v1/cafes/license-read',
            data: businessLicense,
            options: Options(headers: {'Authorization': 'Bearer $token'})
            );

        // 서버 응답 출력
        log('Response: ${response.data}');


        log('cafeName: ${response.data['cafeName'].runtimeType}');
        log('businessLicenseNumber: ${response.data['businessLicenseNumber'].runtimeType}');
        log('owner: ${response.data['owner'].runtimeType}');
        log('address: ${response.data['address'].runtimeType}');
        log('uploadCount: ${response.data['uploadCount'].runtimeType}');

        _businessLicenseModel = BusinessLicenseModel(
            cafeName: response.data['cafeName'],
            businessLicenseNumber: response.data['businessLicenseNumber'],
            owner: response.data['owner'],
            address: response.data['address'],
            uploadCount:
                int.parse(response.data['uploadCount'].toString()));

        notifyListeners();
      } catch (e) {
        if (e is DioException) {
          // Dio exception handling
          if (e.response != null) {
            // Server responded with an error
            if (e.response!.statusCode == 400) {
              // Handle HTTP 400 Bad Request error
              log('Bad Request - Server returned 400 status code');
              log('Response data: ${e.response!.data}');
              // Additional error handling logic here if needed
            } else {
              // Handle other HTTP status codes
              log('Server error - Status code: ${e.response!.statusCode}');
              log('Response data: ${e.response!.data}');
              // Additional error handling logic here if needed
            }
          } else {
            // No response from the server (network error, timeout, etc.)
            log('Dio error: ${e.message}');
          }
        } else {
          // Handle other exceptions if necessary
          log('Error: $e');
        }
      }
    } else {
      // 사용자가 선택을 취소한 경우
      log("파일 선택이 취소되었습니다.");
      // log(_uploadCount.toString());
    }
  }
}
