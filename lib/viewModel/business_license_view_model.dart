import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:birca/model/businessLicenseModel.dart';
import 'package:birca/view/login/token.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

//오류 수정
class BusinessLicenseViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Token tokenInstance = Token();
  Api api = Api();
  var baseUrl = dotenv.env['BASE_URL'];

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

      String token = await tokenInstance.getToken();

      _filePath = result.files.single.path!;
      _fileName = result.files.single.name;

      // FormData 생성
      FormData businessLicense = FormData.fromMap({
        'businessLicense':
            await MultipartFile.fromFile(_filePath!, filename: _fileName),
      });

      // LogInterceptor 추가
      api.logInterceptor();

      //파일 전송 api
      try {
        // API 엔드포인트 및 업로드
        Response response = await dio.post(
            '${baseUrl}api/v1/cafes/license-read',
            data: businessLicense,
            options: Options(headers: {'Authorization': 'Bearer $token'}));

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
        api.errorCheck(e);
      }
    } else {
      // 사용자가 선택을 취소한 경우
      log("파일 선택이 취소되었습니다.");
      // log(_uploadCount.toString());
      throw Exception('Failed to upload business license.');
    }
  }

  Future<void> postCafeApply(FormData applyData) async {
    String token = await tokenInstance.getToken();

    try {
      Response response = await dio.post('${baseUrl}api/v1/cafes/apply',
          data: applyData,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      log(response.data.toString());

      log("전송 성공");
    } catch (e) {
      api.errorCheck(e);
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
