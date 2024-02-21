import 'dart:convert';
import 'dart:developer';
import 'package:birca/designSystem/text.dart';
import 'package:birca/viewModel/businessLicenseViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../widgets/appbar.dart';
import 'onboarding_cafe_owner_complete.dart';

class OnboardingCafeOwner extends StatefulWidget {
  const OnboardingCafeOwner({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingCafeOwner();
}

class _OnboardingCafeOwner extends State<OnboardingCafeOwner> {
  // String? _filePath;
  //
  // String? _fileName;
  // int upload = 0;

  //계정 요청 data
  bool isFileUpload = false;

  // String? businessLicense;
  TextEditingController cafeName = TextEditingController();
  TextEditingController businessLicenseNumber = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController address = TextEditingController();
  bool isButtonOk = false;
  Color buttonColor = const Color(0xff59595A);

  @override
  void didChangeDependencies() {
    // Clear the text fields when dependencies change (when returning to the screen)
    cafeName.text = '';
    businessLicenseNumber.text = '';
    owner.text = '';
    address.text = '';

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   // Initialize the text controllers with values from the ViewModel
  //   cafeName.text =
  //       Provider.of<BusinessLicenseViewModel>(context, listen: false)
  //               .businessLicenseModel
  //               ?.cafeName ??
  //           '';
  //   businessLicenseNumber.text =
  //       Provider.of<BusinessLicenseViewModel>(context, listen: false)
  //               .businessLicenseModel
  //               ?.businessLicenseNumber ??
  //           '';
  //   owner.text = Provider.of<BusinessLicenseViewModel>(context, listen: false)
  //           .businessLicenseModel
  //           ?.owner ??
  //       '';
  //   address.text = Provider.of<BusinessLicenseViewModel>(context, listen: false)
  //           .businessLicenseModel
  //           ?.address ??
  //       '';
  //
  //
  //
  //   super.initState();
  // }

  void _updateButtonState() {
    setState(() {
      // 텍스트 필드에 값이 있으면 버튼을 활성화합니다.
      if (cafeName.text != '' &&
          businessLicenseNumber.text != '' &&
          owner.text != '' &&
          address.text != '' &&
          isFileUpload == true) {
        isButtonOk = true;
        buttonColor = Palette.primary;
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
                  IconButton(
                      onPressed: () {
                        showChat(context);
                      },
                      icon: SvgPicture.asset(
                          'lib/assets/image/img_ri_question.svg'))
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
                          // _pickFile();
                          Provider.of<BusinessLicenseViewModel>(context,
                                  listen: false)
                              .pickFile()
                              .then((value) {
                            isFileUpload = true;
                            _updateButtonState();
                          });
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
                  Consumer<BusinessLicenseViewModel>(
                      builder: (context, viewModel, child) {
                    if (viewModel.fileName != null) {
                      return Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${viewModel.fileName}",
                          maxLines: 1,
                        ),
                      ));
                    } else {
                      return const Text("파일을 선택해주세요.");
                    }
                  })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<BusinessLicenseViewModel>(
                  builder: (context, viewModel, child) {
                return BircaText(
                    text:
                        '파일을 ${viewModel.businessLicenseModel?.uploadCount}회 업로드 하셨습니다. (${viewModel.businessLicenseModel?.uploadCount}/5) ',
                    textSize: 12,
                    textColor: const Color(0xffFE2E2E),
                    fontFamily: 'PretendardRegular');
              }),
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
              Consumer<BusinessLicenseViewModel>(
                  builder: (context, viewModel, child) {

                      if (viewModel.businessLicenseModel?.owner != null) {
                        owner.text = viewModel.businessLicenseModel!.owner;
                      }



                return TextField(
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
                );
              }),
              const SizedBox(height: 40),
              const Text(
                '사업자등록증 번호',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              Consumer<BusinessLicenseViewModel>(
                  builder: (context, viewModel, child) {

                  if (viewModel.businessLicenseModel?.businessLicenseNumber !=
                      null) {
                      businessLicenseNumber.text =
                          viewModel.businessLicenseModel!.businessLicenseNumber;

                  }

                return TextField(
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
                );
              }),
              const SizedBox(height: 40),
              const Text(
                '카페 주소',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              Consumer<BusinessLicenseViewModel>(
                  builder: (context, viewModel, child) {

                  if (viewModel.businessLicenseModel?.address != null) {
                      address.text = viewModel.businessLicenseModel!.address;

                  }

                return TextField(
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
                );
              }),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<BusinessLicenseViewModel>(
                      builder: (context, viewModel, child) {
                    return SizedBox(
                        width: 300,
                        child: FilledButton(
                          onPressed: isButtonOk
                              ? () async {

                            if(cafeName.text != ''&& owner.text != ''&& businessLicenseNumber.text != '' &&cafeName.text!= ''){
                              FormData applyData = FormData.fromMap({
                                'businessLicense':
                                await MultipartFile.fromFile(
                                    viewModel.filePath!,
                                    filename: viewModel.fileName),
                                'cafeName': cafeName.text,
                                'businessLicenseNumber':
                                businessLicenseNumber.text,
                                'owner': owner.text,
                                'address': address.text
                              });

                              postCafeApply(applyData).then((_) {
                                // Navigate on success
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                    const OnboardingCafeOwnerComplete()));
                              }).catchError((error) {
                                log('fail');
                              });
                            }

                                }
                              : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                          child: const Text('계정 요청하기'),
                        ));
                  })
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        )));
  }

  void showChat(BuildContext context) {
    Fluttertoast.showToast(
        msg:
            '카페의 사업자등록증을 업로드하면 아래의 정보가 자동으로 기입됩니다.\n사업자 등록증은 5회까지 업로드 가능합니다.\n5회를 초과할 시 업로드 제한되니 신중하게 진행해주세요.',
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color(0xff59595A),
        fontSize: 12);
  }

//카페 요청하기
  Future<void> postCafeApply(FormData applyData) async {
    const storage = FlutterSecureStorage();

    Dio dio = Dio();
    Response response;
    var baseUrl = dotenv.env['BASE_URL'];

    var token = '';
    var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

    //토큰 가져오기
    if (kakaoLoginInfo != null) {
      Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
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
}
