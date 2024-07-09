import 'dart:developer';

import 'package:birca/model/birthday_cafe_model.dart';
import 'package:birca/view/host/host_my_cafe_detail.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../../viewModel/birthday_cafe_view_model.dart';
import '../../widgets/button.dart';

class HostCafeEdit extends StatefulWidget {
  final int cafeID;

  const HostCafeEdit({Key? key, required this.cafeID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostCafeEdit();
}

class _HostCafeEdit extends State<HostCafeEdit> {
  int id = 0;

  @override
  void initState() {
    id = widget.cafeID; // cafeID를 저장할 변수

    super.initState();
    Provider.of<BirthdayCafeViewModel>(context, listen: false).fetchData(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false)
        .getBirthdayCafes(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false).getLuckDraws(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false).getMenus(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false)
        .getSpecialGoods(id);
  }

  final ImagePicker _picker = ImagePicker();
  List<PickedFile> _selectedImages = [];

  bool isSwitched = false;
  String hostDate = '';
  bool isDateChecked = false;
  bool isCountChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Consumer<BirthdayCafeViewModel>(
            builder: (context, viewModel, widget) {
          viewModel.birthDayCafeNameController.text =
              viewModel.birthdayCafeModel?.birthdayCafeName ?? '';
          return TextField(
              controller: viewModel.birthDayCafeNameController,
              decoration: const InputDecoration(
                  hintText: '생일 카페 이름', border: InputBorder.none),
              style: const TextStyle(
                  fontSize: 16,
                  color: Palette.gray10,
                  fontFamily: 'Pretandard',
                  fontWeight: FontWeight.bold));
        }),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body: SingleChildScrollView(
        child: Consumer<BirthdayCafeViewModel>(
            builder: (context, viewModel, widget) {
          viewModel.twitterController.text =
              viewModel.birthdayCafeModel!.twitterAccount;

          if (viewModel.birthdayCafeModel!.visibility == 'PUBLIC') {
            isSwitched = true;
          } else {
            isSwitched = false;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 33,
              ),
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
                    itemCount: viewModel.birthdayCafeModel!.cafe.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        viewModel.birthdayCafeModel!.cafe.images[index]
                            .toString(),
                        fit: BoxFit.cover,
                      );
                    },
                  )),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 17, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          '${viewModel.birthdayCafeModel?.cafe.name}',
                          style: const TextStyle(
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                          child: Row(
                        children: [
                          Text(
                            viewModel.visibility,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: isSwitched,
                                activeColor: Palette.primary,
                                onChanged: (value) async {
                                  viewModel.updateInfo();

                                  if (isSwitched) {
                                    Provider.of<BirthdayCafeViewModel>(context,
                                            listen: false)
                                        .patchCafeState(
                                            id, 'visibility', 'PRIVATE');
                                    viewModel.birthdayCafeModel!.visibility =
                                        'PRIVATE';
                                  } else {
                                    Provider.of<BirthdayCafeViewModel>(context,
                                            listen: false)
                                        .patchCafeState(
                                            id, 'visibility', 'PUBLIC');
                                    viewModel.birthdayCafeModel!.visibility =
                                        'PUBLIC';
                                  }
                                },
                              ))
                        ],
                      )),
                    ],
                  )),
              const SizedBox(
                height: 10,
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
                      child: GestureDetector(
                        child: Text(
                          viewModel.getCongestionStateInKorean(
                              viewModel.birthdayCafeModel!.congestionState),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard'),
                        ),
                        onTap: () async {
                          viewModel.updateInfo();
                          if (viewModel.birthdayCafeModel?.progressState ==
                              'IN_PROGRESS') {
                            _selectCongestionState();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('현재 진행 중일 때에만 변경 가능 합니다.')));
                          }
                        },
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
                      child: GestureDetector(
                        child: Text(
                          viewModel.getSpecialGoodsStockStateInKorean(viewModel
                              .birthdayCafeModel!.specialGoodsStockState),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard'),
                        ),
                        onTap: () async {
                          viewModel.updateInfo();

                          if (viewModel.birthdayCafeModel?.progressState ==
                              'IN_PROGRESS') {
                            _selectGoodsState();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('현재 진행 중일 때에만 변경 가능 합니다.')));
                          }
                        },
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
                      '아티스트',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${viewModel.birthdayCafeModel?.artist.groupName} ${viewModel.birthdayCafeModel?.artist.name}',
                      style: const TextStyle(fontSize: 16),
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
                    TextField(
                      controller: viewModel.twitterController,
                      decoration: const InputDecoration(
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
                          '${viewModel.birthdayCafeModel?.startDate.substring(0, 10)} ~ ${viewModel.birthdayCafeModel?.endDate.substring(0, 10)}',
                        ),
                      ),
                    ]),
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
                      height: 11,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel
                                  .birthdayCafeSpecialGoodsModel?.length,
                              itemBuilder: (context, index) {
                                for (int i = 0;
                                    i <
                                        viewModel.birthdayCafeSpecialGoodsModel!
                                            .length;
                                    i++) {
                                  viewModel.goodsNameController[i].text =
                                      viewModel
                                          .birthdayCafeSpecialGoodsModel![i]
                                          .name;
                                  viewModel.goodsDetailsController[i].text =
                                      viewModel
                                          .birthdayCafeSpecialGoodsModel![i]
                                          .details;
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
                                          flex: 1,
                                          // height : 35,
                                          // width: 150,
                                          child: TextField(
                                            controller: viewModel
                                                .goodsNameController[index],
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
                                          flex: 3,
                                          child: TextField(
                                            controller: viewModel
                                                .goodsDetailsController[index],
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
                                              viewModel.deleteGoods(index);
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
                              viewModel.addGoods();
                            },
                          )
                        ],
                      ),
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
                      height: 11,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  viewModel.birthdayCafeMenusModel?.length,
                              itemBuilder: (context, index) {
                                for (int i = 0;
                                    i <
                                        viewModel
                                            .birthdayCafeMenusModel!.length;
                                    i++) {
                                  viewModel.menuNameController[i].text =
                                      viewModel.birthdayCafeMenusModel![i].name;
                                  viewModel.menuDetailsController[i].text =
                                      viewModel
                                          .birthdayCafeMenusModel![i].details;
                                  viewModel.menuPriceController[i].text =
                                      viewModel.birthdayCafeMenusModel![i].price
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
                                          flex: 1,
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
                                          flex: 3,
                                          child: TextField(
                                            controller: viewModel
                                                .menuDetailsController[index],
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
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          flex: 3,
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
                                              viewModel.deleteMenus(index);
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
                              viewModel.addMenus();
                            },
                          )
                        ],
                      ),
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
                      height: 11,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  viewModel.birthdayCafeLuckyDrawsModel?.length,
                              itemBuilder: (context, index) {
                                for (int i = 0;
                                    i <
                                        viewModel.birthdayCafeLuckyDrawsModel!
                                            .length;
                                    i++) {
                                  viewModel.luckyDrawsRankController[i].text =
                                      viewModel
                                          .birthdayCafeLuckyDrawsModel![i].rank
                                          .toString();
                                  viewModel.luckyDrawsPrizeController[i].text =
                                      viewModel.birthdayCafeLuckyDrawsModel![i]
                                          .prize;
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
                                          flex: 1,
                                          child: TextField(
                                            controller: viewModel
                                                    .luckyDrawsRankController[
                                                index],
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
                                          flex: 6,
                                          child: TextField(
                                            controller: viewModel
                                                    .luckyDrawsPrizeController[
                                                index],
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
                                              viewModel.deleteLuckyDraws(index);
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
                              viewModel.addLuckyDraws();
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const Text(
                      '대표 사진',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.network(
                        viewModel.birthdayCafeModel?.mainImage ??
                            'https://placehold.co/90x90/F7F7FA/F7F7FA.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    BircaOutLinedButton(
                      text: '사진 업로드',
                      radiusColor: Palette.primary,
                      backgroundColor: Colors.white,
                      width: 96,
                      height: 36,
                      radius: 6,
                      textColor: Palette.primary,
                      textSize: 14,
                      onPressed: () async {
                        viewModel.updateInfo();
                        _pickMainImages(id);
                      },
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 90,
                        child: ListView.builder(
                            shrinkWrap: true, // shrinkWrap을 true로 설정

                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel
                                    .birthdayCafeModel?.defaultImages.length ??
                                0,
                            itemBuilder: (context, index) {
                              if (viewModel.isLoading) {
                                return const CircularProgressIndicator();
                              } else {
                                return Container(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Image.network(
                                    viewModel.birthdayCafeModel!
                                        .defaultImages[index],
                                    scale: 90,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            })),
                    const SizedBox(
                      height: 26,
                    ),
                    BircaOutLinedButton(
                      text: '사진 업로드',
                      radiusColor: Palette.primary,
                      backgroundColor: Colors.white,
                      width: 96,
                      height: 36,
                      radius: 6,
                      textColor: Palette.primary,
                      textSize: 14,
                      onPressed: () async {
                        viewModel.updateInfo();

                        _pickImages(id);
                      },
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
      floatingActionButton: SizedBox(
        width: 128,
        height: 40,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HostMyCafeDetail(cafeID: widget.cafeID)));
          },
          child: BircaOutLinedButton(
            text: '편집완료',
            radiusColor: Colors.white,
            backgroundColor: Colors.white,
            width: 128,
            height: 40,
            radius: 33,
            textColor: Palette.primary,
            textSize: 14,
            onPressed: () async {
              final viewModel =
                  Provider.of<BirthdayCafeViewModel>(context, listen: false);

              viewModel.update();

              Provider.of<BirthdayCafeViewModel>(context, listen: false)
                  .postSpecialGoods(id);
              Provider.of<BirthdayCafeViewModel>(context, listen: false)
                  .postMenus(id);
              Provider.of<BirthdayCafeViewModel>(context, listen: false)
                  .postLuckyDraws(id);

              await Provider.of<BirthdayCafeViewModel>(context, listen: false)
                  .patchInfo(
                      id,
                      BirthdayCafeInfoModel(
                          birthdayCafeName:
                              viewModel.birthDayCafeNameController.text,
                          birthdayCafeTwitterAccount:
                              viewModel.twitterController.text))
                  .then((value) {
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .fetchData(id);

                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getBirthdayCafes(id);
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getLuckDraws(id);
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getMenus(id);
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getSpecialGoods(id);

                Navigator.pop(context);
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages(int cafeId) async {
    List<PickedFile>? images = await _picker.getMultiImage();

    if (images != null) {
      if (images.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사진은 10장까지 선택 가능 합니다.')));
        log(_selectedImages.toString());
      } else {
        _selectedImages =
            images.map((pickedFile) => PickedFile(pickedFile.path)).toList();

        Provider.of<BirthdayCafeViewModel>(context, listen: false)
            .setLoading(true);

        try {
          await Provider.of<BirthdayCafeViewModel>(context, listen: false)
              .postImage(cafeId, _selectedImages)
              .then((value) =>
                  Provider.of<BirthdayCafeViewModel>(context, listen: false)
                      .getBirthdayCafes(id));
        } finally {
          Provider.of<BirthdayCafeViewModel>(context, listen: false)
              .setLoading(false);
        }
      }
    }
  }

  Future<void> _pickMainImages(int cafeId) async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() async {
        await Provider.of<BirthdayCafeViewModel>(context, listen: false)
            .postMainImage(cafeId, image)
            .then((value) =>
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getBirthdayCafes(id));
      });
    }
  }

  void _selectCongestionState() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('혼잡도 상태를 선택해주세요.'),
            children: [
              SimpleDialogOption(
                child: const Text("원활"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'congestion', 'SMOOTH')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text("보통"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'congestion', 'MODERATE')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text("혼잡"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'congestion', 'CONGESTED')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }

  void _selectGoodsState() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('특전 재고 상태를 선택해주세요.'),
            children: [
              SimpleDialogOption(
                child: const Text("소진"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'specialGoods', 'EXHAUSTED')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text("적음"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'specialGoods', 'SCARCE')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text("많음"),
                onPressed: () async {
                  await Provider.of<BirthdayCafeViewModel>(context,
                          listen: false)
                      .patchCafeState(id, 'specialGoods', 'ABUNDANT')
                      .then((value) {
                    Provider.of<BirthdayCafeViewModel>(context, listen: false)
                        .getBirthdayCafes(id);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }
}
