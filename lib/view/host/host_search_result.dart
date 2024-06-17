import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';
import '../../viewModel/host_home_view_model.dart';
import 'host_home_detail.dart';

class HostSearchResult extends StatefulWidget {
  final String keyword;

  const HostSearchResult({Key? key, required this.keyword}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostSearchResult();
}

class _HostSearchResult extends State<HostSearchResult> {
  @override
  void initState() {
    super.initState();
    Provider.of<HostHomeViewModel>(context, listen: false)
        .getHostHome(1, 3, widget.keyword,false);
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
        body:
            Consumer<HostHomeViewModel>(builder: (context, viewModel, widget) {
          return ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: viewModel.hostCafeHomeModelList?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    // padding: const EdgeInsets.all(8),
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
                          width: 210,
                          child: Image.network(
                            '${viewModel.hostCafeHomeModelList?[index].cafeImageUrl}',
                            fit: BoxFit.fill,
                          ),
                        ),

                        //카페 정보

                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${viewModel.hostCafeHomeModelList?[index].name}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Palette.gray10,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 21,
                              ),
                              Text(
                                '${viewModel.hostCafeHomeModelList?[index].twitterAccount}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Palette.gray08,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Palette.gray08,
                                    size: 12,
                                  ),
                                  Text(
                                    '${viewModel.hostCafeHomeModelList?[index].address.substring(0, 10)}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Palette.gray08,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(child: Container()),

                        //heart
                        Container(
                            padding: const EdgeInsets.only(top: 8, right: 8),
                            child: viewModel.hostCafeHomeModelList![index].liked
                                ? GestureDetector(
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Palette.primary,
                                    ),
                                    onTap: () {
                                      Provider.of<HostHomeViewModel>(context,
                                              listen: false)
                                          .deleteLike(viewModel
                                              .hostCafeHomeModelList![index]
                                              .cafeId)
                                          .then((value) => viewModel
                                              .hostCafeHomeModelList?[index]
                                              .liked = false);
                                    },
                                  )
                                : GestureDetector(
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Color(0xffF3F3F3),
                                    ),
                                    onTap: () {
                                      Provider.of<HostHomeViewModel>(context,
                                              listen: false)
                                          .postLike(viewModel
                                              .hostCafeHomeModelList![index]
                                              .cafeId)
                                          .then((value) => viewModel
                                              .hostCafeHomeModelList?[index]
                                              .liked = true);
                                    }))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HostHomeDetail(
                                cafeID: viewModel
                                    .hostCafeHomeModelList![index].cafeId)));
                  },
                );
              });
        }));
  }
}
