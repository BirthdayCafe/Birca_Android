import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import 'host_chatting.dart';
import 'host_home.dart';
import 'host_mypage.dart';
import 'host_schedule.dart';

class HostCafeDetail extends StatefulWidget {
  const HostCafeDetail({super.key});

  @override
  State<StatefulWidget> createState() => _HostCafeDetail();
}

class _HostCafeDetail extends State<HostCafeDetail> {
  int _selectedIndex = 0;

  bool isTab = false;

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

  final List<Widget> _widgetOptions = <Widget>[
    const HostHome(),
    const HostChatting(),
    const HostSchedule(),
    const HostMyPage()
  ];

  void _onItemTapped(int index) {
    // 탭을 클릭했을때 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
      isTab = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '카페 이름',
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
      body: isTab
          ? _widgetOptions.elementAt(_selectedIndex)
          : SingleChildScrollView(
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
                            fontSize: 18,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
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
                        '트위터 계정',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        '@gggggg',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray08,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400),
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
                        '카페 위치',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        '서울특별시~~',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray08,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400),
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
                        '운영 시간 및 날짜',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        '10:00~18:00',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray08,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400),
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
                        '예약 스케줄',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        '* 회색 날짜는 이미 예약이 완료된 날짜입니다',
                        style: TextStyle(
                            fontSize: 10,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
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
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7FA),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView.builder(
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
                                      Text(
                                        cafeMenu[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Palette.gray10),
                                      ),
                                      const Expanded(
                                        child: Divider(
                                          color: Palette.gray06,
                                          // 점선의 색상 설정
                                          height: 1,
                                          // 점선의 높이 설정
                                          thickness: 1,
                                          // 점선의 두께 설정
                                          indent: 10,
                                          // 시작 부분 여백 설정
                                          endIndent: 10, // 끝 부분 여백 설정
                                        ),
                                      ),
                                      Text(
                                        cafeMenu[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Palette.primary),
                                      ),
                                    ],
                                  ));
                            }),
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
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7FA),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true, // shrinkWrap을 true로 설정
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: service.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        service[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Palette.gray10),
                                      ),
                                      const Expanded(
                                        child: Divider(
                                          color: Palette.gray06,
                                          // 점선의 색상 설정
                                          height: 1,
                                          // 점선의 높이 설정
                                          thickness: 1,
                                          // 점선의 두께 설정
                                          indent: 10,
                                          // 시작 부분 여백 설정
                                          endIndent: 10, // 끝 부분 여백 설정
                                        ),
                                      ),
                                      Text(
                                        service[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Palette.primary),
                                      ),
                                    ],
                                  ));
                            }),
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
                        '리뷰',
                        style: TextStyle(
                            fontSize: 14,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // 애니메이션 비활성화

        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 30,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, size: 30), label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined, size: 30),
              label: '스케줄'),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity, size: 30), label: '마이페이지'),
        ],

        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_cafe_tour.svg') ,label:'카페 투어' ),
        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_mypage.svg') ,label:'마이페이지' ),],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.primary,
      ),
    );
  }
}
