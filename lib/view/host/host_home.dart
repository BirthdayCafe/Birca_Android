import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../visitor/visitor_search.dart';

class HostHome extends StatefulWidget {
  const HostHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HostHome();
  }
}

class _HostHome extends State<HostHome> {
  var isSwitched = false;
  var cafeList = ['aaa', 'bbb', 'cc', 'd', 'e', 'f', 'g' 'h', 'i', 'j'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: SvgPicture.asset('lib/assets/image/birca.svg'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VisitorSearch()));
              },
              icon: SvgPicture.asset('lib/assets/image/img_search.svg'))
        ],
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(left: 16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: '대관 가능한',
                                style: TextStyle(
                                  color: Palette.primary,
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              TextSpan(
                                text: ' 카페',
                                style: TextStyle(
                                    color: Palette.gray10,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                      ),
                      SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'lib/assets/image/img_filter.svg',
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const BircaText(
                          text: '찜',
                          textSize: 15,
                          textColor: Palette.gray06,
                          fontFamily: 'Pretendard'),
                      SizedBox(
                          height: 10,
                          child: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: isSwitched,
                                activeColor: Palette.primary,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                              )))
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 5, bottom: 5),

                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.gray06,
                      ),
                      borderRadius: BorderRadius.circular(20)), // 원하는 패딩 값 설정

                  child: const Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Palette.gray10,
                        size: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      BircaText(
                          text: '10.01(월)~10.02(화)',
                          textSize: 12,
                          textColor: Palette.gray10,
                          fontFamily: 'Pretendard')
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 5, bottom: 5),

                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.gray06,
                      ),
                      borderRadius: BorderRadius.circular(20)), // 원하는 패딩 값 설정

                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Palette.gray10,
                        size: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      BircaText(
                          text: '홍대',
                          textSize: 12,
                          textColor: Palette.gray10,
                          fontFamily: 'Pretendard')
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cafeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    // padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Container의 배경색
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // 그림자 색상
                          spreadRadius: 1, // 그림자 확산 정도
                          blurRadius: 1, // 그림자의 흐림 정도
                          // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //이미지
                        SizedBox(
                          height: 140,
                          width: 210,
                          child: Image.asset(
                            'lib/assets/image/img_cafe_test.png',
                            fit: BoxFit.fill,
                          ),
                        ),

                        //카페 정보

                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 40),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '카페 이름',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Palette.gray10,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Text(
                                '@twitter',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.gray08,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Palette.gray08,
                                    size: 12,
                                  ),
                                  Text(
                                    '서울특별시~~',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.gray08,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(child: Container()),

                        //heart
                        Container(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: const Icon(
                            Icons.favorite,
                            color: Color(0xffF3F3F3),
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
