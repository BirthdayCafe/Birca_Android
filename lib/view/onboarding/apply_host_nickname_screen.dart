import 'dart:developer';
import 'package:birca/viewModel/nickname_view_model.dart';
import 'package:birca/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:birca/widgets/progressbar.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../widgets/button.dart';

class ApplyHostNickNameScreen extends StatelessWidget {
  ApplyHostNickNameScreen({super.key});

  TextEditingController nickNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: bircaAppBar(() {
              Navigator.pop(context);
            }),
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
                    child: Consumer<NickNameViewModel>(
                        builder: (context, viewModel, child) {
                          return TextField(
                            controller: nickNameController,
                            onChanged: (text) {
                              viewModel.isNickNameCheckOk = false;
                              log(viewModel.isNickNameCheckOk.toString());

                            },
                            decoration: const InputDecoration(
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
                          );
                        }))),
            Container(
              margin: const EdgeInsets.only(right: 30),
              child: BircaOutLinedButton(
                  text: "중복 검사",
                  radiusColor: Palette.primary,
                  width: 86,
                  height: 36,
                  radius: 6,
                  textColor: Palette.primary,
                  textSize: 14,
                  onPressed: () {
                    Provider.of<NickNameViewModel>(context, listen: false)
                        .nickNameCheck(nickNameController.text);
                  }),
            )
          ],
        ),
        const Expanded(child: SizedBox()),
        Container(
            margin: const EdgeInsets.only(
                left: 30, right: 30, bottom: 40),
            width: double.infinity,
            height: 46,
            child: Consumer<NickNameViewModel>(
                builder: (context, viewModel, child) {
                  return BircaElevatedButton(
                    text: "다음으로",
                    color: Palette.gray04,
                    fontSize: 18,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w500,
                    onPressed: () {

                      log('isNickNameCheckOk : ${viewModel.isNickNameCheckOk.toString()}');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //         const OnboardingHost()));
                    },
                  );
                }
            ))
            ]
        )));
  }
}
