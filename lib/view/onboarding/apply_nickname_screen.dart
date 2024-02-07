import 'package:birca/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:birca/widgets/progressbar.dart';

import '../../designSystem/palette.dart';
import '../../widgets/button.dart';

class ApplyNickNameScreen extends StatelessWidget {
  const ApplyNickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: bircaAppBar(() {}),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      height: 6,
                      child: progressBar(1 / 3)),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text("1/3"),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "버카에서 사용할\n",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  color: Palette.gray10)),
                          TextSpan(
                              text: "닉네임",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: Palette.primary)),
                          TextSpan(
                              text: "을 등록해주세요",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  color: Palette.gray10))
                        ]),
                      )),
                  const SizedBox(height: 200),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 11),
                              height: 36,
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: '최대 10자',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.gray03),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.primary),
                                  ),
                                ),
                              ))),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: const BircaOutLinedButton(
                            text: "중복 검사",
                            radiusColor: Palette.primary,
                            width: 86,
                            height: 36,
                            radius: 6,
                            textColor: Palette.primary, textSize: 14,),
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 40),
                      width: double.infinity,
                      height: 46,
                      child: const BircaElevatedButton(
                          text: "다음으로",
                          color: Palette.gray04,
                          fontSize: 18,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w500))
                ])));
  }
}
