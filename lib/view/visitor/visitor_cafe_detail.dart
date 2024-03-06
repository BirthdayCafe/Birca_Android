import 'dart:developer';
import 'package:birca/designSystem/palette.dart';
import 'package:birca/designSystem/text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisitorCafeDetail extends StatefulWidget {
  const VisitorCafeDetail({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorCafeDetail();
}

class _VisitorCafeDetail extends State<VisitorCafeDetail> {
  List<String> cafeImage = [
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png'
  ];

  List<String> cafeDetailImage = [
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png'
  ];

  List<String> goods = [
    '특전1',
    '특전2',
        '특전3',
        '특전4',
        '특전5'

  ];

  List<String> luckyDraw = [
    '럭키1',
    '럭키2',
    '럭키3',
    '럭키4',
    '럭키5'

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '생일 카페 이름',
          style: TextStyle(
              fontSize: 16,
              color: Palette.gray10,
              fontFamily: 'Pretandard',
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
        actions: [
          Container(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: Column(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.favorite_border_outlined,
                      color: Palette.gray03,
                    ),
                    onTap: () {
                      log('touch');
                    },
                  ),
                  const BircaText(
                      text: '111',
                      textSize: 10,
                      textColor: Palette.gray03,
                      fontFamily: 'Pretandard')
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '아티스트',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '샤이니 민호',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    '날짜 및 운영 시간',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '2024.02.01 ~ 2024.02.01',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '12:00 ~ 18:00',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    '카페 이름',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '스벅',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '서울 특별시 서대문구 ~',
                    style: TextStyle(
                        color: Palette.gray06,
                        fontFamily: 'Pretendard',
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(1),
                height: 412,
                width: MediaQuery.of(context).size.width,
                child: Swiper(
                  scrollDirection: Axis.horizontal,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                  ),
                  autoplay: false,
                  itemCount: cafeImage.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      cafeImage[index],
                      fit: BoxFit.cover,
                    );
                  },
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '트위터 계정',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      const Text(
                        '@twitter',
                        style: TextStyle(
                            color: Palette.gray08,
                            fontFamily: 'Pretendard',
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 34,
                          height: 18,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Palette.gray06,
                                padding: EdgeInsets.zero,
                                //
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(3.0), // 테두리 둥글기
                                ),
                                elevation: 0
                                // 텍스트 색상
                                ),
                            child: const Text(
                              '복사',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    '실시간 혼잡도 및 특전',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 16,right: 16),
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xffF7F7FA),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BircaText(
                            text: '혼잡도',
                            textSize: 14,
                            textColor: Palette.gray10,
                            fontFamily: 'Pretendard'),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Palette.primary,
                          ),
                          child: const Text(
                            '포화',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard'),
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        const BircaText(
                            text: '특전',
                            textSize: 14,
                            textColor: Palette.gray10,
                            fontFamily: 'Pretendard'),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Palette.primary,
                          ),
                          child: const Text(
                            '재고 없음',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    '사진',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                      height: 90,
                      child: ListView.builder(
                          shrinkWrap: true, // shrinkWrap을 true로 설정

                          scrollDirection: Axis.horizontal,
                          itemCount: cafeDetailImage.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(cafeDetailImage[index]),
                            );
                          })),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    '특전 구성',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  const SizedBox(height: 16,),
                  ListView.builder(
                      shrinkWrap: true, // shrinkWrap을 true로 설정

                      physics: const NeverScrollableScrollPhysics(),
                    itemCount: goods.length,
                      itemBuilder: (context, index){
                        return Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                  goods[index]  ,style: const TextStyle(
                                color: Palette.primary,
                                fontSize: 14,
                                  fontWeight: FontWeight.w600
                                
                              ),
                            )
                            ),
                            Text(goods[index],style: const TextStyle(
                              color: Palette.gray10,
                              fontSize: 14,

                            ),)

                          ],
                        );
                      }),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    '럭키 드로우',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        fontSize: 16),
                  ),
                  const SizedBox(height: 16,),
                  ListView.builder(
                      shrinkWrap: true, // shrinkWrap을 true로 설정

                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: luckyDraw.length,
                      itemBuilder: (context, index){
                        return Row(
                          children: [
                            SizedBox(
                                width: 90,
                                child: Text(
                                  luckyDraw[index]  ,style: const TextStyle(
                                    color: Palette.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600

                                ),
                                )
                            ),
                            Text(luckyDraw[index],style: const TextStyle(
                              color: Palette.gray10,
                              fontSize: 14,

                            ),)

                          ],
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
