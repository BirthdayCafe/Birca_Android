import 'package:birca/widgets/appbar.dart';
import 'package:birca/widgets/item.dart';
import 'package:flutter/material.dart';

import '../../designSystem/palette.dart';
import '../../widgets/button.dart';
import '../../widgets/card.dart';
import '../../widgets/progressbar.dart';

class SelectFavoriteArtistScreen extends StatefulWidget {
  const SelectFavoriteArtistScreen({super.key});

  @override
  SelectFavoriteArtistScreenState createState() => SelectFavoriteArtistScreenState();
}

class SelectFavoriteArtistScreenState extends State<SelectFavoriteArtistScreen> {
  int expandedIndex = -1;
  late int location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bircaAppBar(() {
          Navigator.pop(context);
        }),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Text(
                  "그룹 아티스트",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      color: Palette.gray10),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: _listviewBuilder()),
              Container(
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
                      child: const BircaElevatedButton(
                                text: "최애 아티스트 결정하기",
                                color: Palette.gray04,
                                fontSize: 18,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    const Text(
                      "다음에 결정하기",
                      style: TextStyle(
                        color: Palette.gray06,
                        fontFamily: 'Pretendard',
                        decoration: TextDecoration.underline,
                        decorationColor: Palette.gray06,),)
                  ],),)]));
  }

  Widget _listviewBuilder() => ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              if (index != 0)
                const SizedBox(
                  height: 30,
                ),
              _listviewRow(index),
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

  Widget _listviewRow(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _listViewItem(index, 1),
          const SizedBox(width: 24),
          _listViewItem(index, 2),
          const SizedBox(width: 24),
          _listViewItem(index, 3),
          const SizedBox(width: 24),
          _listViewItem(index, 4)
        ],
      );

  Widget _listViewItem(int index, int location) => GestureDetector(
        onTap: () {
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
            'lib/assets/image/artist.svg', "BS ${index * 4 + location}"),
      );
}
