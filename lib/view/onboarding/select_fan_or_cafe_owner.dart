import 'dart:developer';

import 'package:birca/view/onboarding/onboarding_cafe_owner.dart';
import 'package:birca/view/onboarding/select_visitor_or_host.dart';
import 'package:flutter/material.dart';
import '../../designSystem/palette.dart';
import '../../widgets/appbar.dart';

class SelectFanOrCafeOwner extends StatefulWidget {
  const SelectFanOrCafeOwner({super.key});

  @override
  State<StatefulWidget> createState() => _SelectFanOrCafeOwner();
}

class _SelectFanOrCafeOwner extends State<SelectFanOrCafeOwner> {
  @override
  void initState() {
    super.initState();
    log('온보딩 시작');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bircaAppBar(() {
          Navigator.pop(context);
        }),
        body: Container(
            margin: const EdgeInsets.only(top: 87),
            child: Center(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: '버카',
                            style: TextStyle(
                                color: Palette.primary,
                                fontSize: 30,
                                decoration: TextDecoration.none,
                                fontFamily: 'PretendardBold'),
                          ),
                          TextSpan(
                            text: '입니다!\n어떻게 오셨나요?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                decoration: TextDecoration.none,
                                fontFamily: 'PretendardMedium'),
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 99,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SelectVisitorOrHost()));
                          },
                          child: Image.asset('lib/assets/image/img_fan.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const OnboardingCafeOwner()));
                          },
                          child: Image.asset(
                              'lib/assets/image/img_cafe_owner.png')),
                    ],
                  )
                ],
              ),
            )));
  }
}