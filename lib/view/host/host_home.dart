import 'package:birca/view/host/host_home_detail.dart';
import 'package:birca/view/host/host_search.dart';
import 'package:birca/viewModel/host_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../../widgets/button.dart';

class HostHome extends StatefulWidget {
  const HostHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HostHome();
  }
}

class _HostHome extends State<HostHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<HostHomeViewModel>(context, listen: false)
        .getHostHome(0, 10, "", false, "", "");
  }

  var isSwitched = false;
  String hostDate = '';

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {

    hostDate =
        '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}~${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}';

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 자동으로 leading 버튼 생성 방지
          scrolledUnderElevation: 0,
          title: SvgPicture.asset('lib/assets/image/birca.svg'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HostSearch()));
                },
                icon: SvgPicture.asset('lib/assets/image/img_search.svg'))
          ],
        ),
        body: SingleChildScrollView(child:
            Consumer<HostHomeViewModel>(builder: (context, viewModel, widget) {
          if (viewModel.hostCafeHomeModelList == null) {
            return const CircularProgressIndicator();
          } else {
            return Column(
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

                                      if (isSwitched) {
                                        if (_rangeStart == null &&
                                            _rangeEnd == null) {
                                          viewModel.getHostHome(
                                              0, 10, "", isSwitched, '', '');
                                        } else {
                                          viewModel.getHostHome(
                                              0,
                                              10,
                                              "",
                                              isSwitched,
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(_rangeStart!),
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(_rangeEnd!));
                                        }
                                      } else {
                                        if (_rangeStart == null &&
                                            _rangeEnd == null) {
                                          viewModel.getHostHome(
                                              0, 10, "", isSwitched, '', '');
                                        } else {
                                          viewModel.getHostHome(
                                              0,
                                              10,
                                              "",
                                              isSwitched,
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(_rangeStart!),
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(_rangeEnd!));
                                        }
                                      }
                                    },
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<HostHomeViewModel>(
                    builder: (builder, viewModel, widget) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Palette.gray06,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: Palette.gray10,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              BircaText(
                                  text: hostDate,
                                  textSize: 12,
                                  textColor: Palette.gray10,
                                  fontFamily: 'Pretendard')
                            ],
                          ),
                        ),
                        onTap: () {
                          _showBottomDialogCalendar(context);
                        },
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
                            borderRadius: BorderRadius.circular(20)),
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
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                Consumer<HostHomeViewModel>(
                    builder: (builder, viewModel, widget) {
                  if (viewModel.hostCafeHomeModelList == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: viewModel.hostCafeHomeModelList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white, // Container의 배경색
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    // 그림자 색상
                                    spreadRadius: 1,
                                    // 그림자 확산 정도
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
                                    child: Image.network(
                                      viewModel.hostCafeHomeModelList![index]
                                          .cafeImageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                  //카페 정보

                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${viewModel.hostCafeHomeModelList?[index].name}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Palette.gray10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 21,
                                        ),
                                        Text(
                                          '${viewModel.hostCafeHomeModelList?[index].twitterAccount}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Palette.gray08,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Palette.gray08,
                                              size: 12,
                                            ),
                                            Text(
                                              '${viewModel.hostCafeHomeModelList?[index].address.substring(0, 10)}',
                                              style: const TextStyle(
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
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 8),
                                      child: viewModel
                                              .hostCafeHomeModelList![index]
                                              .liked
                                          ? GestureDetector(
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Palette.primary,
                                              ),
                                              onTap: () {
                                                Provider.of<HostHomeViewModel>(
                                                        context,
                                                        listen: false)
                                                    .deleteLike(viewModel
                                                        .hostCafeHomeModelList![
                                                            index]
                                                        .cafeId)
                                                    .then((value) => viewModel
                                                        .hostCafeHomeModelList?[
                                                            index]
                                                        .liked = false);
                                              },
                                            )
                                          : GestureDetector(
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Color(0xffF3F3F3),
                                              ),
                                              onTap: () async {
                                                Provider.of<HostHomeViewModel>(
                                                        context,
                                                        listen: false)
                                                    .postLike(viewModel
                                                        .hostCafeHomeModelList![
                                                            index]
                                                        .cafeId)
                                                    .then((value) => viewModel
                                                        .hostCafeHomeModelList?[
                                                            index]
                                                        .liked = true);
                                              }))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HostHomeDetail(
                                          cafeID: viewModel
                                              .hostCafeHomeModelList![index]
                                              .cafeId)));
                            },
                          );
                        });
                  }
                }),
              ],
            );
          }
        })),
        floatingActionButton: SizedBox(
          width: 86,
          height: 38,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.white, width: 2.0), // 테두리 설정
            ), // 버튼 배경색
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BircaText(
                    text: '지도',
                    textSize: 16,
                    textColor: Colors.white,
                    fontFamily: 'Pretendard'),
                Icon(
                  Icons.location_on_outlined,
                  size: 24,
                  color: Colors.white,
                )
              ],
            ), // 버튼 모양
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  void _showBottomDialogCalendar(BuildContext context) async {
    var hostDate1 = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 13),
                  child: TableCalendar(
                    //오늘 날짜
                    focusedDay: _focusedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(DateTime.now().year + 1),

                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),

                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    rangeSelectionMode: _rangeSelectionMode,

                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },

                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay =
                              focusedDay; // update `_focusedDay` here as well
                          _rangeStart = null; // Important to clean those
                          _rangeEnd = null;
                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                        });
                      }
                    },

                    //달력 날짜 범위 선택
                    onRangeSelected: (start, end, focusedDay) {
                      setState(() {
                        _selectedDay = null;
                        _focusedDay = focusedDay;
                        _rangeStart = start;
                        _rangeEnd = end;
                        _rangeSelectionMode = RangeSelectionMode.toggledOn;
                        // print('start : $_rangeStart / end : $_rangeEnd ');
                      });
                    },
                  ),
                ),
                BircaFilledButton(
                  text: '적용하기',
                  color: Palette.primary,
                  width: 300,
                  height: 46,
                  onPressed: () async {
                    _rangeEnd ??= _rangeStart;
                    setState(() {
                      hostDate =
                          '${_rangeStart?.year}.${_rangeStart?.month}.${_rangeStart?.day}~${_rangeEnd?.year}.${_rangeEnd?.month}.${_rangeEnd?.day}';
                      // print(hostDate);
                    });
                    await Provider.of<HostHomeViewModel>(context, listen: false)
                        .getHostHome(
                            0,
                            10,
                            "",
                            isSwitched,
                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(_rangeStart!),
                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(_rangeEnd!))
                        .then((value) => Navigator.of(context).pop(hostDate));
                  },
                ),
              ],
            );
          });
        });

    if (hostDate1 != null) {
      setState(() {
        hostDate = hostDate1;
      });
    }
  }
}
