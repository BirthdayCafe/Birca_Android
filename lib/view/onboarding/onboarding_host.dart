import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';

class OnboardingHost extends StatefulWidget {
  const OnboardingHost({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingHost();
}

class _OnboardingHost extends State<OnboardingHost> {
  bool isDateChecked = false;
  bool isCountChecked = false;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  String hostDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bircaAppBar(() {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: '어떤 생일 카페를\n',
                        style: TextStyle(
                            color: Palette.gray10,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                      TextSpan(
                        text: '준비',
                        style: TextStyle(
                            color: Palette.primary,
                            fontSize: 30,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardBold'),
                      ),
                      TextSpan(
                        text: '하고 있나요?',
                        style: TextStyle(
                            color: Palette.gray10,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 46,
              ),
              const Row(
                children: [
                  BircaText(
                      text: '아티스트',
                      textSize: 16,
                      textColor: Palette.gray10,
                      fontFamily: 'PretendardMedium'),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xffFE2E2E)),
                  )
                ],
              ),
              SizedBox(
                width: 332,
                child: TextField(
                  decoration: InputDecoration(
                      //비활성화
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD7D8DC))),
                      hintText: '아티스트',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      )
                      //활성화
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Palette.primary)
                      // )
                      ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              const BircaText(
                  text: '생일카페 주최 일정',
                  textSize: 16,
                  textColor: Palette.gray10,
                  fontFamily: 'PretendardMedium'),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Container(
                  width: 238,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD7D8DC)),
                    borderRadius: BorderRadius.circular(2), // 테두리 굴곡 설정
                  ),
                  child:  Text(hostDate),
                ),
                const SizedBox(
                  width: 11,
                ),
                BircaOutLinedButton(
                    text: '날짜 선택',
                    radiusColor: Palette.primary,
                    width: 80,
                    height: 36,
                    radius: 6,
                    textColor: Palette.primary,
                    textSize: 14,
                    onPressed: () {
                      _showBottomDialogCalendar(context);
                    })
              ]),
              Row(
                children: [
                  Checkbox(
                    value: isDateChecked,
                    side: const BorderSide(color: Color(0xffD7D8DC)),
                    onChanged: (bool? value) {
                      setState(() {
                        isDateChecked = value ?? false;
                      });
                    },
                  ),
                  const BircaText(
                      text: '날짜 미정',
                      textSize: 12,
                      textColor: Color(0xff8f9093),
                      fontFamily: 'PretendardRegular')
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              const BircaText(
                  text: '예상 방문자 수',
                  textSize: 16,
                  textColor: Palette.gray10,
                  fontFamily: 'PretendardMedium'),
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  BircaText(
                      text: '최소',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'PretendardLight'),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,

                        contentPadding: EdgeInsets.zero,
                        //비활성화
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD7D8DC))),
                        hintText: '',

                        //활성화
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Palette.primary)
                        // )
                      ),
                    ),
                  ),
                  BircaText(
                      text: '명, ',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'PretendardLight'),
                  BircaText(
                      text: '최대',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'PretendardLight'),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,

                        //비활성화
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffD7D8DC),
                          ),
                        ),

                        hintText: '',

                        //활성화
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Palette.primary)
                        // )
                      ),
                    ),
                  ),
                  BircaText(
                      text: '명',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'PretendardLight'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isCountChecked,
                    side: const BorderSide(color: Color(0xffD7D8DC)),
                    onChanged: (bool? value) {
                      setState(() {
                        isCountChecked = value ?? false;
                      });
                    },
                  ),
                  const BircaText(
                      text: '예상 방문자 수 미정',
                      textSize: 12,
                      textColor: Color(0xff8f9093),
                      fontFamily: 'PretendardRegular')
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              const BircaText(
                  text: '생일카페 트위터 계정',
                  textSize: 16,
                  textColor: Palette.gray10,
                  fontFamily: 'PretendardMedium'),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 200,
                child: TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.alternate_email),
                    prefixIconColor: Color(0xff8f9093),
                    prefixIconConstraints: BoxConstraints(),
                    //비활성화
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD7D8DC))),

                    //활성화
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Palette.primary)
                    // )
                  ),
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              Container(
                  alignment: Alignment.center,
                  child: const BircaFilledButton(
                      text: '버카 시작하기',
                      color: Color(0xffbfc0c4),
                      width: 300,
                      height: 46)),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomDialogCalendar(BuildContext context) {
    // var calendarFormat = CalendarFormat.month;
    // DateTime? _selectedDay;
    // DateTime _focusedDay = DateTime.now();
    // DateTime? _rangeStart;
    // DateTime? _rangeEnd;
    // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            //
            return Container(
              child: Column(
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
                            _focusedDay = focusedDay; // update `_focusedDay` here as well
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
                         print('start : $_rangeStart / end : $_rangeEnd ');



                        });
                      },
                    ),
                  ),
                  BircaFilledButton(
                    text: '적용하기',
                    color: const Color(0xffBFC0C4),
                    width: 300,
                    height: 46,
                    onPressed: () {


                      //날짜를 하나만 선택 했을 시
                      _rangeEnd ??= _rangeStart;
                      setState((){
                        hostDate = '$_rangeStart ~ $_rangeEnd';
                        print('object');


                        print('object');
                      });

                        Navigator.pop(context);

                    },
                  ),
                ],
              ),
            );
          });
        });
  }
}
