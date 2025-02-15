import 'dart:developer';
import 'package:birca/view/owner/owner_request_detail.dart';
import 'package:birca/view/owner/owner_schedule_add.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/owner_schedule_view_model.dart';

class OwnerSchedule extends StatefulWidget {
  const OwnerSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerSchedule();
}

class _OwnerSchedule extends State<OwnerSchedule> {
  //table calendar 변수
  bool isSwitched = false;
  String hostDate = '';
  bool isDateChecked = false;
  bool isCountChecked = false;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    Provider.of<OwnerScheduleViewModel>(context, listen: false)
        .getScheduleDetail(
            DateFormat('yyyy-MM-ddT00:00:00').format(DateTime.now()));
    Provider.of<OwnerScheduleViewModel>(context, listen: false)
        .getSchedule(DateTime.now().year, DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false, // 자동으로 leading 버튼 생성 방지
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '스케줄',
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
        body: SingleChildScrollView(child: Consumer<OwnerScheduleViewModel>(
            builder: (context, viewModel, widget) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 13),
                child: TableCalendar(
                  locale: 'ko_KR',
                  // Set the locale to Korean

                  //오늘 날짜
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(DateTime.now().year - 1),
                  lastDay: DateTime.utc(DateTime.now().year + 1),
                  headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      formatButtonVisible: false,
                      titleCentered: false,
                      headerMargin: EdgeInsets.all(5),
                      rightChevronVisible: false,
                      leftChevronVisible: false),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        viewModel.getScheduleDetail(
                            DateFormat('yyyy-MM-ddT00:00:00')
                                .format(_selectedDay!));
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                    viewModel.getSchedule(_focusedDay.year, _focusedDay.month);
                  },
                  availableGestures: AvailableGestures.horizontalSwipe,
                  // Enable horizontal swipe
                  calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                    for (var range in viewModel.dateRanges) {
                      if (day.isAfter(range['start']!) &&
                          day.isBefore(
                              range['end']!.add(const Duration(days: 1)))) {
                        return Container(
                          margin: const EdgeInsets.all(6.0),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Palette.primary, shape: BoxShape.circle),
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    }
                    return null;
                  }),
                  calendarStyle: CalendarStyle(
                      // isTodayHighlighted: false,
                      selectedDecoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          shape: BoxShape.circle)),
                ),
              ),
              viewModel.isScheduleExist
                  ? GestureDetector(
                      child: Container(
                        // height: 140,
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 14, right: 14, top: 19),
                        padding: const EdgeInsets.only(
                            left: 26, top: 31, bottom: 28.5),
                        decoration: BoxDecoration(
                          color: Palette.gray02, // Container의 배경색
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "아티스트 : ${viewModel.ownerScheduleModel?.artist.groupName ?? ""} ${viewModel.ownerScheduleModel?.artist.name ?? ""}",
                              style: const TextStyle(
                                  color: Palette.primary,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              "닉네임 : ${viewModel.ownerScheduleModel?.nickname ?? ""}",
                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              "일정 : ${viewModel.ownerScheduleModel?.startDate.substring(0, 10) ?? ""} ~ ${viewModel.ownerScheduleModel?.endDate.substring(0, 10) ?? ""}",
                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (viewModel.ownerScheduleModel != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OwnerRequestDetail(
                                        cafeID: viewModel
                                            .ownerScheduleModel!.birthdayCafeId,
                                        isRequestAccept: true,
                                      )));
                        }
                      },
                    )
                  : Container(
                      // height: 140,
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 14, right: 14, top: 19),
                      padding: const EdgeInsets.only(top: 63, bottom: 63),
                      decoration: BoxDecoration(
                        color: Palette.gray02, // Container의 배경색
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "예약 정보가 없습니다.",
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )),
              const SizedBox(
                height: 5,
              ),
              viewModel.isScheduleExist
                  ? Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 14, right: 14, top: 19),
                      padding: const EdgeInsets.only(
                          left: 26, top: 15, bottom: 15, right: 26),
                      decoration: BoxDecoration(
                        color: Palette.gray02, // Container의 배경색
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '메모',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Pretendard'),
                              ),
                              BircaOutLinedButton(
                                text: '저장하기',
                                radiusColor: Palette.primary,
                                backgroundColor: Palette.primary,
                                width: 60,
                                height: 30,
                                radius: 5,
                                textColor: Colors.white,
                                textSize: 12,
                                onPressed: () {
                                  if (viewModel.nowBirthdayCafeId == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('카페가 있어야 메모할 수 있습니다.')));
                                  } else {
                                    viewModel.postMemo();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('저장 완료')));
                                  }
                                },
                              )
                            ],
                          ),
                          TextField(
                            controller: viewModel.memoController,
                            maxLength: 500,
                            maxLines: 10,
                            onChanged: (text) {
                              viewModel.updateMemo();
                              log(text);
                            },
                            decoration: InputDecoration(
                                hintText: '메모를 입력해주세요.',
                                hintStyle: const TextStyle(
                                    fontSize: 14, fontFamily: 'Pretendard'),
                                counterText:
                                    '${viewModel.memoController.text.length}/500',
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ],
                      ))
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              viewModel.isScheduleExist
                  ? BircaOutLinedButton(
                      text: '대관 취소',
                      radiusColor: Palette.gray06,
                      backgroundColor: Palette.gray06,
                      width: 60,
                      height: 30,
                      radius: 6,
                      textColor: Colors.white,
                      textSize: 12,
                      onPressed: () {
                        _openCancelDialog(
                            viewModel.ownerScheduleModel!.birthdayCafeId);
                      },
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        })),
        floatingActionButton: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Palette.primary,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OwnerScheduleAdd()));
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              )),
        ));
  }

  void _openCancelDialog(int cafeId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '카페 대관을 취소하시겠습니까?',
            style: TextStyle(
                fontSize: 16,
                color: Palette.gray10,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      await Provider.of<OwnerScheduleViewModel>(context,
                              listen: false)
                          .postCancel(cafeId).then((value) {
                        Provider.of<OwnerScheduleViewModel>(context,
                            listen: false)
                            .getSchedule(_focusedDay.year, _focusedDay.month);
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('취소 완료')));
                      Navigator.pop(context);
                    },
                    child: const Text("네",
                        style: TextStyle(
                            fontSize: 16,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("아니요",
                        style: TextStyle(
                            fontSize: 16,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500))),
              ],
            )
          ],
        );
      },
    );
  }
}
