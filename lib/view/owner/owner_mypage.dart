import 'package:birca/view/owner/owner_my_cafe.dart';
import 'package:birca/widgets/privacy_policy.dart';
import 'package:birca/widgets/service_policy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/mypage_view_model.dart';
import '../../widgets/app_version.dart';
import '../../widgets/artist_add.dart';
import '../../widgets/contact.dart';
import '../manual/owner_manual_1.dart';

class OwnerMypage extends StatefulWidget {
  const OwnerMypage({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMypage();
}

class _OwnerMypage extends State<OwnerMypage> {
  @override
  void initState() {
    super.initState();

  }

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
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   width: 100,
                //   height: 100,
                //   decoration: const BoxDecoration(
                //       shape: BoxShape.circle, color: Palette.gray03),
                // ),
                // const SizedBox(
                //   height: 13,
                // ),
                // Consumer<MypageViewModel>(builder: (context,viewModel,widget){
                //   return Text(
                //     '${viewModel.nickname?.nickname}',
                //     style: const TextStyle(
                //         fontFamily: 'Pretendard',
                //         fontWeight: FontWeight.w600,
                //         fontSize: 20,
                //         color: Colors.black),
                //   );
                // }) ,
                // const SizedBox(
                //   height: 11,
                // ),
                // BircaOutLinedButton(
                //   text: '프로필 편집',
                //   radiusColor: Palette.primary,
                //   backgroundColor: Colors.white,
                //   width: 100,
                //   height: 33,
                //   radius: 15,
                //   textColor: Palette.primary,
                //   textSize: 15,
                //   onPressed: () {
                //     showDialog(
                //         context: context, builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: SvgPicture.asset('lib/assets/image/birca.svg'),
                //         contentPadding: const EdgeInsets.all(14,),
                //           backgroundColor: Colors.white,
                //           alignment: Alignment.center,
                //            content:
                //                const TextField(
                //                  style: TextStyle(
                //                    fontWeight: FontWeight.w500,
                //                      fontFamily: 'Pretendard',
                //                      fontSize: 20,
                //                      color: Colors.black,
                //
                //                  ),
                //
                //            ),
                //         actions: [
                //           Row(
                //             children: [
                //               BircaOutLinedButton(
                //                 text: '취소',
                //                 radiusColor: Palette.gray03,
                //                 backgroundColor: Colors.white,
                //                 width: 120,
                //                 height: 30,
                //                 radius: 6,
                //                 textColor: Colors.black,
                //                 textSize: 20,
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },),
                //               const SizedBox(width: 10,),
                //               BircaOutLinedButton(text: '저장',
                //                 radiusColor: Palette.primary,
                //                 backgroundColor: Palette.primary,
                //                 width: 120,
                //                 height: 30,
                //                 radius: 6,
                //                 textColor: Colors.white,
                //                 textSize: 20,
                //                 onPressed: (){},)
                //
                //             ],
                //           )
                //         ],
                //       );
                //     });
                //   },)
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
                    child: GestureDetector(
                      child: const Text(
                        '내 카페',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                            color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OwnerMyCafe()));
                      },
                    )),

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
                      MaterialPageRoute(builder: (context) => const OwnerManual1()),
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
