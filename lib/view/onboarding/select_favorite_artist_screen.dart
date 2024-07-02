import 'package:birca/view/onboarding/select_interest_artist_screen.dart';
import 'package:birca/widgets/appbar.dart';
import 'package:birca/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewmodel/select_favorite_artist_viewmodel.dart';
import '../../widgets/button.dart';
import '../../widgets/progressbar.dart';

class SelectFavoriteArtistScreen extends StatefulWidget {
  const SelectFavoriteArtistScreen({super.key});

  @override
  SelectFavoriteArtistScreenState createState() =>
      SelectFavoriteArtistScreenState();
}

class SelectFavoriteArtistScreenState
    extends State<SelectFavoriteArtistScreen> {
  int expandedIndex = -1;
  late int location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: bircaAppBar(() {Navigator.pop(context);}), body: _content());
  }

  _content() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 6,
            child: progressBar(2 / 3)),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: SizedBox()),
            Text("2/3"),
            SizedBox(
              width: 30,
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 30),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: "최애 아티스트",
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Palette.primary)),
              TextSpan(
                  text: "를 선택하세요",
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      color: Palette.gray10))
            ]))),
        const SizedBox(
          height: 7,
        ),
        Container(
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              "* 최애 아티스트는 한 명만 선택할 수 있어요",
              style: TextStyle(
                  color: Palette.gray06,
                  fontFamily: 'Pretendard',
                  fontSize: 14),
            )),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<SelectFavoriteArtistViewModel>(
                builder: (context, model, _) => BircaOutLinedButton(
                      text: "그룹 아티스트",
                      radiusColor: Palette.primary,
                      backgroundColor: model.isSelectGroupArtist
                          ? Palette.primary
                          : Palette.white,
                      width: 176,
                      height: 36,
                      radius: 6,
                      textColor: model.isSelectSoloArtist
                          ? Palette.primary
                          : Palette.white,
                      textSize: 14,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (!model.isSelectGroupArtist) {
                          model.updateArtistType();
                        }
                      },
                    )),
            const SizedBox(
              width: 20,
            ),
            Consumer<SelectFavoriteArtistViewModel>(
                builder: (context, model, _) => BircaOutLinedButton(
                      text: "솔로 아티스트",
                      radiusColor: Palette.primary,
                      backgroundColor: model.isSelectSoloArtist
                          ? Palette.primary
                          : Palette.white,
                      width: 176,
                      height: 36,
                      radius: 6,
                      textColor: model.isSelectSoloArtist
                          ? Palette.white
                          : Palette.primary,
                      textSize: 14,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (!model.isSelectSoloArtist) {
                          model.updateArtistType();
                        }
                      },
                    )),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: Column(
            children: [
              Consumer<SelectFavoriteArtistViewModel>(
                  builder: (context, model, _) => Visibility(
                        visible: model.isSelectGroupArtist,
                        replacement: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: _soloArtistBuilder()),
                        child: Expanded(child: _groupArtistBuilder(model)),
                      )),
            ],
          ),
        ),
        _bottomBar()
      ]);

  _groupArtistBuilder(SelectFavoriteArtistViewModel model) => ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: model.groupArtistCount ~/ 4 + 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              if (index != 0)
                const SizedBox(
                  height: 30,
                ),
              if (index < model.groupArtistCount ~/ 4)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _groupArtistRow(index, 4),
                ),
              if (index == model.groupArtistCount ~/ 4)
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: _groupArtistRow(index, model.groupArtistCount % 4)),
              if (expandedIndex == index)
                AnimatedContainer(
                  width: double.infinity,
                  curve: Curves.bounceIn,
                  margin: const EdgeInsets.only(top: 20),
                  duration: const Duration(milliseconds: 150),
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 126,
                    child: CustomPaint(
                      child: Container(
                        color: Palette.gray02,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Consumer<SelectFavoriteArtistViewModel>(
                              builder: (context, model, _) =>
                                  ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: model.groupMemberCount,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                          width: 20); // 각 아이템 사이의 간격 설정
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          model.updateSelectedArtist(
                                              model.groupMember![index]);
                                        },
                                        child: artistItem(
                                          model.groupMember![index].groupImage,
                                          model.groupMember![index].groupName,
                                        ),
                                      );
                                    },
                                  ))),
                    ),
                  ),
                )
            ],
          );
        },
      );

  _groupArtistRow(int index, int itemCount) => Row(
      mainAxisAlignment: (itemCount == 4)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: List.generate(
          itemCount,
          (itemIndex) => (itemCount == 4)
              ? _groupArtistItem(index, itemIndex + 1)
              : Padding(
                  padding: const EdgeInsets.only(right: 31), // 오른쪽 간격 지정
                  child: _groupArtistItem(index, itemIndex + 1),
                )));

  _groupArtistItem(int index, int location) =>
      Consumer<SelectFavoriteArtistViewModel>(
          builder: (context, model, _) => GestureDetector(
                onTap: () {
                  model.getGroupMember(
                      model.groupArtist![(index * 4 + location) - 1].groupId);
                  setState(() {
                    if (expandedIndex == index) {
                      expandedIndex = -1;
                    } else {
                      expandedIndex = index;
                      this.location = location;
                    }
                  });
                },
                child: artistItem(
                    model.groupArtist![(index * 4 + location) - 1].groupImage,
                    model.groupArtist![(index * 4 + location) - 1].groupName),
              ));

  _soloArtistBuilder() => Consumer<SelectFavoriteArtistViewModel>(
        builder: (context, model, _) => GridView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.soloArtistCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                model.updateSelectedArtist(model.soloArtist![index]);
              },
              child: artistItem(model.soloArtist![index].groupImage,
                  model.soloArtist![index].groupName),
            );
          },
        ),
      );

  _bottomBar() => Consumer<SelectFavoriteArtistViewModel>(
      builder: (context, model, _) => Container(
          color: Palette.gray02,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectedArtist(),
              Container(
                  width: double.infinity,
                  height: 46,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: BircaElevatedButton(
                    text: "최애 아티스트 결정하기",
                    color: (model.selectedArtist.isEmpty)
                        ? Palette.gray04
                        : Palette.primary,
                    fontSize: 18,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      if (model.selectedArtist.isNotEmpty) {
                        model.postFavoriteArtist();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SelectInterestArtistScreen()));
                      }
                    },
                  )),
              const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {
              //     MaterialPageRoute(
              //         builder: (context) => const SelectInterestArtistScreen());
              //   },
              //   child: const Text(
              //     "다음에 결정하기",
              //     style: TextStyle(
              //       color: Palette.gray06,
              //       fontFamily: 'Pretendard',
              //       decoration: TextDecoration.underline,
              //       decorationColor: Palette.gray06,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 66),
            ],
          )));

  _selectedArtist() => Consumer<SelectFavoriteArtistViewModel>(
      builder: (context, model, _) => Container(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24),
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  model.selectedArtist.length,
                  (index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            model.removeSelectedArtist(
                                model.selectedArtist[index]);
                          },
                          child: artistItem(
                              model.selectedArtist[index].groupImage,
                              model.selectedArtist[index].groupName),
                        ));
                  },
                ),
              ),
            ),
          ));
}
