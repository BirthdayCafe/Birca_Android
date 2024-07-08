import 'package:birca/designSystem/palette.dart';
import 'package:birca/designSystem/text.dart';
import 'package:birca/view/host/host_my_cafe_edit.dart';
import 'package:birca/viewModel/birthday_cafe_view_model.dart';
import 'package:birca/widgets/button.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HostMyCafeDetail extends StatefulWidget {
  final int cafeID;

  const HostMyCafeDetail({Key? key, required this.cafeID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostMyCafeDetail();
}

class _HostMyCafeDetail extends State<HostMyCafeDetail> {
  //
  @override
  void initState() {
    int id = widget.cafeID; // cafeID를 저장할 변수

    super.initState();
    Provider.of<BirthdayCafeViewModel>(context, listen: false).fetchData(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false)
        .getBirthdayCafes(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false).getLuckDraws(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false).getMenus(id);
    Provider.of<BirthdayCafeViewModel>(context, listen: false)
        .getSpecialGoods(id);
  }

  bool isTab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Consumer<BirthdayCafeViewModel>(
            builder: (context, viewModel, widget) {
              return Text(
                viewModel.birthdayCafeModel?.birthdayCafeName  ?? '생일 카페 이름',
                style: const TextStyle(
                    fontSize: 16,
                    color: Palette.gray10,
                    fontFamily: 'Pretandard',
                    fontWeight: FontWeight.bold),
              );
            },
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),

        ),
        body: SingleChildScrollView(child: Consumer<BirthdayCafeViewModel>(
            builder: (context, viewModel, widget) {
              if(viewModel.birthdayCafeModel==null){
                return const CircularProgressIndicator();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '아티스트',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${viewModel.birthdayCafeModel?.artist.groupName.toString()} ${viewModel.birthdayCafeModel?.artist.name.toString()}',
                            style: const TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Pretendard',
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            '날짜 및 운영 시간',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${viewModel.birthdayCafeModel?.startDate.toString().substring(0, viewModel.birthdayCafeModel!.startDate.toString().length - 9)} ~ ${viewModel.birthdayCafeModel?.endDate.toString().substring(0, viewModel.birthdayCafeModel!.endDate.toString().length - 9)}',
                            style: const TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Pretendard',
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            '카페 이름',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${viewModel.birthdayCafeModel?.cafe.name.toString()}',
                            style: const TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Pretendard',
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${viewModel.birthdayCafeModel?.cafe.address.toString()}',
                            style: const TextStyle(
                                color: Palette.gray06,
                                fontFamily: 'Pretendard',
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '트위터 계정',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                viewModel.birthdayCafeModel!.twitterAccount
                                    .toString(),
                                style: const TextStyle(
                                    color: Palette.gray08,
                                    fontFamily: 'Pretendard',
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 34,
                                  height: 18,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Palette.gray06,
                                        padding: EdgeInsets.zero,
                                        //
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(3.0), // 테두리 둥글기
                                        ),
                                        elevation: 0
                                      // 텍스트 색상
                                    ),
                                    child: const Text(
                                      '복사',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            '실시간 혼잡도 및 특전',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
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
                                    viewModel.getSpecialGoodsStockStateInKorean(
                                        viewModel.birthdayCafeModel!
                                            .specialGoodsStockState),
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
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            '사진',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                              height: 90,
                              child: ListView.builder(
                                  shrinkWrap: true, // shrinkWrap을 true로 설정

                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel
                                      .birthdayCafeModel!.defaultImages.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Image.network(
                                        viewModel
                                            .birthdayCafeModel!.defaultImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  })),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            '특전 구성',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Consumer<BirthdayCafeViewModel>(
                              builder: (context, viewModel, widget) {
                                if (viewModel.birthdayCafeSpecialGoodsModel == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true, // shrinkWrap을 true로 설정
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                      viewModel.birthdayCafeSpecialGoodsModel?.length,
                                      // goods.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                                width: 90,
                                                child: Text(
                                                  '${viewModel.birthdayCafeSpecialGoodsModel?[index].name}',
                                                  // goods[index],
                                                  style: const TextStyle(
                                                      color: Palette.primary,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                            Text(
                                              '${viewModel.birthdayCafeSpecialGoodsModel?[index].details}',
                                              // goods[index],
                                              style: const TextStyle(
                                                color: Palette.gray10,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                }
                              }),
                          const SizedBox(
                            height: 42.5,
                          ),
                          const Text(
                            '럭키 드로우',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Consumer<BirthdayCafeViewModel>(
                              builder: (context, viewModel, widget) {
                                if (viewModel.birthdayCafeLuckyDrawsModel == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true, // shrinkWrap을 true로 설정

                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                      // luckyDraw.length,
                                      viewModel.birthdayCafeLuckyDrawsModel?.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  '${viewModel.birthdayCafeLuckyDrawsModel?[index].rank}등',
                                                  // luckyDraw[index],
                                                  style: const TextStyle(
                                                      color: Palette.primary,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                            Text(
                                              '${viewModel.birthdayCafeLuckyDrawsModel?[index].prize}',
                                              style: const TextStyle(
                                                color: Palette.gray10,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              }),
                          const SizedBox(
                            height: 42.5,
                          ),
                          const Text(
                            '생일 카페 메뉴',
                            style: TextStyle(
                                color: Palette.gray10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Consumer<BirthdayCafeViewModel>(
                              builder: (context, viewModel, widget) {
                                if (viewModel.birthdayCafeMenusModel == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF7F7FA),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ListView.builder(
                                        shrinkWrap: true, // shrinkWrap을 true로 설정
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount:
                                        viewModel.birthdayCafeMenusModel?.length,
                                        // cafeMenu.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '${viewModel.birthdayCafeMenusModel?[index].name}',
                                                    // cafeMenu[index],
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: Palette.gray10),
                                                  ),
                                                  Text(
                                                    '${viewModel.birthdayCafeMenusModel?[index].price}',
                                                    // cafeMenu[index],
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: Palette.primary),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${viewModel.birthdayCafeMenusModel?[index].details}',

                                                // cafeMenu[index],
                                                style: const TextStyle(
                                                    fontSize: 12, color: Palette.gray06),
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              )
                                            ],
                                          );
                                        }),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                );
              }

        })),
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
                          HostCafeEdit(cafeID: widget.cafeID)));
            },
            child: const BircaOutLinedButton(
                text: '편집하기',
                radiusColor: Colors.white,
                backgroundColor: Colors.white,
                width: 128,
                height: 40,
                radius: 33,
                textColor: Palette.primary,
                textSize: 14),
          ),
        ));
  }
}
