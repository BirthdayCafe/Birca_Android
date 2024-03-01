import 'package:birca/designSystem/text.dart';
import 'package:flutter/material.dart';

import '../../designSystem/palette.dart';

class VisitorFavorite extends StatefulWidget {
  const VisitorFavorite({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorFavorite();
}

class _VisitorFavorite extends State<VisitorFavorite> {
  bool isFavoriteExist = false;

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
                    text: '찜',
                    style: TextStyle(
                        color: Palette.primary,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '한 생일카페',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: 'PretendardMedium'),
                  ),
                ]),
          ),
        ),
        body: isFavoriteExist
            ? Container(
                width: double.infinity, // 화면 전체 너비
                height: double.infinity, // 화면 전체 높이
                color: const Color(0xffF7F7FA),
                child: const SingleChildScrollView())
            : Container(
                width: double.infinity, // 화면 전체 너비
                height: double.infinity, // 화면 전체 높이
                color: const Color(0xffF7F7FA),

                child: Container(
                  alignment: Alignment.center,
                  child: const BircaText(
                      text: '현재 찜한 카페가 없습니다',
                      textSize: 16,
                      textColor: Palette.gray06,
                      fontFamily: 'Pretendard'),
                ),
              ));
  }
}
