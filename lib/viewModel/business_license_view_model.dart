import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/businessLicenseModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

//오류 수정
class BusinessLicenseViewModel extends ChangeNotifier {
  Dio dio = Dio();

  String? _filePath;

  String? get filePath => _filePath;

  String? _fileName;

  String? get fileName => _fileName;

  BusinessLicenseModel? _businessLicenseModel;

  BusinessLicenseModel? get businessLicenseModel => _businessLicenseModel;

  TextEditingController _cafeName = TextEditingController();

  TextEditingController get cafeName => _cafeName;

  TextEditingController businessLicenseNumber = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController address = TextEditingController();

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
      var loginToken = await storage.read(key: 'loginToken');

      //토큰 가져오기
      if (loginToken != null) {
        Map<String, dynamic> loginData = json.decode(loginToken);
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
            options: Options(headers: {'Authorization': 'Bearer $token'}));

        // 서버 응답 출력
        log('Response: ${response.data}');

        // log('cafeName: ${response.data['cafeName'].runtimeType}');
        // log('businessLicenseNumber: ${response.data['businessLicenseNumber'].runtimeType}');
        // log('owner: ${response.data['owner'].runtimeType}');
        // log('address: ${response.data['address'].runtimeType}');
        // log('uploadCount: ${response.data['uploadCount'].runtimeType}');

        _businessLicenseModel = BusinessLicenseModel(
            cafeName: response.data['cafeName'],
            businessLicenseNumber: response.data['businessLicenseNumber'],
            owner: response.data['owner'],
            address: response.data['address'],
            uploadCount: int.parse(response.data['uploadCount'].toString()));

        // cafeName.text = _businessLicenseModel!.cafeName.toString();

        cafeName.text = _businessLicenseModel!.cafeName.toString();
        businessLicenseNumber.text =
            _businessLicenseModel!.businessLicenseNumber.toString();
        owner.text = _businessLicenseModel!.owner.toString();
        address.text = _businessLicenseModel!.address.toString();

        log('businessLicenseNumber.text : ${businessLicenseNumber.text}');
        log('owner.text.text : ${owner.text}');
        log('address.text.text : ${address.text}');

        notifyListeners();
      } catch (e) {
        if (e is DioException) {
          // Dio exception handling
          if (e.response != null) {
            // Server responded with an error
            if (e.response!.statusCode == 400) {
              // Handle HTTP 400 Bad Request error
              log('Bad Request - Server returned 400 status code');
              throw Exception('Failed to upload business license.');

              // Additional error handling logic here if needed
            } else {
              // Handle other HTTP status codes
              log('Server error - Status code: ${e.response!.statusCode}');
              throw Exception('Failed to upload business license.');
              // Additional error handling logic here if needed
            }
          } else {
            // No response from the server (network error, timeout, etc.)
            log('Dio error: ${e.message}');
            throw Exception('Failed to upload business license.');
          }
        } else {
          // Handle other exceptions if necessary
          log('Error: $e');
          throw Exception('Failed to upload business license.');
        }
      }
    } else {
      // 사용자가 선택을 취소한 경우
      log("파일 선택이 취소되었습니다.");
      // log(_uploadCount.toString());
      throw Exception('Failed to upload business license.');
    }
  }

  Future<void> postCafeApply(FormData applyData) async {
    const storage = FlutterSecureStorage();

    Dio dio = Dio();
    Response response;
    var baseUrl = dotenv.env['BASE_URL'];

    var token = '';
    var loginToken = await storage.read(key: 'loginToken');

    //토큰 가져오기
    if (loginToken != null) {
      Map<String, dynamic> loginData = json.decode(loginToken);
      token = loginData['accessToken'].toString();
    }

    try {
      response = await dio.post('${baseUrl}api/v1/cafes/apply',
          data: applyData,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.data.toString());

      log("전송 성공");
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            log('Response data: ${e.response!.data}');
            throw Exception('Failed to apply cafe.');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            log('Response data: ${e.response!.data}');
            throw Exception('Failed to apply cafe.');

            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to apply cafe.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to apply cafe.');
      }
    }
  }

  void showChat() {
    Fluttertoast.showToast(
        msg:
            '카페의 사업자등록증을 업로드하면 아래의 정보가 자동으로 기입됩니다.\n사업자 등록증은 5회까지 업로드 가능합니다.\n5회를 초과할 시 업로드 제한되니 신중하게 진행해주세요.',
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color(0xff59595A),
        fontSize: 12);
  }

  void resetData() {
    _businessLicenseModel = BusinessLicenseModel(
        cafeName: '',
        businessLicenseNumber: '',
        owner: '',
        address: '',
        uploadCount: 0);
    // Add any other properties that need to be reset
    // ...
    _fileName = '';
    _filePath = '';
    notifyListeners();
  }
}
