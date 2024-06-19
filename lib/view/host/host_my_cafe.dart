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

  @override
  void initState() {
    super.initState();
    Provider.of<HostMyCafeViewModel>(context, listen: false).getHostMyCafe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Container의 배경색
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1), // 그림자 색상
                              spreadRadius: 2, // 그림자 확산 정도
                              blurRadius: 2, // 그림자의 흐림 정도
                              // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 16),
                        height: 140,
                        child: Row(
                          children: [
                            Image.network(
                                viewModel
                                    .hostMyCafeModelList![index].mainImageUrl??'https://placehold.co/210x140/F7F7FA/F7F7FA.jpg',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      '${viewModel.hostMyCafeModelList?[index].artist.groupName} ${viewModel.hostMyCafeModelList?[index].artist.name}',
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
                                      '${viewModel.hostMyCafeModelList?[index].birthdayCafeName}',
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
                                            color: const Color(0xffFEC7C7)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              color: Palette.primary,
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
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Palette.primary))
                                          ],
                                        )))
                              ],
                            ))
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HostMyCafeDetail(
                                    cafeID: viewModel
                                        .hostMyCafeModelList![index]
                                        .birthdayCafeId)));
                      },
                      onLongPress: () {
                        _openCancelDialog(viewModel
                            .hostMyCafeModelList![index].birthdayCafeId);
                      },
                    );
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
                     await Provider.of<HostMyCafeViewModel>(context, listen: false)
                          .postCancel(cafeId).then((value) {

                       Provider.of<HostMyCafeViewModel>(context, listen: false).getHostMyCafe();

                       ScaffoldMessenger.of(context)
                           .showSnackBar(const SnackBar(content: Text('취소 완료')));
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
