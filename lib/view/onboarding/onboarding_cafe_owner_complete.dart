import 'package:birca/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';

class OnboardingCafeOwnerComplete extends StatelessWidget {
  const OnboardingCafeOwnerComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const BircaText(
                  text: '곧 버카에서 만나요!',
                  textSize: 20,
                  textColor: Palette.primary,
                  fontFamily: 'PretendardBold'),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset('lib/assets/image/img_complete.svg'),
              const SizedBox(
                height: 70,
              ),
              const BircaText(
                  text: '계정 생성 요청이 정상적으로 완료되었습니다.',
                  textSize: 18,
                  textColor: Palette.primary,
                  fontFamily: 'PretendardSemiBold'),
              const BircaText(
                  text: '빠르게 검토 후 승인 해드리겠습니다. (최대 1~2일 소요)',
                  textSize: 14,
                  textColor: Color(0xff8F9093),
                  fontFamily: 'PretendardRegular'),
              const BircaText(
                  text: '궁금한 사항은 010-6642-8846이나',
                  textSize: 14,
                  textColor: Color(0xff8F9093),
                  fontFamily: 'PretendardRegular'),
              const BircaText(
                  text: 'tmdrbs8846@gmail.com으로 연락주세요!',
                  textSize: 14,
                  textColor: Color(0xff8F9093),
                  fontFamily: 'PretendardRegular'),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                  width: 300,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Login()));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Palette.primary,
                    ),
                    child: const Text(
                      '완료하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }
}