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

  // List<String> cafeDetailImage = [
  //   'lib/assets/image/img_cafe_test.png',
  //   'lib/assets/image/img_cafe_test.png',
  //   'lib/assets/image/img_cafe_test.png',
  //   'lib/assets/image/img_cafe_test.png',
  //   'lib/assets/image/img_cafe_test.png'
  // ];

  List<String> goods = ['menu1', 'menu2', 'menu3', 'menu4', 'menu5'];

  List<String> cafeMenu = ['menu1', 'menu2', 'menu3', 'menu4', 'menu5'];
  List<String> luckyDraw = ['menu1', 'menu2', 'menu3', 'menu4', 'menu5'];
  TextEditingController birthDayCafeNameController = TextEditingController();

  TextEditingController cafeNameController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController cafeAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Consumer<BirthdayCafeViewModel>(
            builder: (context, viewModel, widget) {
          birthDayCafeNameController.text =
              viewModel.birthdayCafeModel?.birthdayCafeName ?? '';
          return TextField(
              controller: birthDayCafeNameController,
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
          cafeNameController.text = viewModel.birthdayCafeModel!.cafe.name;
          artistController.text =
              '${viewModel.birthdayCafeModel!.artist.groupName} ${viewModel.birthdayCafeModel!.artist.name}';
          twitterController.text = viewModel.birthdayCafeModel!.twitterAccount;
          cafeAddressController.text =
              viewModel.birthdayCafeModel!.cafe.address;

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
                  padding: const EdgeInsets.only(left: 20, right: 17, top: 20),
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
                      child: Text(
                        viewModel.getCongestionStateInKorean(
                            viewModel.birthdayCafeModel!.congestionState),
                        style: const TextStyle(
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
                      child: Text(
                        viewModel.getSpecialGoodsStockStateInKorean(viewModel
                            .birthdayCafeModel!.specialGoodsStockState),
                        style: const TextStyle(
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
                      '아티스트',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    TextField(
                      controller: artistController,
                      decoration: const InputDecoration(
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
                    TextField(
                      controller: twitterController,
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
                      '카페 위치',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    TextField(
                      controller: cafeAddressController,
                      decoration: const InputDecoration(
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
                      height: 11,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: goods.length,
                              itemBuilder: (context, index) {
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: goods[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: goods[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                // 활성화된 상태의 밑줄 색상
                                                borderSide: BorderSide(
                                                    color: Palette.gray03),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              deleteGoods(index);
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
                              addGoods();
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
                              itemCount: cafeMenu.length,
                              itemBuilder: (context, index) {
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: cafeMenu[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: cafeMenu[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                // 활성화된 상태의 밑줄 색상
                                                borderSide: BorderSide(
                                                    color: Palette.gray03),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              deleteMenu(index);
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
                              addMenu();
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
                              itemCount: luckyDraw.length,
                              itemBuilder: (context, index) {
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: luckyDraw[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
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
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: luckyDraw[index],
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                // 활성화된 상태의 밑줄 색상
                                                borderSide: BorderSide(
                                                    color: Palette.gray03),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              deleteLuckyDraw(index);
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
                              addLuckyDraw();
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
                        viewModel.birthdayCafeModel?.mainImage ?? '',
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
                      onPressed: () {
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
                              return Container(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.network(
                                  viewModel
                                      .birthdayCafeModel!.defaultImages[index],
                                  scale: 90,
                                  fit: BoxFit.cover,
                                ),
                              );
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
                      onPressed: () {
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
              await Provider.of<BirthdayCafeViewModel>(context, listen: false)
                  .patchInfo(
                      id,
                      BirthdayCafeInfoModel(
                          birthdayCafeName: birthDayCafeNameController.text,
                          birthdayCafeTwitterAccount: twitterController.text))
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

  //특전 삭제
  void deleteGoods(int index) {
    setState(() {
      goods.removeAt(index);
    });
  }

  //특전 생성
  void addGoods() {
    setState(() {
      goods.add("a");
    });
  }

  //메뉴 삭제
  void deleteMenu(int index) {
    setState(() {
      cafeMenu.removeAt(index);
    });
  }

  //메뉴 생성
  void addMenu() {
    setState(() {
      cafeMenu.add("a");
    });
  }

  //특전 삭제
  void deleteLuckyDraw(int index) {
    setState(() {
      luckyDraw.removeAt(index);
    });
  }

  //특전 생성
  void addLuckyDraw() {
    setState(() {
      luckyDraw.add("a");
    });
  }

  Future<void> _pickImages(int cafeId) async {
    // final List<XFile> pickedFiles = await _picker.pickMultiImage();
    List<PickedFile>? images = await _picker.getMultiImage();

    if (images != null) {
      if (images.length > 10) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('사진은 10장까지 선택 가능합니다.')));
        log(_selectedImages.toString());
      } else {
        _selectedImages =
            images.map((pickedFile) => PickedFile(pickedFile.path)).toList();

        log('---------${_selectedImages.length}--------');

        _selectedImages = [];

        await Provider.of<BirthdayCafeViewModel>(context, listen: false)
            .postImage(cafeId, _selectedImages)
            .then((value) =>
                Provider.of<BirthdayCafeViewModel>(context, listen: false)
                    .getBirthdayCafes(id));
        log(_selectedImages.toString());
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
}
