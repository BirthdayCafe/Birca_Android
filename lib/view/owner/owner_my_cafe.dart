import 'package:birca/view/owner/owner_my_cafe_edit.dart';
import 'package:birca/viewModel/owner_my_cafe_view_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';

class OwnerMyCafe extends StatefulWidget {
  const OwnerMyCafe({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMyCafe();
}

class _OwnerMyCafe extends State<OwnerMyCafe> {
  @override
  void initState() {
    super.initState();
    Provider.of<OwnerMyCafeViewModel>(context, listen: false).getMyCafe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 자동으로 leading 버튼 생성 방지
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
        body: SingleChildScrollView(child: Consumer<OwnerMyCafeViewModel>(
          builder: (context, viewModel, widget) {
            if (viewModel.ownerMyCafeDetailModel == null) {
              return const CircularProgressIndicator();
            } else {
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
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          viewModel.ownerMyCafeDetailModel?.cafeName ??
                              '입력해주세요',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Palette.gray10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
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
                          '트위터 계정',
                          style: TextStyle(
                              fontSize: 14,
                              color: Palette.gray10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          viewModel.ownerMyCafeDetailModel?.twitterAccount ??
                              '입력해주세요',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Palette.gray08,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '카페 위치',
                          style: TextStyle(
                              fontSize: 14,
                              color: Palette.gray10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${viewModel.ownerMyCafeDetailModel?.cafeAddress}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Palette.gray08,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '운영 시간 및 날짜',
                          style: TextStyle(
                              fontSize: 14,
                              color: Palette.gray10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          viewModel.ownerMyCafeDetailModel?.businessHours ??
                              '입력해주세요',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Palette.gray08,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400),
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
                        const SizedBox(
                          height: 11,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7F7FA),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel
                                  .ownerMyCafeDetailModel!.cafeMenus.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${viewModel.ownerMyCafeDetailModel?.cafeMenus[index].name}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Palette.gray10),
                                        ),
                                        const Expanded(
                                          child: Divider(
                                            color: Palette.gray06,
                                            // 점선의 색상 설정
                                            height: 1,
                                            // 점선의 높이 설정
                                            thickness: 1,
                                            // 점선의 두께 설정
                                            indent: 10,
                                            // 시작 부분 여백 설정
                                            endIndent: 10, // 끝 부분 여백 설정
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.ownerMyCafeDetailModel?.cafeMenus[index].price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Palette.primary),
                                        ),
                                      ],
                                    ));
                              }),
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
                        const SizedBox(
                          height: 11,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7F7FA),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                              shrinkWrap: true, // shrinkWrap을 true로 설정
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel
                                  .ownerMyCafeDetailModel!.cafeOptions.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${viewModel.ownerMyCafeDetailModel?.cafeOptions[index].name}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Palette.gray10),
                                        ),
                                        const Expanded(
                                          child: Divider(
                                            color: Palette.gray06,
                                            // 점선의 색상 설정
                                            height: 1,
                                            // 점선의 높이 설정
                                            thickness: 1,
                                            // 점선의 두께 설정
                                            indent: 10,
                                            // 시작 부분 여백 설정
                                            endIndent: 10, // 끝 부분 여백 설정
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.ownerMyCafeDetailModel?.cafeOptions[index].price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Palette.primary),
                                        ),
                                      ],
                                    ));
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        )),
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
                        builder: (context) => const OwnerMyCafeEdit()));
              },
              child: const Icon(Icons.edit)),
        ));
  }
}
