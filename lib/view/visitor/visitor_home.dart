import 'package:birca/designSystem/text.dart';
import 'package:birca/view/visitor/visitor_cafe_detail.dart';
import 'package:birca/view/visitor/visitor_search.dart';
import 'package:birca/viewModel/visitor_cafe_home_view_model.dart';
import 'package:birca/widgets/artist_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';

class VisitorHome extends StatefulWidget {
  const VisitorHome({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorHome();
}

class _VisitorHome extends State<VisitorHome> {
  final ScrollController _scrollController = ScrollController();

  String _name = '';
  String _progressState = '';

  @override
  void initState() {
    super.initState();
    Provider.of<VisitorCafeHomeViewModel>(context, listen: false)
        .getFavoriteArtist();

    Provider.of<VisitorCafeHomeViewModel>(context, listen: false)
        .getCafeHome(0, 10, '', '');
    _name = '';
    _progressState = '';

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreCafes(_name, _progressState);
      }
    });
  }

  void _loadMoreCafes(String name, String progressState) {
    var viewModel =
        Provider.of<VisitorCafeHomeViewModel>(context, listen: false);
    int lastCafeId = viewModel.visitorCafeHomeModelList!.last.birthdayCafeId;
    viewModel.updateCafeHome(lastCafeId, 10, name, progressState);
  }

  int? nowArtist;
  String nowArtistName = '';

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          // 자동으로 leading 버튼 생성 방지
          title: SvgPicture.asset('lib/assets/image/birca.svg'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VisitorSearch()));
                },
                icon: SvgPicture.asset('lib/assets/image/img_search.svg'))
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: const Color(0xffFFFFFF),
                      padding: const EdgeInsets.only(left: 16),
                      child: RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: '나의 아티스트',
                                style: TextStyle(
                                    color: Palette.primary,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' 목록',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Pretendard'),
                              ),
                            ]),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          child: const Text(
                            '원하는 아티스트가 없다면?',
                            style:
                                TextStyle(fontSize: 10, color: Palette.gray06),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ArtistAdd()));
                          },
                        ))
                  ],
                ),
                Container(
                  color: const Color(0xffFFFFFF),
                  height: 16,
                ),
                Consumer<VisitorCafeHomeViewModel>(
                    builder: (context, viewModel, widget) {
                  return Container(
                    color: const Color(0xffFFFFFF),
                    height: 100,
                    padding: const EdgeInsets.only(left: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true, // shrinkWrap을 true로 설정
                      itemCount: viewModel.homeArtistsList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (viewModel.homeArtistsList?[index].artistImage !=
                            null) {
                          bool isSelected = nowArtist == index;

                          return Container(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                                color: Palette.primary,
                                                width: 3.0)
                                            : null,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          viewModel.homeArtistsList?[index]
                                                  .artistImage ??
                                              'https://placehold.co/210x140/F7F7FA/F7F7FA.jpg',
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      viewModel.homeArtistsList?[index]
                                              .artistName ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Pretendard'),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nowArtist == index) {
                                      if (isSwitched) {
                                        Provider.of<VisitorCafeHomeViewModel>(
                                                context,
                                                listen: false)
                                            .getCafeHome(
                                                0, 10, '', 'IN_PROGRESS');
                                        _name = '';
                                        _progressState = 'IN_PROGRESS';
                                        nowArtist = null;
                                      } else {
                                        Provider.of<VisitorCafeHomeViewModel>(
                                                context,
                                                listen: false)
                                            .getCafeHome(0, 10, '', '');
                                        _name = '';
                                        _progressState = '';
                                        nowArtist = null;
                                      }
                                    } else {
                                      nowArtistName = viewModel
                                              .homeArtistsList?[index]
                                              .artistName ??
                                          '';

                                      if (isSwitched) {
                                        nowArtist = index;
                                        Provider.of<VisitorCafeHomeViewModel>(
                                                context,
                                                listen: false)
                                            .getCafeHome(0, 10, nowArtistName,
                                                'IN_PROGRESS');
                                        _name = nowArtistName;
                                        _progressState = 'IN_PROGRESS';
                                      } else {
                                        nowArtist = index;
                                        Provider.of<VisitorCafeHomeViewModel>(
                                                context,
                                                listen: false)
                                            .getCafeHome(
                                                0, 10, nowArtistName, '');
                                        _name = nowArtistName;
                                        _progressState = '';
                                      }
                                    }
                                  });
                                },
                              ));
                        }
                        return null;
                      },
                    ),
                  );
                }),
                Container(
                  height: 8,
                  color: Palette.gray02,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  color: const Color(0xffFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: const [
                                      TextSpan(
                                        text: '전체',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Pretendard',
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' 생일 카페',
                                        style: TextStyle(
                                            color: Palette.primary,
                                            fontSize: 20,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              // SizedBox(
                              //     width: 30,
                              //     child: IconButton(
                              //       onPressed: () {
                              //         showModalBottomSheet(
                              //             context: context,
                              //             builder: (BuildContext context) {
                              //               return Container(
                              //                 padding: const EdgeInsets.only(
                              //                     bottom: 20, top: 50),
                              //                 height: 300,
                              //                 child: Column(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment.start,
                              //                       children: [
                              //                         const BircaText(
                              //                             text: '지역',
                              //                             textSize: 20,
                              //                             textColor: Palette.gray10,
                              //                             fontFamily: 'Pretendard'),
                              //                         Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment.center,
                              //                           children: [
                              //                             DropdownButton(
                              //                               value: selectedRegion1,
                              //                               items: optionsRegion1
                              //                                   .map((String option) {
                              //                                 return DropdownMenuItem<
                              //                                         String>(
                              //                                     value: option,
                              //                                     child:
                              //                                         Text(option));
                              //                               }).toList(),
                              //                               onChanged:
                              //                                   (String? newValue) {
                              //                                 setState(() {
                              //                                   selectedRegion1 =
                              //                                       newValue!;
                              //                                 });
                              //                               },
                              //                             ),
                              //                             DropdownButton(
                              //                               value: selectedRegion2,
                              //                               items: optionsRegion2
                              //                                   .map((String option) {
                              //                                 return DropdownMenuItem<
                              //                                         String>(
                              //                                     value: option,
                              //                                     child:
                              //                                         Text(option));
                              //                               }).toList(),
                              //                               onChanged:
                              //                                   (String? newValue) {
                              //                                 setState(() {
                              //                                   selectedRegion2 =
                              //                                       newValue!;
                              //                                 });
                              //                               },
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     SizedBox(
                              //                       width: 300,
                              //                       child: BircaElevatedButton(
                              //                         text: '적용하기',
                              //                         color: Palette.primary,
                              //                         fontSize: 18,
                              //                         textColor: Colors.white,
                              //                         fontWeight: FontWeight.normal,
                              //                         onPressed: () {},
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               );
                              //             });
                              //       },
                              //       icon: SvgPicture.asset(
                              //         'lib/assets/image/img_filter.svg',
                              //       ),
                              //     )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Palette.gray06,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20)), // 원하는 패딩 값 설정

                            child: const Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Palette.gray10,
                                  size: 12,
                                ),
                                BircaText(
                                    text: '서울',
                                    textSize: 12,
                                    textColor: Palette.gray10,
                                    fontFamily: 'Pretendard')
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const BircaText(
                              text: '실시간',
                              textSize: 12,
                              textColor: Palette.gray06,
                              fontFamily: 'Pretendard'),
                          Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: isSwitched,
                                activeColor: Palette.primary,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                  if (isSwitched) {
                                    if (nowArtist == null) {
                                      Provider.of<VisitorCafeHomeViewModel>(
                                              context,
                                              listen: false)
                                          .getCafeHome(
                                              0, 10, '', 'IN_PROGRESS');
                                      _name = '';
                                      _progressState = 'IN_PROGRESS';
                                    } else {
                                      Provider.of<VisitorCafeHomeViewModel>(
                                              context,
                                              listen: false)
                                          .getCafeHome(0, 10, nowArtistName,
                                              'IN_PROGRESS');
                                      _name = nowArtistName;
                                      _progressState = 'IN_PROGRESS';
                                    }
                                  } else {
                                    if (nowArtist == null) {
                                      Provider.of<VisitorCafeHomeViewModel>(
                                              context,
                                              listen: false)
                                          .getCafeHome(0, 10, '', '');
                                      _name = '';
                                      _progressState = '';
                                    } else {
                                      Provider.of<VisitorCafeHomeViewModel>(
                                              context,
                                              listen: false)
                                          .getCafeHome(
                                              0, 10, nowArtistName, '');
                                      _name = nowArtistName;
                                      _progressState = '';
                                    }
                                  }
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<VisitorCafeHomeViewModel>(
                    builder: (context, viewModel, widget) {
                  if (viewModel.visitorCafeHomeModelList == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                        color: const Color(0xffFFFFFF),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: viewModel.visitorCafeHomeModelList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Container의 배경색
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      // 그림자 색상
                                      spreadRadius: 1,
                                      // 그림자 확산 정도
                                      blurRadius: 1, // 그림자의 흐림 정도
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //이미지
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: SizedBox(
                                        height: 140,
                                        width: 140,
                                        child: Image.network(
                                          viewModel
                                                  .visitorCafeHomeModelList?[
                                                      index]
                                                  .mainImageUrl ??
                                              'https://placehold.co/210x140/F7F7FA/F7F7FA.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    //카페 정보
                                    Container(
                                      height: 140,
                                      margin: const EdgeInsets.only(left: 14),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          BircaText(
                                              text:
                                                  '${viewModel.visitorCafeHomeModelList?[index].artist.groupName ?? ''} ${viewModel.visitorCafeHomeModelList?[index].artist.name.toString()}',
                                              textSize: 12,
                                              textColor: Palette.gray08,
                                              fontFamily: 'Pretendard'),

                                          BircaText(
                                            text:
                                                '${viewModel.visitorCafeHomeModelList?[index].startDate.toString().substring(0, viewModel.visitorCafeHomeModelList![index].startDate.toString().length - 9)}~${viewModel.visitorCafeHomeModelList![index].endDate.toString().substring(0, viewModel.visitorCafeHomeModelList![index].endDate.toString().length - 9)}',
                                            textSize: 12,
                                            textColor: Palette.gray08,
                                            fontFamily: 'Pretendard',
                                          ),
                                          // Text('카페 이름'),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            viewModel
                                                .visitorCafeHomeModelList![
                                                    index]
                                                .birthdayCafeName,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),

                                          Expanded(child: Container()),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Palette.gray08,
                                                size: 20,
                                              ),
                                              viewModel
                                                          .visitorCafeHomeModelList![
                                                              index]
                                                          .cafe
                                                          .address
                                                          .length >=
                                                      14
                                                  ? Text(
                                                      '${viewModel.visitorCafeHomeModelList![index].cafe.address.substring(0, 14)}...',
                                                      style: const TextStyle(
                                                        color: Palette.gray08,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid, // 밑줄의 스타일
                                                      ),
                                                    )
                                                  : Text(
                                                      '${viewModel.visitorCafeHomeModelList![index].cafe.address}',
                                                      style: const TextStyle(
                                                        color: Palette.gray08,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid, // 밑줄의 스타일
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    Expanded(child: Container()),

                                    //heart
                                    GestureDetector(
                                        child: Icon(
                                          Icons.favorite,
                                          color: viewModel
                                                  .visitorCafeHomeModelList![
                                                      index]
                                                  .isLiked
                                              ? Palette.primary
                                              : const Color(0xffF3F3F3),
                                        ),
                                        onTap: () {
                                          if (viewModel
                                              .visitorCafeHomeModelList![index]
                                              .isLiked) {
                                            Provider.of<VisitorCafeHomeViewModel>(
                                                    context,
                                                    listen: false)
                                                .dislike(viewModel
                                                    .visitorCafeHomeModelList![
                                                        index]
                                                    .birthdayCafeId);

                                            viewModel
                                                .visitorCafeHomeModelList![
                                                    index]
                                                .isLiked = false;
                                          } else {
                                            Provider.of<VisitorCafeHomeViewModel>(
                                                    context,
                                                    listen: false)
                                                .like(viewModel
                                                    .visitorCafeHomeModelList![
                                                        index]
                                                    .birthdayCafeId);

                                            viewModel
                                                .visitorCafeHomeModelList![
                                                    index]
                                                .isLiked = true;
                                          }
                                        })
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VisitorCafeDetail(
                                            cafeID: viewModel
                                                .visitorCafeHomeModelList![
                                                    index]
                                                .birthdayCafeId)));
                              },
                            );
                          },
                        ));
                  }
                })
              ],
            ),
          ),
          // floatingActionButton: SizedBox(
          //   width: 86,
          //   height: 38,
          //   child: FloatingActionButton(
          //     onPressed: () {},
          //     backgroundColor: Colors.black,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(30.0),
          //       side: const BorderSide(color: Colors.white, width: 2.0), // 테두리 설정
          //     ), // 버튼 배경색
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         BircaText(
          //             text: '지도',
          //             textSize: 16,
          //             textColor: Colors.white,
          //             fontFamily: 'Pretendard'),
          //         Icon(
          //           Icons.location_on_outlined,
          //           size: 24,
          //           color: Colors.white,
          //         )
          //       ],
          //     ), // 버튼 모양
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
        ));
  }
}
