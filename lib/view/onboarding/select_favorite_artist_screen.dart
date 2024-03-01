import 'dart:developer';

import 'package:birca/model/artist_model.dart';
import 'package:birca/viewmodel/select_artist_viewmodel.dart';
import 'package:birca/widgets/appbar.dart';
import 'package:birca/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../designSystem/palette.dart';
import '../../widgets/button.dart';
import '../../widgets/card.dart';
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
    return Scaffold(appBar: bircaAppBar(() {}), body: _content());
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
            Consumer<SelectArtistViewModel>(
                builder: (context, model, _) => BircaOutLinedButton(
                      text: "그룹 아티스트",
                      radiusColor: Palette.primary,
                      backgroundColor: model.isSelectGroupArtist
                          ? Palette.primary
                          : Palette.background,
                      width: 176,
                      height: 36,
                      radius: 6,
                      textColor: Palette.gray10,
                      textSize: 14,
                      onPressed: () {
                        if (!model.isSelectGroupArtist) {
                          model.updateArtistType();
                        }
                      },
                    )),
            const SizedBox(
              width: 20,
            ),
            Consumer<SelectArtistViewModel>(
                builder: (context, model, _) => BircaOutLinedButton(
                      text: "솔로 아티스트",
                      radiusColor: Palette.primary,
                      backgroundColor: model.isSelectSoloArtist
                          ? Palette.primary
                          : Palette.background,
                      width: 176,
                      height: 36,
                      radius: 6,
                      textColor: Palette.gray10,
                      textSize: 14,
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
              Consumer<SelectArtistViewModel>(
                  builder: (context, model, _) => Visibility(
                        visible: model.isSelectGroupArtist,
                        replacement: _soloArtistBuilder(),
                        child: Expanded(child: _groupArtistBuilder(model)),
                      )),
            ],
          ),
        ),
        _bottomBar()
      ]);

  _groupArtistBuilder(SelectArtistViewModel model) => ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: model.soloArtistCount,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              if (index != 0)
                const SizedBox(
                  height: 30,
                ),
              _groupArtistRow(index, 4),
              if(index == model.soloArtistCount-1)
                Column(
                  children: [
                    const SizedBox(height: 30),
                    _groupArtistRow(index, model.soloArtistCount%4)
                  ],
                ),
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
                          child: artistItem(
                              'lib/assets/image/artist.svg', "BTS $index")),
                    ),
                  ),
                ),
            ],
          );
        },
      );

  _groupArtistRow(int index, int itemCount) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        itemCount,
        (itemIndex) {
          return _groupArtistItem(index, itemIndex + 1);
        },
      ));

  _groupArtistItem(int index, int location) => GestureDetector(
        onTap: () {
          log((index * 4 + location).toString());
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
            'lib/assets/image/artist.svg', "BS ${(index * 4 + location) - 1}"),
      );

  _soloArtistBuilder() => Consumer<SelectArtistViewModel>(
        builder: (context, model, _) => GridView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.soloArtistCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            mainAxisSpacing: 24,
            // crossAxisSpacing:
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // log(index.toString());
              },
              child: artistItem('lib/assets/image/artist.svg',
                  model.artistModel![index].groupName),
            );
          },
        ),
      );

  _bottomBar() => Container(
        color: Colors.white,
        height: 160,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 46,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: BircaElevatedButton(
                  text: "최애 아티스트 결정하기",
                  color: Palette.gray04,
                  fontSize: 18,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    Provider.of<SelectArtistViewModel>(context, listen: false)
                        .getGroupArtist();
                  },
                )),
            const SizedBox(height: 20),
            const Text(
              "다음에 결정하기",
              style: TextStyle(
                color: Palette.gray06,
                fontFamily: 'Pretendard',
                decoration: TextDecoration.underline,
                decorationColor: Palette.gray06,
              ),
            )
          ],
        ),
      );
}
