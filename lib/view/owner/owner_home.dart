import 'package:birca/designSystem/palette.dart';
import 'package:birca/view/owner/owner_request_detail.dart';
import 'package:birca/viewModel/owner_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerHome();
}

class _OwnerHome extends State<OwnerHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    Provider.of<OwnerHomeViewModel>(context, listen: false)
        .getOwnerHome("RENTAL_PENDING");
  }

  var requestList = ['aaa', 'bbb', 'cc', 'd', 'e', 'f', 'g' 'h', 'i', 'j'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: SvgPicture.asset('lib/assets/image/birca.svg'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [Tab(text: "대관 요청"), Tab(text: "대관 완료")],
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'Pretendard',
                color: Palette.primary),
            // 선택된 탭의 글꼴 스타일 설정
            unselectedLabelStyle:
                const TextStyle(fontSize: 16, color: Palette.gray10),
            // 선택되지 않은 탭의 글꼴 스타일 설정
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Palette.primary)),
          ),
        ),
        body: Consumer<OwnerHomeViewModel>(
          builder: (context, viewModel, widget) {
            return TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                    itemCount: viewModel.ownerHomeModelList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(child: Container(
                        // height: 140,
                        width: double.infinity,
                        margin:
                        const EdgeInsets.only(left: 14, right: 14, top: 19),
                        padding: const EdgeInsets.only(
                            left: 26, top: 31, bottom: 28.5),
                        decoration: BoxDecoration(
                          color: Palette.gray02, // Container의 배경색
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${viewModel.ownerHomeModelList?[index].artist.groupName} ${viewModel.ownerHomeModelList?[index].artist.name}",
                              style: const TextStyle(
                                  color: Palette.primary,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              "${viewModel.ownerHomeModelList?[index].hostName}",
                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              '${viewModel.ownerHomeModelList?[index].startDate.toString().substring(0, viewModel.ownerHomeModelList![index].startDate.toString().length - 9)} ~ ${viewModel.ownerHomeModelList?[index].endDate.toString().substring(0, viewModel.ownerHomeModelList![index].endDate.toString().length - 9)}',

                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OwnerRequestDetail(cafeID :viewModel.ownerHomeModelList![index].birthdayCafeId )));

                      },);
                    }),
                ListView.builder(
                    itemCount: viewModel.ownerHomeModelList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(child: Container(
                        // height: 140,
                        width: double.infinity,
                        margin:
                        const EdgeInsets.only(left: 14, right: 14, top: 19),
                        padding: const EdgeInsets.only(
                            left: 26, top: 31, bottom: 28.5),
                        decoration: BoxDecoration(
                          color: Palette.gray02, // Container의 배경색
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "아티스트: ${viewModel.ownerHomeModelList?[index].artist.groupName} ${viewModel.ownerHomeModelList?[index].artist.name}",
                              style: const TextStyle(
                                  color: Palette.primary,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              "닉네임 : ${viewModel.ownerHomeModelList?[index].hostName}",
                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 13.5,
                            ),
                            Text(
                              '일정: ${viewModel.ownerHomeModelList?[index].startDate.toString().substring(0, viewModel.ownerHomeModelList![index].startDate.toString().length - 9)} ~ ${viewModel.ownerHomeModelList?[index].endDate.toString().substring(0, viewModel.ownerHomeModelList![index].endDate.toString().length - 9)}',
                              style: const TextStyle(
                                  color: Palette.gray10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OwnerRequestDetail(cafeID :viewModel.ownerHomeModelList![index].birthdayCafeId )));

                          }
                      );
                    }),
              ],
            );
          },
        ));
  }

  void _handleTabSelection() {
    switch (_tabController.index) {
      case 0:
        Provider.of<OwnerHomeViewModel>(context, listen: false)
            .getOwnerHome("RENTAL_PENDING");

        break;
      case 1:
        Provider.of<OwnerHomeViewModel>(context, listen: false)
            .getOwnerHome("RENTAL_APPROVED");
        break;
    }
  }
}
