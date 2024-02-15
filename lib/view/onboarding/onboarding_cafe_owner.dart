import 'dart:developer';

import 'package:birca/designSystem/text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String? _fileName;
  int upload = 0;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        // _filePath = result.files.single.path;
        _fileName = result.files.single.name;
        upload++;
      });
    } else {
      // 사용자가 선택을 취소한 경우
      log("파일 선택이 취소되었습니다.");
    }
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
                          if (upload < 5) {
                            _pickFile();
                          } else {
                            log('사용 횟수 종료');
                          }
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
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Palette.primary)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '사장님 이름',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Palette.primary)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '사업자등록증 번호',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Palette.primary)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '카페 주소',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Palette.primary)
                  // )
                ),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnboardingCafeOwnerComplete()));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xffBFC0C4),
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

  void showChat(BuildContext context){

    Fluttertoast.showToast(msg: '카페의 사업자등록증을 업로드하면 아래의 정보가 자동으로 기입됩니다.\n사업자 등록증은 5회까지 업로드 가능합니다.\n5회를 초과할 시 업로드 제한되니 신중하게 진행해주세요.',
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      timeInSecForIosWeb: 3,
      backgroundColor: const Color(0xff59595A),
        fontSize: 12
    );

  }
}

