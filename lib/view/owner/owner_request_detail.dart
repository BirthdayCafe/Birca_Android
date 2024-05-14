import 'package:birca/designSystem/palette.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../viewModel/owner_request_detail_view_model.dart';

class OwnerRequestDetail extends StatefulWidget {
  final int cafeID;

  const OwnerRequestDetail({Key? key, required this.cafeID}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OwnerRequestDetail();
  }
}

class _OwnerRequestDetail extends State<OwnerRequestDetail> {
  int id = 0;

  @override
  void initState() {
    super.initState();
    id = widget.cafeID; // cafeID를 저장할 변수

    Provider.of<OwnerRequestDetailViewModel>(context, listen: false)
        .getRequestDetailHome(id);
  }

  bool isRequestAccept = false;

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
              child: Consumer<OwnerRequestDetailViewModel>(
                  builder: (context, viewModel, widget) {
                return Column(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14),
                      child: Text(
                          "${viewModel.ownerRequestDetailModel?.artist.groupName} ${viewModel.ownerRequestDetailModel?.artist.name}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Pretendard',
                              color: Palette.gray10)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 183),
                      child: const Divider(
                        color: Palette.gray03,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14),
                      child: const Text(
                        "신청자",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pretendard',
                            color: Palette.gray10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14),
                      child: const Text("홍길동",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Pretendard',
                              color: Palette.gray10)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 183),
                      child: const Divider(
                        color: Palette.gray03,
                      ),
                    ),
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
                    Container(
                      margin: const EdgeInsets.only(left: 14),
                      width: 238,
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD7D8DC)),
                        borderRadius: BorderRadius.circular(2), // 테두리 굴곡 설정
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${viewModel.ownerRequestDetailModel?.startDate.toString().substring(0, viewModel.ownerRequestDetailModel!.startDate.toString().length - 9)} ~ ${viewModel.ownerRequestDetailModel?.endDate.toString().substring(0, viewModel.ownerRequestDetailModel!.endDate.toString().length - 9)}',
                        style: const TextStyle(
                            fontSize: 14, color: Palette.gray08),
                      ),
                    ),
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
                      child: Text(
                          "최소 ${viewModel.ownerRequestDetailModel?.minimumVisitants.toString()}명, 최대 ${viewModel.ownerRequestDetailModel?.maximumVisitants.toString()}명",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Pretendard',
                              color: Palette.gray10)),
                    ),
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
                      margin: const EdgeInsets.only(left: 14),
                      child: Text(
                          "${viewModel.ownerRequestDetailModel?.twiiterAccount}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Pretendard',
                              color: Palette.gray10)),
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
                      margin: const EdgeInsets.only(left: 14),
                      child: Text(
                          "${viewModel.ownerRequestDetailModel?.hostPhoneNumber}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Pretendard',
                              color: Palette.gray10)),
                    ),
                    const SizedBox(
                      height: 47,
                    ),
                    isRequestAccept
                        ? Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 40,
                            color: Palette.gray02,
                            child: const Text(
                              '요청 수락이 완료된 글입니다.',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  color: Palette.gray06),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(left: 19, right: 19),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BircaOutLinedButton(
                                  text: '요청 수락',
                                  radiusColor: Palette.primary,
                                  backgroundColor: Palette.primary,
                                  width: 170,
                                  height: 44,
                                  radius: 6,
                                  textColor: Colors.white,
                                  textSize: 14,
                                  onPressed: () {
                                    Provider.of<OwnerRequestDetailViewModel>(
                                            context,
                                            listen: false)
                                        .postApprove(id);
                                    setState(() {
                                      isRequestAccept = true;
                                    });
                                  },
                                ),
                                BircaOutLinedButton(
                                  text: '요청 거절',
                                  radiusColor: Palette.primary,
                                  backgroundColor: Colors.white,
                                  width: 170,
                                  height: 44,
                                  radius: 6,
                                  textColor: Palette.primary,
                                  textSize: 14,
                                  onPressed: () {
                                    Provider.of<OwnerRequestDetailViewModel>(
                                            context,
                                            listen: false)
                                        .postCancel(id);
                                  },
                                ),
                              ],
                            ),
                          )
                  ],
                );
              })),
        ));
  }
}
