import 'dart:developer';
import 'package:birca/model/owner_my_cafe_detail_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/owner_my_cafe_view_model.dart';
import '../../widgets/button.dart';

class OwnerMyCafeEdit extends StatefulWidget {
  const OwnerMyCafeEdit({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMyCafeEdit();
}

class _OwnerMyCafeEdit extends State<OwnerMyCafeEdit> {

  @override
  void initState() {
    super.initState();
    Provider.of<OwnerMyCafeViewModel>(context, listen: false).getMyCafe();
  }

  List<MenuModel> cafeMenu = [];
  List<OptionModel> cafeOptions = [];

  bool isDateChecked = false;
  bool isCountChecked = false;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  final List<DateTime> _selectedDates = [];
  final ImagePicker _picker = ImagePicker();
  List<PickedFile> _selectedImages = [];

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
        child: Consumer<OwnerMyCafeViewModel>(
            builder: (context, viewModel, widget) {
          viewModel.cafeNameController.text =
              '${viewModel.ownerMyCafeDetailModel?.cafeName}';
          viewModel.cafeAddressController.text =
              '${viewModel.ownerMyCafeDetailModel?.cafeAddress}';
          viewModel.businessHoursController.text =
              '${viewModel.ownerMyCafeDetailModel?.businessHours}';
          viewModel.twitterAccountController.text =
              '${viewModel.ownerMyCafeDetailModel?.twitterAccount}';

          cafeMenu.addAll(viewModel.ownerMyCafeDetailModel!.cafeMenus);

          cafeOptions.addAll(viewModel.ownerMyCafeDetailModel!.cafeOptions);

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
                        viewModel.ownerMyCafeDetailModel!.cafeImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        viewModel.ownerMyCafeDetailModel!.cafeImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  )),
              Container(
                alignment: Alignment.center,
                child: BircaOutLinedButton(
                  text: '사진 편집',
                  radiusColor: Palette.primary,
                  backgroundColor: Colors.white,
                  width: 50,
                  height: 30,
                  radius: 5,
                  textColor: Palette.primary,
                  textSize: 10,
                  onPressed: () async {
                    _pickImages(viewModel.ownerMyCafeDetailModel!.cafeId);
                    // List<PickedFile>? images = await picker.getMultiImage();
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '${_selectedImages.length}장 편집됨',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Palette.gray06,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500),
                ),
              ),
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
                    TextField(
                      controller: viewModel.cafeNameController,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Palette.gray08,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
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
                    TextField(
                      controller: viewModel.twitterAccountController,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Palette.gray08,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
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
                        child: TextField(
                          controller: viewModel.cafeAddressController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 11,
                      // ),
                      // BircaOutLinedButton(
                      //   text: '장소 선택',
                      //   radiusColor: Palette.primary,
                      //   width: 80,
                      //   height: 36,
                      //   radius: 6,
                      //   textColor: Palette.primary,
                      //   textSize: 14,
                      //   onPressed: () {},
                      //   backgroundColor: Colors.white,
                      // )
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
                    Row(
                      children: [
                        SizedBox(
                          width: 115,
                          height: 36,
                          child: TextField(
                            controller: viewModel.businessHoursController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                // 활성화된 상태의 밑줄 색상
                                borderSide: BorderSide(color: Palette.primary),
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   "부터",
                        //   style: TextStyle(
                        //       color: Palette.gray08,
                        //       fontSize: 14,
                        //       fontFamily: 'Pretendard',
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // SizedBox(
                        //   width: 115,
                        //   height: 36,
                        //   child: TextField(
                        //     textAlign: TextAlign.center,
                        //     decoration: InputDecoration(
                        //       hintText: "오전 9시",
                        //       focusedBorder: UnderlineInputBorder(
                        //         // 활성화된 상태의 밑줄 색상
                        //         borderSide: BorderSide(color: Palette.primary),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                        focusedDay: _focusedDay,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(DateTime.now().year + 1),

                        headerStyle: const HeaderStyle(titleTextStyle: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                            formatButtonVisible: false, titleCentered: false,
                            headerMargin: EdgeInsets.all(5),
                            rightChevronVisible: false,
                            leftChevronVisible:false),
                        availableGestures: AvailableGestures.horizontalSwipe, // Enable horizontal swipe

                        selectedDayPredicate: (day) {
                          return _selectedDates.any(
                              (selectedDate) => isSameDay(selectedDate, day));
                        },

                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;

                              if (_selectedDates.any(
                                  (date) => isSameDay(date, selectedDay))) {
                                // 이미 선택된 날짜이면 리스트에서 제거
                                _selectedDates.removeWhere(
                                    (date) => isSameDay(date, selectedDay));
                              } else {
                                // 선택되지 않은 날짜이면 리스트에 추가
                                _selectedDates.add(selectedDay);
                              }

                              log(_selectedDates.toString());
                            });
                          }
                        },
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
                              itemCount: viewModel.ownerMyCafeDetailModel
                                      ?.cafeMenus.length ??
                                  0,
                              itemBuilder: (context, index) {
                                for (int i = 0;
                                    i <
                                        viewModel.ownerMyCafeDetailModel!
                                            .cafeMenus.length;
                                    i++) {
                                  viewModel.menuNameController[i].text =
                                      viewModel.ownerMyCafeDetailModel!
                                          .cafeMenus[i].name;
                                  viewModel.menuPriceController[i].text =
                                      viewModel.ownerMyCafeDetailModel!
                                          .cafeMenus[i].price
                                          .toString();
                                }

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
                                            controller: viewModel
                                                .menuNameController[index],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
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
                                            controller: viewModel
                                                .menuPriceController[index],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                // 활성화된 상태의 밑줄 색상
                                                borderSide: BorderSide(
                                                    color: Palette.gray03),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              viewModel.deleteCafeMenu(index);
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
                              viewModel.addCafeMenu();
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
                              itemCount: viewModel.ownerMyCafeDetailModel
                                      ?.cafeOptions.length ??
                                  0,
                              itemBuilder: (context, index) {
                                for (int i = 0;
                                    i <
                                        viewModel.ownerMyCafeDetailModel!
                                            .cafeOptions.length;
                                    i++) {
                                  viewModel.optionNameController[i].text =
                                      viewModel.ownerMyCafeDetailModel!
                                          .cafeOptions[i].name;
                                  viewModel.optionPriceController[i].text =
                                      viewModel.ownerMyCafeDetailModel!
                                          .cafeOptions[i].price
                                          .toString();
                                }

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
                                            controller: viewModel
                                                .optionNameController[index],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
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
                                            controller: viewModel
                                                .optionPriceController[index],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                // 활성화된 상태의 밑줄 색상
                                                borderSide: BorderSide(
                                                    color: Palette.gray03),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              viewModel.deleteCafeOption(index);
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
                              viewModel.addCafeOption();
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
                  color: Palette.primary,
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
                onTap: () async {
                  // 선택된 날짜를 ISO 8601 문자열 형식으로 변환
                  final List<String> dateStrings = _selectedDates
                      .map((date) =>
                          DateFormat('yyyy-MM-ddTHH:mm:ss').format(date))
                      .toList();

                  // 데이터 정의
                  final Map<String, dynamic> data = {
                    "datOffDates": dateStrings,
                  };

                 viewModel.update();

                 if(viewModel.ownerMyCafeDetailModel?.cafeImages==[]){
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('사진을 선택해주세요!')));
                 } else {
                   await Provider.of<OwnerMyCafeViewModel>(context, listen: false)
                       .postDayOff(
                       viewModel.ownerMyCafeDetailModel!.cafeId, data);
                   await Provider.of<OwnerMyCafeViewModel>(context,
                       listen: false).postMenus();
                   await Provider.of<OwnerMyCafeViewModel>(context,
                       listen: false).postOptions();

                   await Provider.of<OwnerMyCafeViewModel>(context,
                       listen: false)
                       .patchMyCafe(
                     viewModel.cafeNameController.text,
                     viewModel.cafeAddressController.text,
                     viewModel.twitterAccountController.text,
                     viewModel.businessHoursController.text,
                   )
                       .then((_) {
                     log(dateStrings.toString());
                     // Navigate on success
                     Provider.of<OwnerMyCafeViewModel>(context, listen: false)
                         .getMyCafe();
                     Navigator.pop(context);
                   }).catchError((error) {
                     log('fail');
                   });
                 }

                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> _pickImages(int cafeId) async {
    // final List<XFile> pickedFiles = await _picker.pickMultiImage();
    List<PickedFile>? images = await _picker.getMultiImage();

    if (images != null) {
      _showLoadingDialog(context);

      if (images.length > 5) {
        _hideLoadingDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사진은 5장까지 선택할 수 있습니다.')));
        log(_selectedImages.toString());

      } else {
        setState(() async {
          _selectedImages =
              images.map((pickedFile) => PickedFile(pickedFile.path)).toList();

          await Provider.of<OwnerMyCafeViewModel>(context, listen: false)
              .postImage(cafeId, _selectedImages)
              .then((value) =>
                  Provider.of<OwnerMyCafeViewModel>(context, listen: false)
                      .getMyCafe());
          // log(_selectedImages.toString());
          _hideLoadingDialog(context);
        });
      }
    }
  }
}

void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void _hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
