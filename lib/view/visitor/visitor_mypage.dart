import 'package:birca/designSystem/palette.dart';
import 'package:birca/view/onboarding/nickname_change.dart';
import 'package:birca/widgets/app_version.dart';
import 'package:birca/widgets/bottom_nav_host.dart';
import 'package:birca/widgets/button.dart';
import 'package:birca/widgets/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/mypage_view_model.dart';
import '../../widgets/artist_add.dart';
import '../../widgets/privacy_policy.dart';
import '../../widgets/service_policy.dart';
import '../manual/visitor_manual_1.dart';

class VisitorMyPage extends StatefulWidget {
  const VisitorMyPage({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorMyPage();
}

class _VisitorMyPage extends State<VisitorMyPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MypageViewModel>(context, listen: false).getNickName();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 자동으로 leading 버튼 생성 방지
        title: const Row(
          children: [
            Text(
              '마이 페이지',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Pretendard',
                  color: Palette.primary),
            ),
            SizedBox(
              width: 9,
            ),
            BircaOutLinedButton(
                text: '방문자',
                radiusColor: Color(0xffFEB35C),
                backgroundColor: Color(0xffFEB35C),
                width: 58,
                height: 26,
                radius: 20,
                textColor: Colors.white,
                textSize: 16)
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 13,
                ),
                Consumer<MypageViewModel>(
                    builder: (context, viewModel, widget) {
                  return Text(
                    viewModel.nickname?.nickname ?? '',
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black),
                  );
                }),
                BircaOutLinedButton(
                  text: '닉네임 수정',
                  radiusColor: Palette.primary,
                  backgroundColor: Colors.white,
                  width: 100,
                  height: 33,
                  radius: 15,
                  textColor: Palette.primary,
                  textSize: 15,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NickNameChangeScreen()));
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            // width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 26, right: 26),
                  width: double.infinity,
                  color: Palette.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '주최자 전환',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pretendard',
                            color: Colors.white),
                      ),
                      SizedBox(
                          height: 10,
                          child: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: isSwitched,
                                activeColor: Palette.primary,
                                onChanged: (value) {
                                  Provider.of<MypageViewModel>(context,
                                          listen: false)
                                      .postRoleChange('HOST');

                                  setState(() {
                                    isSwitched = value;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavHost()));
                                  });
                                },
                              )))
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '사용 매뉴얼',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VisitorManual1()),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '서비스 이용 약관',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServicePolicy()));
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '개인 정보 처리 방침',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '아티스트 요청하기',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ArtistAdd()));
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '앱 버전',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppVersion()));
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '회원 탈퇴',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Provider.of<MypageViewModel>(context, listen: false)
                        .openDeleteDialog(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 26, right: 26),
                    width: double.infinity,
                    child: const Text(
                      '문의하기',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contact()));
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
