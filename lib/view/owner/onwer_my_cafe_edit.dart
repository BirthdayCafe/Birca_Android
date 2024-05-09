import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../widgets/button.dart';

class OwnerMyCafeEdit extends StatefulWidget {
  const OwnerMyCafeEdit({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMyCafeEdit();
}

class _OwnerMyCafeEdit extends State<OwnerMyCafeEdit> {
  List<String> cafeImage = [
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png'
  ];

  List<String> cafeMenu = ['menu1', 'menu2', 'menu3', 'menu4', 'menu5'];
  List<String> service = [
    'service1',
    'service2',
    'service3',
    'service4',
    'service5'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '나의 카페',
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
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '카페 이름',
                  style: TextStyle(
                      fontSize: 16,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const TextField(
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray08,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "카페 이름", border: InputBorder.none),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Palette.gray03,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '트위터 계정',
                  style: TextStyle(
                      fontSize: 16,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const TextField(
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray08,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "@twitter", border: InputBorder.none),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Palette.gray03,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '카페 위치',
                  style: TextStyle(
                      fontSize: 16,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    width: 238,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD7D8DC)),
                      borderRadius: BorderRadius.circular(2), // 테두리 굴곡 설정
                    ),
                    alignment: Alignment.center,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: '서울특별시 서대문구~', border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  BircaOutLinedButton(
                    text: '장소 선택',
                    radiusColor: Palette.primary,
                    width: 80,
                    height: 36,
                    radius: 6,
                    textColor: Palette.primary,
                    textSize: 14,
                    onPressed: () {},
                    backgroundColor: Colors.white,
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Palette.gray03,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '대여 가능 날짜',
                  style: TextStyle(
                      fontSize: 16,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  '운영 시간',
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray08,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 115,
                      height: 36,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "오전 9시",
                          focusedBorder: UnderlineInputBorder(
                            // 활성화된 상태의 밑줄 색상
                            borderSide: BorderSide(color: Palette.primary),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "부터",
                      style: TextStyle(
                          color: Palette.gray08,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 115,
                      height: 36,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "오전 9시",
                          focusedBorder: UnderlineInputBorder(
                            // 활성화된 상태의 밑줄 색상
                            borderSide: BorderSide(color: Palette.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '운영 불가능한 날짜 선택',
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const [
                        TextSpan(
                          text: '* 대여',
                          style: TextStyle(
                              color: Palette.gray08,
                              fontSize: 10,
                              decoration: TextDecoration.none,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: ' 불가능',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              decoration: TextDecoration.none,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: '한 날짜를 설정해주세요.',
                          style: TextStyle(
                              color: Palette.gray08,
                              fontSize: 10,
                              decoration: TextDecoration.none,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 19,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Palette.gray02),
                  padding: const EdgeInsets.all(6),
                  child: TableCalendar(
                    //오늘 날짜
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(DateTime.now().year + 1),

                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Palette.gray03,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '카페 메뉴',
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  '메뉴를 작성해주세요.',
                  style: TextStyle(
                      fontSize: 10,
                      color: Palette.gray08,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true, // shrinkWrap을 true로 설정
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cafeMenu.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      // height : 35,
                                      // width: 150,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: cafeMenu[index],
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            // 활성화된 상태의 밑줄 색상
                                            borderSide: BorderSide(
                                                color: Palette.primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      // height : 35,
                                      // width: 100,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: cafeMenu[index],
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            // 활성화된 상태의 밑줄 색상
                                            borderSide: BorderSide(
                                                color: Palette.gray03),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteCafeMenu(index);
                                        },
                                        icon: const Icon(
                                          Icons.highlight_remove,
                                          size: 24,
                                        ))
                                  ],
                                ));
                          }),
                      BircaOutLinedButton(
                        text: '추가하기',
                        radiusColor: Palette.gray02,
                        backgroundColor: Palette.gray02,
                        width: 260,
                        height: 40,
                        radius: 7,
                        textColor: Palette.gray08,
                        textSize: 14,
                        onPressed: () {
                          addCafeMenu();
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '데코레이션 및 추가 서비스',
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  '제공 가능한 추가 서비스를 작성해주세요.',
                  style: TextStyle(
                      fontSize: 10,
                      color: Palette.gray08,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true, // shrinkWrap을 true로 설정
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: service.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      // height : 35,
                                      // width: 150,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: service[index],
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            // 활성화된 상태의 밑줄 색상
                                            borderSide: BorderSide(
                                                color: Palette.primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: service[index],
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            // 활성화된 상태의 밑줄 색상
                                            borderSide: BorderSide(
                                                color: Palette.gray03),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteService(index);
                                        },
                                        icon: const Icon(
                                          Icons.highlight_remove,
                                          size: 24,
                                        ))
                                  ],
                                ));
                          }),
                      BircaOutLinedButton(
                        text: '추가하기',
                        radiusColor: Palette.gray02,
                        backgroundColor: Palette.gray02,
                        width: 260,
                        height: 40,
                        radius: 7,
                        textColor: Palette.gray08,
                        textSize: 14,
                        onPressed: () {
                          addService();
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: 40,
              color: Palette.gray04,
              alignment: Alignment.center,
              child: const Text(
                '저장하기',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Pretendard',
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }

  //카페 메뉴 삭제
  void deleteCafeMenu(int index) {
    setState(() {
      cafeMenu.removeAt(index);
    });
  }

  //카페 메뉴 생성
  void addCafeMenu() {
    setState(() {
      cafeMenu.add("a");
    });
  }

  //데코 및 추가 서비스 삭제
  void deleteService(int index) {
    setState(() {
      service.removeAt(index);
    });
  }

  //데코 및 추가 서비스 생성
  void addService() {
    setState(() {
      service.add("a");
    });
  }
}
