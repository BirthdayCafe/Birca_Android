import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../designSystem/palette.dart';
import '../../widgets/button.dart';

class OwnerMypage extends StatefulWidget {
  const OwnerMypage({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMypage();
}

class _OwnerMypage extends State<OwnerMypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                const Text(
                  '홍길동',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 11,
                ),
                BircaOutLinedButton(
                  text: '프로필 편집',
                  radiusColor: Palette.primary,
                  backgroundColor: Colors.white,
                  width: 100,
                  height: 33,
                  radius: 15,
                  textColor: Palette.primary,
                  textSize: 15,
                  onPressed: () {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: SvgPicture.asset('lib/assets/image/birca.svg'),
                        contentPadding: const EdgeInsets.all(14,),
                          backgroundColor: Colors.white,
                          alignment: Alignment.center,
                           content:
                               const TextField(
                                 style: TextStyle(
                                   fontWeight: FontWeight.w500,
                                     fontFamily: 'Pretendard',
                                     fontSize: 20,
                                     color: Colors.black,

                                 ),

                           ),
                        actions: [
                          Row(
                            children: [
                              BircaOutLinedButton(
                                text: '취소',
                                radiusColor: Palette.gray03,
                                backgroundColor: Colors.white,
                                width: 120,
                                height: 30,
                                radius: 6,
                                textColor: Colors.black,
                                textSize: 20,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },),
                              const SizedBox(width: 10,),
                              BircaOutLinedButton(text: '저장',
                                radiusColor: Palette.primary,
                                backgroundColor: Palette.primary,
                                width: 120,
                                height: 30,
                                radius: 6,
                                textColor: Colors.white,
                                textSize: 20,
                                onPressed: (){},)

                            ],
                          )
                        ],
                      );
                    });
                  },)
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
                  child: const Text(
                    '내 카페',
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
                  child: GestureDetector(
                    child: const Text(
                      '로그아웃',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          color: Colors.black),
                    ),
                    onTap: (){
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: SvgPicture.asset('lib/assets/image/birca.svg'),
                          contentPadding: const EdgeInsets.all(14,),
                          backgroundColor: Colors.white,
                          alignment: Alignment.center,
                          content:
                          const Text('로그아웃 하시겠습니까?', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                            fontSize: 20,
                            color: Colors.black,
                          ),

                          ),
                          actions: [
                            Row(
                              children: [
                                BircaOutLinedButton(
                                  text: '아니요',
                                  radiusColor: Palette.gray03,
                                  backgroundColor: Colors.white,
                                  width: 120,
                                  height: 30,
                                  radius: 6,
                                  textColor: Colors.black,
                                  textSize: 20,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },),
                                const SizedBox(width: 10,),
                                BircaOutLinedButton(text: '로그아웃',
                                  radiusColor: Palette.primary,
                                  backgroundColor: Palette.primary,
                                  width: 120,
                                  height: 30,
                                  radius: 6,
                                  textColor: Colors.white,
                                  textSize: 20,
                                  onPressed: (){},)

                              ],
                            )
                          ],
                        );
                      });
                    },
                  )
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
