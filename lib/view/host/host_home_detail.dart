import 'package:birca/view/host/host_request.dart';
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
  int id = 0;

  @override
  void initState() {
    id = widget.cafeID; // cafeID를 저장할 변수
    Provider.of<HostHomeViewModel>(context, listen: false).getCafeDetail(id);
    Provider.of<HostHomeViewModel>(context, listen: false)
        .getSchedule(id,DateTime.now().year, DateTime.now().month);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _focusedDay = DateTime.now();

    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title:
        Consumer<HostHomeViewModel>(builder: (builder, viewModel, widget) {
          return  Text(
            viewModel.hostCafeHomeDetailModel?.name??'',
            style: const TextStyle(
                fontSize: 16,
                color: Palette.gray10,
                fontFamily: 'Pretandard',
                fontWeight: FontWeight.bold),
          );
        }),


          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
          actions: [
            Consumer<HostHomeViewModel>(builder: (builder, viewModel, widget) {
              if (viewModel.hostCafeHomeDetailModel == null) {
                return const CircularProgressIndicator();
              } else {
                return Container(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: GestureDetector(
                      child: viewModel.hostCafeHomeDetailModel!.liked
                          ? GestureDetector(
                              child: const Icon(
                                Icons.favorite,
                                color: Palette.primary,
                              ),
                              onTap: () {
                                Provider.of<HostHomeViewModel>(context,
                                        listen: false)
                                    .deleteLike(id);
                                viewModel.hostCafeHomeDetailModel?.liked =
                                    false;

                                viewModel.hostCafeHomeModelList
                                    ?.firstWhere((element) {
                                  if (element.cafeId == id) {
                                    element.liked = false;
                                  }
                                  return false;
                                });
                              },
                            )
                          : GestureDetector(
                              child: const Icon(
                                Icons.favorite,
                                color: Color(0xffF3F3F3),
                              ),
                              onTap: () {
                                Provider.of<HostHomeViewModel>(context,
                                        listen: false)
                                    .postLike(id);
                                viewModel.hostCafeHomeDetailModel?.liked = true;

                                viewModel.hostCafeHomeModelList
                                    ?.firstWhere((element) {
                                  if (element.cafeId == id) {
                                    element.liked = true;
                                  }
                                  return true;
                                });
                              })),
                );
              }
            })
          ],
        ),
        body: SingleChildScrollView(child:
            Consumer<HostHomeViewModel>(builder: (context, viewModel, widget) {
          if (viewModel.hostCafeHomeDetailModel == null) {
            return const CircularProgressIndicator();
          } else {
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
                      itemCount:
                          viewModel.hostCafeHomeDetailModel!.cafeImages.length,
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
                        viewModel.hostCafeHomeDetailModel?.name??'',
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
                        viewModel.hostCafeHomeDetailModel?.twitterAccount??'',
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
                          focusedDay: _focusedDay,

                          //오늘 날짜
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(DateTime.now().year + 1),

                          headerStyle: const HeaderStyle(
                              titleTextStyle: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              formatButtonVisible: false, titleCentered: false,
                              headerMargin: EdgeInsets.all(5),
                              rightChevronVisible: false,
                              leftChevronVisible:false
                          ),

                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                            viewModel.getSchedule(
                                id,focusedDay.year, focusedDay.month);
                          },
                          availableGestures: AvailableGestures.horizontalSwipe, // Enable horizontal swipe

                          calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                            for (var range in viewModel.dateRanges) {
                              if (day.isAfter(range['start']!) &&
                                  day.isBefore(range['end']!
                                      .add(const Duration(days: 1)))) {
                                return
                                  Container(
                                    margin: const EdgeInsets.all(6.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${day.day}',
                                      style: const TextStyle(color: Palette.gray03),
                                    ),);
                              }
                            }
                            return null;
                          }),
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
                            itemCount: viewModel.hostCafeHomeDetailModel
                                    ?.cafeMenus.length ??
                                0,
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
                                        '${viewModel.hostCafeHomeDetailModel?.cafeMenus[index].name}',
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
                                        '${viewModel.hostCafeHomeDetailModel?.cafeMenus[index].price}',
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
                            itemCount: viewModel.hostCafeHomeDetailModel
                                    ?.cafeOptions.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${viewModel.hostCafeHomeDetailModel?.cafeOptions[index].name}',
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
                                        '${viewModel.hostCafeHomeDetailModel?.cafeOptions[index].price}',
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
            );
          }
        })),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 21, bottom: 44),
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
                textSize: 14,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HostRequest(
                                cafeID: widget.cafeID,
                              )));
                },
              ),
              const SizedBox(
                width: 14,
              ),
              const BircaOutLinedButton(
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
