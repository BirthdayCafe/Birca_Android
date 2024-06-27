import 'dart:convert';
import 'dart:developer';
import 'package:birca/designSystem/text.dart';
import 'package:birca/viewModel/business_license_view_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/mypage_view_model.dart';
import '../../widgets/appbar.dart';
import 'onboarding_cafe_owner_complete.dart';

class OnboardingCafeOwner extends StatefulWidget {
  const OnboardingCafeOwner({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingCafeOwner();
}

class _OnboardingCafeOwner extends State<OnboardingCafeOwner> {
  String? _filePath;

  String? _fileName;
  int upload = 0;

  //계정 요청 data
  bool isFileUpload = false;
  String? businessLicense;
  TextEditingController cafeName = TextEditingController();
  TextEditingController businessLicenseNumber = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController address = TextEditingController();
  bool isButtonOk = false;
  Color buttonColor = const Color(0xff59595A);

  void _updateButtonState() {
    log('cafeName.text : ${cafeName.text}');
    log('businessLicenseNumber.text : ${businessLicenseNumber.text}');
    log('owner.text : ${owner.text}');
    log('address.text : ${address.text}');
    log('isFileUpload : $isFileUpload');

    setState(() {
      // 텍스트 필드에 값이 있으면 버튼을 활성화합니다.
      if (cafeName.text != '' &&
          businessLicenseNumber.text != '' &&
          owner.text != '' &&
          address.text != '' &&
          isFileUpload == true) {
        isButtonOk = true;
        buttonColor = Palette.primary;
      } else {
        isButtonOk = false;
        buttonColor = Palette.gray04;
      }
    });
  }

  @override
  void dispose() {
    // 페이지가 dispose될 때 컨트롤러도 함께 dispose 해줍니다.
    cafeName.dispose();
    businessLicenseNumber.dispose();
    owner.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bircaAppBar(() {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: '카페 정보',
                        style: TextStyle(
                            color: Palette.primary,
                            fontSize: 30,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardBold'),
                      ),
                      TextSpan(
                        text: '를 등록해주세요',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                    ]),
              ),
              const Padding(padding: EdgeInsets.only(top: 52)),
              Row(
                children: [
                  const Text(
                    "사업자등록증",
                    style:
                        TextStyle(fontFamily: 'PretendardMedium', fontSize: 16),
                  ),
                  Consumer<BusinessLicenseViewModel>(
                      builder: (context, viewModel, widget) {
                    return IconButton(
                        onPressed: () {
                          viewModel.showChat();
                        },
                        icon: SvgPicture.asset(
                            'lib/assets/image/img_ri_question.svg'));
                  })
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 96,
                      height: 36,
                      child: OutlinedButton(
                        onPressed: () {
                          // if (upload < 5) {
                          _pickFile();
                          // } else {
                          //   log('사용 횟수 종료');
                          // }
                        },
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: Palette.primary,
                            textStyle: const TextStyle(
                                fontFamily: 'PretendardMedium', fontSize: 14),
                            side: const BorderSide(color: Palette.primary),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Text(
                          '파일 업로드',
                        ),
                      )),
                  const SizedBox(
                    width: 14,
                  ),
                  _fileName != null
                      ? Expanded(
                          child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "$_fileName",
                            maxLines: 1,
                          ),
                        ))
                      : const Text("파일을 선택해주세요."),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BircaText(
                  text: '파일을 $upload회 업로드 하셨습니다. ($upload/5) ',
                  textSize: 12,
                  textColor: const Color(0xffFE2E2E),
                  fontFamily: 'PretendardRegular'),
              const SizedBox(height: 40),
              const Text(
                '카페 이름',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              TextField(
                controller: cafeName,
                onChanged: (text) {
                  _updateButtonState();
                },
                decoration: const InputDecoration(
                    //비활성화
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD7D8DC))),

                    //활성화
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.primary))),
              ),
              const SizedBox(height: 40),
              const Text(
                '사장님 이름',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              TextField(
                controller: owner,
                onChanged: (text) {
                  _updateButtonState();
                },
                decoration: const InputDecoration(
                    //비활성화
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD7D8DC))),

                    //활성화
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.primary))),
              ),
              const SizedBox(height: 40),
              const Text(
                '사업자등록증 번호',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              TextField(
                controller: businessLicenseNumber,
                onChanged: (text) {
                  _updateButtonState();
                },
                decoration: const InputDecoration(
                    //비활성화
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD7D8DC))),

                    //활성화
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.primary))),
              ),
              const SizedBox(height: 40),
              const Text(
                '카페 주소',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              TextField(
                controller: address,
                onChanged: (text) {
                  _updateButtonState();
                },
                decoration: const InputDecoration(
                    //비활성화
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD7D8DC))),

                    //활성화
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.primary))),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: FilledButton(
                        onPressed: isButtonOk
                            ? () async {
                                FormData applyData = FormData.fromMap({
                                  'businessLicense':
                                      await MultipartFile.fromFile(_filePath!,
                                          filename: _fileName),
                                  'cafeName': cafeName.text,
                                  'businessLicenseNumber':
                                      businessLicenseNumber.text,
                                  'owner': owner.text,
                                  'address': address.text
                                });

                                await Provider.of<MypageViewModel>(context,
                                    listen: false)
                                    .postRoleChange('OWNER');

                                await postCafeApply(applyData).then((_) {
                                  // Navigate on success
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const OnboardingCafeOwnerComplete()));
                                }).catchError((error) {
                                  log('fail');
                                });
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: buttonColor,
                        ),
                        child: const Text('계정 요청하기'),
                      ))
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        )));
  }

  //사업자 등록증 제출
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {

      _showLoadingDialog(context);

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

      Dio dio = Dio();

      _filePath = result.files.single.path;
      _fileName = result.files.single.name;

      // FormData 생성
      FormData businessLicense = FormData.fromMap({
        'businessLicense':
            await MultipartFile.fromFile(_filePath!, filename: _fileName),
      });

      //파일 전송 api
      try {
        // API 엔드포인트 및 업로드
        Response response = await dio.post(
            '${baseUrl}api/v1/cafes/license-read',
            data: businessLicense,
            options: Options(headers: {'Authorization': 'Bearer $token'})
            // options: Options(headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzA4MzE1MTk4LCJleHAiOjE3MDg0OTUxOTh9.5XD5tY3q0-PBH9nkPCFEOnrONM6xVR8wcLuoTX8idk8'})
            );

        // 서버 응답 출력
        log('Response: ${response.data}');
        setState(() {
          // upload++;
          isFileUpload = true;
          cafeName.text = response.data['cafeName'];
          businessLicenseNumber.text = response.data['businessLicenseNumber'];
          owner.text = response.data['owner'];
          address.text = response.data['address'];
          upload = response.data['uploadCount'];
          _updateButtonState();
        });
      } catch (e) {
        if (e is DioException) {
          // Dio exception handling
          if (e.response != null) {
            // Server responded with an error
            if (e.response!.statusCode == 400) {
              // Handle HTTP 400 Bad Request error
              log('Bad Request - Server returned 400 status code');
              log('Response data: ${e.response!.data}');
              throw Exception('Failed to upload.');

              // Additional error handling logic here if needed
            } else {
              // Handle other HTTP status codes
              log('Server error - Status code: ${e.response!.statusCode}');
              log('Response data: ${e.response!.data}');
              throw Exception('Failed to upload.');

              // Additional error handling logic here if needed
            }
          } else {
            // No response from the server (network error, timeout, etc.)
            log('Dio error: ${e.message}');
            throw Exception('Failed to upload.');
          }
        } else {
          // Handle other exceptions if necessary
          log('Error: $e');
          throw Exception('Failed to upload.');
        }
      } finally{
        _hideLoadingDialog(context);
      }
    } else {
      // 사용자가 선택을 취소한 경우
      log("파일 선택이 취소되었습니다.");
      throw Exception('Failed to login.');
    }
  }
}

//카페 요청하기
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
  } catch (e) {
    if (e is DioException) {
      // Dio exception handling
      if (e.response != null) {
        // Server responded with an error
        if (e.response!.statusCode == 400) {
          // Handle HTTP 400 Bad Request error
          log('Bad Request - Server returned 400 status code');
          log('Response data: ${e.response!.data}');
          throw Exception('Failed to login.');

          // Additional error handling logic here if needed
        } else {
          // Handle other HTTP status codes
          log('Server error - Status code: ${e.response!.statusCode}');
          log('Response data: ${e.response!.data}');
          throw Exception('Failed to login.');

          // Additional error handling logic here if needed
        }
      } else {
        // No response from the server (network error, timeout, etc.)
        log('Dio error: ${e.message}');
        throw Exception('Failed to login.');
      }
    } else {
      // Handle other exceptions if necessary
      log('Error: $e');
      throw Exception('Failed to login.');
    }
  }
}
void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void _hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}