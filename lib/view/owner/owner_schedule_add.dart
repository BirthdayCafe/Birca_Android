import 'package:birca/designSystem/palette.dart';
import 'package:birca/model/owner_schedule_model.dart';
import 'package:birca/view/owner/owner_select_artist.dart';
import 'package:birca/viewModel/owner_schedule_view_model.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OwnerScheduleAdd extends StatefulWidget {
  const OwnerScheduleAdd({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OwnerScheduleAdd();
  }
}

class _OwnerScheduleAdd extends State<OwnerScheduleAdd> {
  TextEditingController artistController = TextEditingController();
  TextEditingController minimumVisitantsController = TextEditingController();
  TextEditingController maximumVisitantsController = TextEditingController();
  TextEditingController twitterAccountController = TextEditingController();
  TextEditingController hostPhoneNumberController = TextEditingController();

  //table calendar 변수
  bool isSwitched = false;
  String hostDate = '';
  bool isDateChecked = false;
  bool isCountChecked = false;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  int artistId = 0;
  String artist = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const Text(
                "아티스트",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Pretendard',
                    color: Palette.gray10),
              ),
            ),
            Row(children: [
              Container(
                width: 190,
                margin: const EdgeInsets.only(left: 14),
                child: TextField(
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  controller: artistController,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                      color: Palette.gray10),
                  decoration: const InputDecoration(
                    enabled: false,
                    enabledBorder: UnderlineInputBorder(
                      // 활성화된 상태의 밑줄 색상
                      borderSide: BorderSide(color: Palette.gray03),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              BircaOutLinedButton(
                text: '아티스트 선택',
                radiusColor: Palette.primary,
                width: 100,
                height: 36,
                radius: 6,
                textColor: Palette.primary,
                textSize: 14,
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OwnerSelectArtist()));

                  if (result != null) {
                    artistId = result['id'];
                    artist = result['artist'];
                    artistController.text = artist;
                  }
                },
                backgroundColor: Colors.white,
              )
            ]),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const Text(
                "생일카페 주최 일정",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Pretendard',
                    color: Palette.gray10),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              const SizedBox(
                width: 14,
              ),
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
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const Text("예상 방문자",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                      color: Palette.gray10)),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                margin: const EdgeInsets.only(left: 14),
                child: Row(
                  children: [
                    const Text("최대",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10)),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: maximumVisitantsController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10),
                        decoration: const InputDecoration(
                          hintText: "00",
                          enabledBorder: UnderlineInputBorder(
                            // 활성화된 상태의 밑줄 색상
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const Text("명",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10)),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("최소",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10)),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: minimumVisitantsController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        // ],
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10),
                        decoration: const InputDecoration(
                          hintText: "00",
                          enabledBorder: UnderlineInputBorder(
                            // 활성화된 상태의 밑줄 색상
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const Text("명",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10)),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const Text("생일 카페 트위터 계정",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                      color: Palette.gray10)),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 14),
              child: TextField(
                controller: twitterAccountController,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Pretendard',
                    color: Palette.gray10),
                decoration: const InputDecoration(
                  hintText: "@twitter",
                  enabledBorder: UnderlineInputBorder(
                    // 활성화된 상태의 밑줄 색상
                    borderSide: BorderSide(color: Palette.gray03),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const Text("핸드폰 번호",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                      color: Palette.gray10)),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 14),
              child: TextField(
                controller: hostPhoneNumberController,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Pretendard',
                    color: Palette.gray10),
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  hintText: "000-0000-0000",
                  enabledBorder: UnderlineInputBorder(
                    // 활성화된 상태의 밑줄 색상
                    borderSide: BorderSide(color: Palette.gray03),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 47,
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                color: Palette.primary,
                child: const Text(
                  '추가하기',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              onTap: () async {
                if (hostPhoneNumberController.text == ''||hostPhoneNumberController.text.length!=13) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('000-0000-0000 형식으로 전화번호를 입력해주세요!')));
                } else if (artistId == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('아티스트를 선택해주세요!')));
                } else if (_rangeStart == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('날짜를 선택해주세요!')));
                } else if (_rangeEnd == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('날짜를 선택해주세요!')));
                }else if(int.parse(minimumVisitantsController.text)>int.parse(maximumVisitantsController.text)){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('최대 인원이 최소 인원보다 많거나 같아야 합니다!')));
                } else {
                  if (minimumVisitantsController.text == '') {
                    minimumVisitantsController.text = '1';
                  }

                  if (maximumVisitantsController.text == '') {
                    maximumVisitantsController.text = '1';
                  }
                  try {
                    await Provider.of<OwnerScheduleViewModel>(context,
                            listen: false)
                        .postSchedule(OwnerScheduleAddModel(
                            artistId: artistId,
                            startDate: DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(_rangeStart!),
                            endDate: DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(_rangeEnd!),
                            minimumVisitant:
                                int.parse(minimumVisitantsController.text),
                            maximumVisitant:
                                int.parse(maximumVisitantsController.text),
                            twitterAccount: twitterAccountController.text,
                            hostPhoneNumber: hostPhoneNumberController.text))
                        .then((value) {
                      Provider.of<OwnerScheduleViewModel>(context,
                              listen: false)
                          .getSchedule(_rangeStart!.year, _rangeStart!.month);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('추가 완료')));
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('이미 예약된 날짜입니다.')));
                  }
                }
              },
            )
          ],
        ),
      )),
    );
  }

  void _showBottomDialogCalendar(BuildContext context) async {
    var hostDate1 = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            //

            var viewModel =
                Provider.of<OwnerScheduleViewModel>(context, listen: false);

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    locale: 'ko_KR',
                    // Set the locale to Korean

                    //오늘 날짜
                    firstDay: DateTime.now(),
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

                    availableGestures: AvailableGestures
                        .horizontalSwipe, // Enable horizontal swipe
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
