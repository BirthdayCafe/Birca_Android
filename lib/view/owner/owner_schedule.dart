import 'dart:developer';
import 'package:birca/view/owner/owner_schedule_add.dart';
import 'package:flutter/material.dart';
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
        .getSchedule(DateTime.now().year, DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '스케줄',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Pretendard',
                  color: Palette.primary),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OwnerScheduleAdd()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ))
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 13),
            child: TableCalendar(
              //오늘 날짜
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(DateTime.now().year + 1),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                    log(_selectedDay.toString());
                  });
                }
              },
              calendarStyle: const CalendarStyle(
                  // isTodayHighlighted: false,
                  selectedDecoration: BoxDecoration(
                      color: Palette.primary, shape: BoxShape.circle)),
              //달력 날짜 범위 선택
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                });
              },
            ),
          ),
          Container(
            // height: 140,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 14, right: 14, top: 19),
            padding: const EdgeInsets.only(left: 26, top: 31, bottom: 28.5),
            decoration: BoxDecoration(
              color: Palette.gray02, // Container의 배경색
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "아티스트 : 뉴진스 민지",
                  style: TextStyle(
                      color: Palette.primary,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 13.5,
                ),
                Text(
                  "닉네임 : 홍길동",
                  style: TextStyle(
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 13.5,
                ),
                Text(
                  "일정 : 2024.01.01~2024.01.01",
                  style: TextStyle(
                      color: Palette.gray10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
