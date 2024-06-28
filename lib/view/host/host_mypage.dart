import 'package:birca/view/onboarding/select_favorite_artist_screen.dart';
import 'package:birca/viewModel/mypage_view_model.dart';
import 'package:birca/widgets/bottom_nav_visitor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/visitor_cafe_home_view_model.dart';
import '../../widgets/button.dart';

class HostMyPage extends StatefulWidget {
  const HostMyPage({super.key});

  @override
  State<StatefulWidget> createState() => _HostMyPage();
}

class _HostMyPage extends State<HostMyPage> {
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
                text: '주최자',
                radiusColor: Palette.primary,
                backgroundColor: Palette.primary,
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
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Palette.gray03),
                ),
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
                const SizedBox(
                  height: 11,
                ),
                const BircaOutLinedButton(
                    text: '프로필 편집',
                    radiusColor: Palette.primary,
                    backgroundColor: Colors.white,
                    width: 100,
                    height: 33,
                    radius: 15,
                    textColor: Palette.primary,
                    textSize: 15),
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
                  color: const Color(0xffFFC656),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '방문자 전환',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pretendard',
                            color: Colors.white),
                      ),
                      Consumer<VisitorCafeHomeViewModel>(
                          builder: (context, viewModel, widget) {
                        return SizedBox(
                            height: 10,
                            child: Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: isSwitched,
                                  activeColor: const Color(0xFFFFC656),
                                  onChanged: (value) {
                                    setState(() {
                                      Provider.of<MypageViewModel>(context,
                                              listen: false)
                                          .postRoleChange('VISITANT');

                                      isSwitched = value;

                                      Provider.of<VisitorCafeHomeViewModel>(context, listen: false)
                                          .getFavoriteArtist()
                                          .then((value) async {
                                        await Provider.of<VisitorCafeHomeViewModel>(context, listen: false).getInterestArtist();

                                        if (viewModel
                                            .homeArtistsList?[0].artistId ==
                                            null) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const SelectFavoriteArtistScreen()));
                                        } else {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const BottomNavVisitor()));
                                        }

                                      }
                                      );


                                    });
                                  },
                                )));
                      }),
                    ],
                  ),
                ),
                Container(
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
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 26, right: 26),
                  width: double.infinity,
                  child: const Text(
                    '개인정보 처리 약관',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 26, right: 26),
                  width: double.infinity,
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  width: double.infinity,
                  color: Palette.gray03,
                ),
                Container(
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
