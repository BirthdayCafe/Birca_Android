import 'package:birca/view/host/host_my_cafe_detail.dart';
import 'package:birca/viewModel/host_my_cafe_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';

class HostCafe extends StatefulWidget {
  const HostCafe({super.key});

  @override
  State<StatefulWidget> createState() => _HostCafe();
}

class _HostCafe extends State<HostCafe> {
  bool isCafeExist = true;
  Color? stateBackgroundColor;
  Color? stateTextColor;
  Color? stateIconColor;

  @override
  void initState() {
    super.initState();
    Provider.of<HostMyCafeViewModel>(context, listen: false).getHostMyCafe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 자동으로 leading 버튼 생성 방지
          centerTitle: false, // 타이틀 왼쪽 정렬 설정
          scrolledUnderElevation: 0,
          title: RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: '나의',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: ' 생일카페',
                    style: TextStyle(
                        color: Palette.primary,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardMedium',
                        fontWeight: FontWeight.w700),
                  ),
                ]),
          ),
        ),
        body: Consumer<HostMyCafeViewModel>(
            builder: (context, viewModel, widget) {
          if (viewModel.hostMyCafeModelList != null) {
            return SizedBox(
              width: double.infinity, // 화면 전체 너비
              height: double.infinity, // 화면 전체 높이

              child: ListView.builder(
                  itemCount: viewModel.hostMyCafeModelList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    switch (
                        viewModel.hostMyCafeModelList?[index].progressState) {
                      case 'RENTAL_PENDING':
                        stateBackgroundColor = Palette.gray03;
                        stateIconColor = Palette.gray06;
                        stateTextColor = Palette.gray06;
                      case 'IN_PROGRESS':
                        stateBackgroundColor = const Color(0xFFB3FFA0);
                        stateIconColor = const Color(0xFF33D00C);
                        stateTextColor = const Color(0xFF33D00C);
                      case 'RENTAL_APPROVED':
                        stateBackgroundColor = const Color(0xFFFEC7C7);
                        stateIconColor = Palette.primary;
                        stateTextColor = Palette.primary;
                      case 'RENTAL_CANCELED':
                        stateBackgroundColor = Palette.gray03;
                        stateIconColor = Palette.gray06;
                        stateTextColor = Palette.gray06;
                    }

                    if (viewModel.hostMyCafeModelList?[index].progressState ==
                            'RENTAL_CANCELED' ||
                        viewModel.hostMyCafeModelList?[index].progressState ==
                            'FINISHED') {
                      String message = '';
                      if (viewModel.hostMyCafeModelList?[index].progressState ==
                          'RENTAL_CANCELED') {
                        message = '취소되었습니다.';
                      } else {
                        message = '운영이 종료되었습니다.';
                      }
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Container의 배경색
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  // 그림자 색상
                                  spreadRadius: 2,
                                  // 그림자 확산 정도
                                  blurRadius: 2, // 그림자의 흐림 정도
                                  // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 16, right: 16),
                            height: 140,
                            child: Row(
                              children: [
                                Image.network(
                                    viewModel.hostMyCafeModelList![index]
                                            .mainImageUrl ??
                                        'https://placehold.co/210x140/F7F7FA/F7F7FA.jpg',
                                    height: 140,
                                    width: 210,
                                    fit: BoxFit.cover),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          '${viewModel.hostMyCafeModelList?[index].artist.groupName ?? ''} ${viewModel.hostMyCafeModelList?[index].artist.name}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Palette.primary,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Pretendard"),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${viewModel.hostMyCafeModelList?[index].startDate.toString().substring(0, viewModel.hostMyCafeModelList![index].startDate.toString().length - 9)} ~ ${viewModel.hostMyCafeModelList?[index].endDate.toString().substring(0, viewModel.hostMyCafeModelList![index].endDate.toString().length - 9)}',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Palette.gray10,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Pretendard"),
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Text(
                                          viewModel.hostMyCafeModelList?[index]
                                                  .birthdayCafeName ??
                                              '카페 이름을 입력해주세요',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Palette.gray08,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Pretendard"),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                        top: 6,
                                        right: 6,
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 8,
                                                left: 6),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: stateBackgroundColor),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: stateIconColor,
                                                  size: 10,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                    viewModel
                                                        .getProgressStateInKorean(
                                                            viewModel
                                                                .hostMyCafeModelList![
                                                                    index]
                                                                .progressState),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: stateTextColor))
                                              ],
                                            )))
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 140,
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                // 투명도 조절
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              message,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      );
                    } else {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Container의 배경색
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                // 그림자 색상
                                spreadRadius: 2,
                                // 그림자 확산 정도
                                blurRadius: 2, // 그림자의 흐림 정도
                                // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 16),
                          height: 140,
                          child: Row(
                            children: [
                              Image.network(
                                  viewModel.hostMyCafeModelList![index]
                                          .mainImageUrl ??
                                      'https://placehold.co/210x140/F7F7FA/F7F7FA.jpg',
                                  height: 140,
                                  width: 210,
                                  fit: BoxFit.fill),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        '${viewModel.hostMyCafeModelList?[index].artist.groupName ?? ''} ${viewModel.hostMyCafeModelList?[index].artist.name}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Palette.primary,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Pretendard"),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${viewModel.hostMyCafeModelList?[index].startDate.toString().substring(0, viewModel.hostMyCafeModelList![index].startDate.toString().length - 9)} ~ ${viewModel.hostMyCafeModelList?[index].endDate.toString().substring(0, viewModel.hostMyCafeModelList![index].endDate.toString().length - 9)}',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Palette.gray10,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Pretendard"),
                                      ),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                      Text(
                                        viewModel.hostMyCafeModelList?[index]
                                                .birthdayCafeName ??
                                            '카페 이름을 입력해주세요',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Palette.gray08,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Pretendard"),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                      top: 6,
                                      right: 6,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 2,
                                              bottom: 2,
                                              right: 8,
                                              left: 6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: stateBackgroundColor),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: stateIconColor,
                                                size: 10,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  viewModel
                                                      .getProgressStateInKorean(
                                                          viewModel
                                                              .hostMyCafeModelList![
                                                                  index]
                                                              .progressState),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: stateTextColor))
                                            ],
                                          )))
                                ],
                              ))
                            ],
                          ),
                        ),
                        onTap: () {
                          if (viewModel
                                  .hostMyCafeModelList![index].progressState ==
                              'RENTAL_PENDING') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('승인 대기 중 입니다.')));
                          } else  {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HostMyCafeDetail(
                                        cafeID: viewModel
                                            .hostMyCafeModelList![index]
                                            .birthdayCafeId)));
                          }
                        },
                        onLongPress: () {
                          if (viewModel
                                  .hostMyCafeModelList![index].progressState ==
                              'RENTAL_PENDING') {
                            _openCancelDialog(viewModel
                                .hostMyCafeModelList![index].birthdayCafeId);

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('이미 승인된 카페는 취소할 수 없습니다.')));
                          }
                        },
                      );
                    }
                  }),
            );
          } else {
            return Container(
              width: double.infinity, // 화면 전체 너비
              height: double.infinity, // 화면 전체 높이
              color: const Color(0xffF7F7FA),

              child: Container(
                alignment: Alignment.center,
                child: const BircaText(
                    text: '대관을 요청해보세요!',
                    textSize: 16,
                    textColor: Palette.gray06,
                    fontFamily: 'Pretendard'),
              ),
            );
          }
        }));
  }

  void _openCancelDialog(int cafeId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '카페 대관을 취소하시겠습니까?',
            style: TextStyle(
                fontSize: 16,
                color: Palette.gray10,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      await Provider.of<HostMyCafeViewModel>(context,
                              listen: false)
                          .postCancel(cafeId)
                          .then((value) {
                        Provider.of<HostMyCafeViewModel>(context, listen: false)
                            .getHostMyCafe();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('취소 완료')));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("네",
                        style: TextStyle(
                            fontSize: 16,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("아니요",
                        style: TextStyle(
                            fontSize: 16,
                            color: Palette.gray10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500))),
              ],
            )
          ],
        );
      },
    );
  }
}
