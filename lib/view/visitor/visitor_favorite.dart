import 'package:birca/designSystem/text.dart';
import 'package:flutter/material.dart';

import '../../designSystem/palette.dart';

class VisitorFavorite extends StatefulWidget {
  const VisitorFavorite({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorFavorite();
}

class _VisitorFavorite extends State<VisitorFavorite> {
  bool isFavoriteExist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false, // 타이틀 왼쪽 정렬 설정
          scrolledUnderElevation: 0,
          title: RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: '찜',
                    style: TextStyle(
                        color: Palette.primary,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '한 생일카페',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardMedium'),
                  ),
                ]),
          ),
        ),
        body: isFavoriteExist
            ? Container(
                width: double.infinity, // 화면 전체 너비
                height: double.infinity, // 화면 전체 높이
                color: const Color(0xffF7F7FA),
                child: Container(
                    margin: const EdgeInsets.only(top: 23, left: 20, right: 20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 그리드 열의 수
                              crossAxisSpacing: 12.0, // 열 간의 간격
                              mainAxisSpacing: 24.0, // 행 간의 간격
                              childAspectRatio: 0.79),
                      itemCount: 20, // 그리드에 표시할 전체 아이템 수

                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 180,
                          height: 415,
                          margin: const EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            color: Colors.white, // Container의 배경색
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1), // 그림자 색상
                                spreadRadius: 1, // 그림자 확산 정도
                                blurRadius: 1, // 그림자의 흐림 정도
                                // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'lib/assets/image/img_cafe_test.png',
                                      fit: BoxFit.cover,
                                      height: 126,
                                      width: 180,
                                    ),
                                    Positioned(
                                        top: 1,
                                        right: 1,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Palette.primary,
                                          ),
                                          onPressed: () {},
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '샤이니 민호',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Pretendard'),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    BircaText(
                                        text: '1월1일 ~ 1월3일',
                                        textSize: 12,
                                        textColor: Palette.gray10,
                                        fontFamily: 'Pretendard'),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        BircaText(
                                            text: '카페 이름',
                                            textSize: 12,
                                            textColor: Palette.gray06,
                                            fontFamily: 'Pretendard'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        BircaText(
                                            text: '트위터',
                                            textSize: 12,
                                            textColor: Palette.gray06,
                                            fontFamily: 'Pretendard')
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )))
            : Container(
                width: double.infinity, // 화면 전체 너비
                height: double.infinity, // 화면 전체 높이
                color: const Color(0xffF7F7FA),

                child: Container(
                  alignment: Alignment.center,
                  child: const BircaText(
                      text: '현재 찜한 카페가 없습니다',
                      textSize: 16,
                      textColor: Palette.gray06,
                      fontFamily: 'Pretendard'),
                ),
              ));
  }
}
