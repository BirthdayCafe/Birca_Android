import 'package:birca/designSystem/palette.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../viewModel/mypage_view_model.dart';
import '../manual/host_manual_1.dart';

class OnboardingHostComplete extends StatelessWidget {
  const OnboardingHostComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('lib/assets/image/img_change.svg'),
          const SizedBox(
            height: 44,
          ),
          RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: '생일 카페를 방문할 때는 ',
                    style: TextStyle(
                        color: Palette.gray06,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardBold'),
                  ),
                  TextSpan(
                    text: '마이페이지',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardMedium'),
                  ),
                  TextSpan(
                    text: '에서\n',
                    style: TextStyle(
                        color: Palette.gray06,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardBold'),
                  ),
                  TextSpan(
                    text: '방문자/주최자 모드',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardMedium'),
                  ),
                  TextSpan(
                    text: '를 변경 할 수 있습니다. ',
                    style: TextStyle(
                        color: Palette.gray06,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardBold'),
                  ),
                ]),
          ),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 300,
            child: BircaElevatedButton(
              text: '시작하기',
              color: Palette.primary,
              fontSize: 18,
              textColor: Colors.white,
              fontWeight: FontWeight.normal,
              onPressed: () async {
                await Provider.of<MypageViewModel>(context, listen: false)
                    .postRoleChange('HOST')
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HostManual1()),
                        ));
              },
            ),
          )
        ],
      ),
    ));
  }
}
