import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../../widgets/button.dart';

class HostCafeEdit extends StatefulWidget {
  const HostCafeEdit({super.key});

  @override
  State<StatefulWidget> createState() => _HostCafeEdit();
}

class _HostCafeEdit extends State<HostCafeEdit> {
  bool isSwitched = false;
  String hostDate = '';
  bool isDateChecked = false;
  bool isCountChecked = false;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<String> cafeDetailImage = [
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png',
    'lib/assets/image/img_cafe_test.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '나의 생일 카페',
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
            const SizedBox(
              height: 33,
            ),
            Image.asset(
              'lib/assets/image/img_cafe_test.png',
              height: 412,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20, right: 17, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '카페 이름',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
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
                              },
                            ))),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: Palette.gray03,
              height: 1,
              margin: const EdgeInsets.only(left: 14, right: 14),
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                '실시간 혼잡도 및 특전',
                style: TextStyle(
                    color: Palette.gray10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
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
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '카페 이름',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '아티스트 및 그룹명',
                      border: UnderlineInputBorder(), // 밑줄 추가
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '주최자 정보',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '트위터 계정',
                      border: UnderlineInputBorder(), // 밑줄 추가
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '생일 카페 주최 일정',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
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
                      child: Text(
                        hostDate,
                      ),
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
                      },
                      backgroundColor: Colors.white,
                    )
                  ]),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '카페 위치',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '서울 특별시~~',
                      border: UnderlineInputBorder(), // 밑줄 추가
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '특전 구성',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const Text(
                    '* 특전 종류와 구성품을 작성해주세요.',
                    style: TextStyle(
                        color: Palette.gray08,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '생일 카페 메뉴',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const Text(
                    '* 메뉴 구성을 작성해주세요.',
                    style: TextStyle(
                        color: Palette.gray08,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '럭키 드로우',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const Text(
                    '* 럭키드로우 구성을 작성해주세요.',
                    style: TextStyle(
                        color: Palette.gray08,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Text(
                    '사진',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const Text(
                    '* 생일 카페 관련 사진은 최대 10장까지 업로드 가능합니다.',
                    style: TextStyle(
                        color: Palette.gray08,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
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
                    height: 26,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomDialogCalendar(BuildContext context) async {
    var hostDate1 = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            //
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
                  onPressed: () {
                    //날짜를 하나만 선택 했을 시
                    _rangeEnd ??= _rangeStart;
                    setState(() {
                      hostDate =
                          '${_rangeStart?.year}.${_rangeStart?.month}.${_rangeStart?.day}~${_rangeEnd?.year}.${_rangeEnd?.month}.${_rangeEnd?.day}';
                      // print(hostDate);
                    });

                    Navigator.of(context).pop(hostDate);
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
