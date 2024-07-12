import 'package:birca/designSystem/palette.dart';
import 'package:birca/designSystem/text.dart';
import 'package:birca/view/visitor/visitor_cafe_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../viewModel/visitor_cafe_home_view_model.dart';

class VisitorSearchResult extends StatefulWidget {
  final String keyword;

  const VisitorSearchResult({Key? key, required this.keyword})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisitorSearchResult();
}

class _VisitorSearchResult extends State<VisitorSearchResult> {
  @override
  void initState() {
    super.initState();
    Provider.of<VisitorCafeHomeViewModel>(context, listen: false)
        .getCafeSearch('', widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: BircaText(
              text: '"${widget.keyword}" 검색 결과',
              textSize: 18,
              textColor: Palette.gray10,
              fontFamily: 'Pretednard'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
        ),
        body: Consumer<VisitorCafeHomeViewModel>(
            builder: (context, viewModel, widget) {
              if(viewModel.visitorCafeSearchModelList==null){
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: viewModel.visitorCafeSearchModelList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          margin:
                          const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white, // Container의 배경색
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1), // 그림자 색상
                                spreadRadius: 1, // 그림자 확산 정도
                                blurRadius: 1, // 그림자의 흐림 정도
                                // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //이미지
                              SizedBox(
                                height: 140,
                                width: 140,
                                child:
                                Image.network(viewModel.visitorCafeSearchModelList?[index].mainImageUrl??'',                                fit: BoxFit.cover,
                                ),
                              ),
                              //카페 정보
                              Container(
                                height: 140,
                                margin: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    BircaText(
                                        text:
                                        '${viewModel.visitorCafeSearchModelList?[index].artist.groupName} ${viewModel.visitorCafeSearchModelList?[index].artist.name}',
                                        textSize: 12,
                                        textColor: Palette.gray08,
                                        fontFamily: 'Pretendard'),

                                    // Text('1월 1일~1월 2일'),
                                    BircaText(
                                      text:
                                      '${viewModel.visitorCafeSearchModelList?[index].startDate.toString().substring(0, viewModel.visitorCafeSearchModelList![index].startDate.toString().length - 9)}~${viewModel.visitorCafeSearchModelList?[index].endDate.toString().substring(0, viewModel.visitorCafeSearchModelList![index].endDate.toString().length - 9)}',
                                      textSize: 12,
                                      textColor: Palette.gray08,
                                      fontFamily: 'Pretendard',
                                    ),
                                    // Text('카페 이름'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      viewModel.visitorCafeSearchModelList![index]
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
                                        Text(
                                          '${viewModel.visitorCafeSearchModelList![index].cafe.address.substring(0, 14)}...',
                                          style: const TextStyle(
                                            color: Palette.gray08,
                                            fontSize: 12,
                                            decoration: TextDecoration.underline,
                                            decorationStyle:
                                            TextDecorationStyle.solid, // 밑줄의 스타일
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisitorCafeDetail(
                                      cafeID: viewModel
                                          .visitorCafeSearchModelList![index]
                                          .birthdayCafeId)));
                        },
                      );
                    });
              }
        }));
  }
}
