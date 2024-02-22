import 'package:birca/designSystem/palette.dart';
import 'package:birca/designSystem/text.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';

class OnboardingFanComplete extends StatelessWidget{
  const OnboardingFanComplete({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          alignment: Alignment.center,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/image/img_logo.png'),
            
            const BircaText(text: '마이페이지에서 방문자/주최자 모드를 변경할 수 있습니다.', textSize: 20, textColor: Palette.gray10, fontFamily: 'Pretendard-Bold'),
            const BircaFilledButton(text: '시작하기', color: Palette.primary, width: 100, height: 40,)
          ],
        ),
        )


    );
  }

}