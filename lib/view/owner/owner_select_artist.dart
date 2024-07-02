import 'package:birca/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewmodel/select_favorite_artist_viewmodel.dart';
import '../../widgets/button.dart';
import '../../widgets/card.dart';

class OwnerSelectArtist extends StatefulWidget {
  const OwnerSelectArtist({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerSelectArtist();
}

class _OwnerSelectArtist
    extends State<OwnerSelectArtist> {
  int expandedIndex = -1;
  late int location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      scrolledUnderElevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
    ),
        body: _content());
  }

  _content() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

        Container(
            margin: const EdgeInsets.only(left: 30),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: "아티스트",
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
        Container(
            child: _bottomBar(),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ))      ]);

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
                      painter: BubblePainter(idx: location),
                      child: Container(
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
          color: Colors.white,
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
                    text: "아티스트 결정하기",
                    color: (model.selectedArtist.isEmpty)
                        ? Palette.gray04
                        : Palette.primary,
                    fontSize: 18,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      if (model.selectedArtist.isNotEmpty) {
                        Map<String, dynamic> data = {
                          'id': model.selectedArtist[0].groupId,
                          'artist': model.selectedArtist[0].groupName,
                        };
                        Navigator.pop(context,data);
                      }
                    },
                  )),
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
                          child: artistSelectedItem(
                              model.selectedArtist[index].groupImage,
                              model.selectedArtist[index].groupName),
                        ));
                  },
                ),
              ),
            ),
          ));
}
