import 'package:birca/designSystem/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../designSystem/palette.dart';

class VisitorHome extends StatefulWidget {
  const VisitorHome({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorHome();
}

class _VisitorHome extends State<VisitorHome> {
  var artistList = ['aaa', 'bbb', 'cc', 'd', 'e', 'f', 'g' 'h', 'i', 'j'];
  var cafeList = ['aaa', 'bbb', 'cc', 'd', 'e', 'f', 'g' 'h', 'i', 'j'];

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: SvgPicture.asset('lib/assets/image/birca.svg'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('lib/assets/image/img_search.svg'))
          ],
        ),
        body: SingleChildScrollView(
            // padding: EdgeInsets.only(left: 16),

            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: '아티스트',
                        style: TextStyle(
                            color: Palette.primary,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' 목록',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true, // shrinkWrap을 true로 설정
                itemCount: artistList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Image.asset('lib/assets/image/img_artist_test.png'),
                          Text(artistList[index])
                        ],
                      ));
                },
              ),
            ),
            Container(
              height: 8,
              color: Palette.gray02,
            ),
            const SizedBox(
              height: 12,
            ),
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
                                text: '전체',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              TextSpan(
                                text: ' 생일 카페',
                                style: TextStyle(
                                    color: Palette.primary,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                              'lib/assets/image/img_filter.svg')),
                    ],
                  ),
                  Row(
                    children: [
                      const BircaText(
                          text: '실시간',
                          textSize: 15,
                          textColor: Palette.gray06,
                          fontFamily: 'Pretendard'),
                      SizedBox(
                          height: 10,
                          child:

                          Transform.scale(

                            scale: 0.7,
                              child: CupertinoSwitch(

                                value: isSwitched,
                                activeColor: Palette.primary,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                              )
                          )


                              )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Container의 배경색
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 그림자 색상
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
                          width: 140,
                          child:
                              Image.asset('lib/assets/image/img_cafe_test.png'),
                        ),

                        //카페 정보
                        Container(
                          height: 140,
                          margin: const EdgeInsets.only(left: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              // Text('샤이니 민호'),
                              const BircaText(
                                  text: '샤이니 민호',
                                  textSize: 12,
                                  textColor: Palette.gray08,
                                  fontFamily: 'Pretendard'),

                              // Text('1월 1일~1월 2일'),
                              const BircaText(
                                text: '1월 1일~1월 2일',
                                textSize: 12,
                                textColor: Palette.gray08,
                                fontFamily: 'Pretendard',
                              ),
                              // Text('카페 이름'),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'cafe name',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),

                              Expanded(child: Container()),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Palette.gray08,
                                    size: 20,
                                  ),
                                  Text(
                                    '서울 서초구 서초대로',
                                    style: TextStyle(
                                      color: Palette.gray08,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.solid, // 밑줄의 스타일
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        Expanded(child: Container()),

                        //heart
                        const Icon(
                          Icons.favorite,
                          color: Color(0xffF3F3F3),
                        )
                      ],
                    ),
                  );
                })
          ],
        )));
  }
}
