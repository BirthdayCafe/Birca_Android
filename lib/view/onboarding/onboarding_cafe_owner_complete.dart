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
                  text: '계정 생성 요청이 정상적으로 완료되었습니다',
                  textSize: 18,
                  textColor: Palette.primary,
                  fontFamily: 'PretendardSemiBold'),
              const BircaText(
                  text: '빠르게 검토 후 알람으로 알려드릴게요 (최대 1~2일 소요)',
                  textSize: 14,
                  textColor: Color(0xff8F9093),
                  fontFamily: 'PretendardRegular'),
              const SizedBox(
                height: 158,
              ),
              SizedBox(
                  width: 300,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Palette.primary,
                    ),
                    child: const Text(
                      '계정 요청하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }
}