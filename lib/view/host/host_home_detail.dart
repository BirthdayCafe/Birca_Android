import 'package:birca/widgets/button.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/host_home_view_model.dart';

class HostHomeDetail extends StatefulWidget {
  final int cafeID;

  const HostHomeDetail({Key? key, required this.cafeID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostHomeDetail();
}

class _HostHomeDetail extends State<HostHomeDetail> {
  //
  @override
  void initState() {
    int id = widget.cafeID; // cafeID를 저장할 변수
    Provider.of<HostHomeViewModel>(context, listen: false).getCafeDetail(id);

    super.initState();
  }

  List<String> cafeImage = [
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png'
  ];
  //
  // List<String> cafeMenu = ['menu1', 'menu2', 'menu3', 'menu4', 'menu5'];
  // List<String> service = [
  //   'service1',
  //   'service2',
  //   'service3',
  //   'service4',
  //   'service5'
  // ];

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
          actions: const [
            // Container(
            //     padding: const EdgeInsets.only(top: 10, right: 20),
            //     child: Column(
            //       children: [
            //         GestureDetector(
            //           child: const Icon(
            //             Icons.favorite_border_outlined,
            //             color: Palette.gray03,
            //           ),
            //           onTap: () {
            //             log('touch');
            //           },
            //         ),
            //         const BircaText(
            //             text: '111',
            //             textSize: 10,
            //             textColor: Palette.gray03,
            //             fontFamily: 'Pretandard')
            //       ],
            //     ))
          ],
        ),
        body: SingleChildScrollView(child:
            Consumer<HostHomeViewModel>(builder: (context, viewModel, widget) {
          return Column(
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
                    itemCount: viewModel.hostCafeHomeDetailModel!.cafeImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        viewModel.hostCafeHomeDetailModel!.cafeImages[index],
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
                     Text(
                      '${viewModel.hostCafeHomeDetailModel?.name}',
                      style: const TextStyle(
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
                     Text(
                      '${viewModel.hostCafeHomeDetailModel?.twitterAccount}',
                      style: const TextStyle(
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
                     Text(
                      '${viewModel.hostCafeHomeDetailModel?.address}',
                      style: const TextStyle(
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
                     Text(
                      '${viewModel.hostCafeHomeDetailModel?.businessHours}',
                      style: const TextStyle(
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
                    // const Text(
                    //   '카페 메뉴',
                    //   style: TextStyle(
                    //       fontSize: 14,
                    //       color: Palette.gray10,
                    //       fontFamily: 'Pretendard',
                    //       fontWeight: FontWeight.w700),
                    // ),
                    // const SizedBox(
                    //   height: 11,
                    // ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xffF7F7FA),
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    //   child: ListView.builder(
                    //       shrinkWrap: true, // shrinkWrap을 true로 설정
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       itemCount: cafeMenu.length,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //             padding: const EdgeInsets.only(
                    //               top: 12,
                    //             ),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   cafeMenu[index],
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.w400,
                    //                       fontSize: 14,
                    //                       color: Palette.gray10),
                    //                 ),
                    //                 const Expanded(
                    //                   child: Divider(
                    //                     color: Palette.gray06,
                    //                     // 점선의 색상 설정
                    //                     height: 1,
                    //                     // 점선의 높이 설정
                    //                     thickness: 1,
                    //                     // 점선의 두께 설정
                    //                     indent: 10,
                    //                     // 시작 부분 여백 설정
                    //                     endIndent: 10, // 끝 부분 여백 설정
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   cafeMenu[index],
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 14,
                    //                       color: Palette.primary),
                    //                 ),
                    //               ],
                    //             ));
                    //       }),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Text(
                    //   '데코레이션 및 추가 서비스',
                    //   style: TextStyle(
                    //       fontSize: 14,
                    //       color: Palette.gray10,
                    //       fontFamily: 'Pretendard',
                    //       fontWeight: FontWeight.w700),
                    // ),
                    // const SizedBox(
                    //   height: 11,
                    // ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xffF7F7FA),
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    //   child: ListView.builder(
                    //       shrinkWrap: true, // shrinkWrap을 true로 설정
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       itemCount: service.length,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //             padding: const EdgeInsets.only(top: 12),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   service[index],
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.w400,
                    //                       fontSize: 14,
                    //                       color: Palette.gray10),
                    //                 ),
                    //                 const Expanded(
                    //                   child: Divider(
                    //                     color: Palette.gray06,
                    //                     // 점선의 색상 설정
                    //                     height: 1,
                    //                     // 점선의 높이 설정
                    //                     thickness: 1,
                    //                     // 점선의 두께 설정
                    //                     indent: 10,
                    //                     // 시작 부분 여백 설정
                    //                     endIndent: 10, // 끝 부분 여백 설정
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   service[index],
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 14,
                    //                       color: Palette.primary),
                    //                 ),
                    //               ],
                    //             ));
                    //       }),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1,
                    //   color: Palette.gray03,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Text(
                    //   '리뷰',
                    //   style: TextStyle(
                    //       fontSize: 14,
                    //       color: Palette.gray10,
                    //       fontFamily: 'Pretendard',
                    //       fontWeight: FontWeight.w700),
                    // ),
                  ],
                ),
              )
            ],
          );
        })),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 21, bottom: 44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BircaOutLinedButton(
                  text: '대관 요청하기',
                  radiusColor: Palette.primary,
                  backgroundColor: Palette.primary,
                  width: 160,
                  height: 44,
                  radius: 6,
                  textColor: Colors.white,
                  textSize: 14),
              SizedBox(
                width: 14,
              ),
              BircaOutLinedButton(
                  text: '전화하기',
                  radiusColor: Palette.primary,
                  backgroundColor: Colors.white,
                  width: 160,
                  height: 44,
                  radius: 6,
                  textColor: Palette.primary,
                  textSize: 14)

       

            ],
          ),
        ));
  }
}
