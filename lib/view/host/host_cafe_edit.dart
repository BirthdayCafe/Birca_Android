import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';

class HostCafeEdit extends StatefulWidget {
  const HostCafeEdit({super.key});

  @override
  State<StatefulWidget> createState() => _HostCafeEdit();
}

class _HostCafeEdit extends State<HostCafeEdit> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '나의 생일 카페',
          style: TextStyle(
              fontSize: 16,
              color: Palette.gray10,
              fontFamily: 'Pretandard',
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 33,
            ),
            Image.asset(
              'lib/assets/image/img_cafe_test.png',
              height: 412,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20, right: 17, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '카페 이름',
                      style: TextStyle(
                          color: Palette.gray10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    SizedBox(
                        height: 10,
                        child: Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: isSwitched,
                              activeColor: Palette.primary,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                            ))),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: Palette.gray03,
              height: 1,
              margin: const EdgeInsets.only(left: 14, right: 14),
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                '실시간 혼잡도 및 특전',
                style: TextStyle(
                    color: Palette.gray10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xffF7F7FA),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BircaText(
                      text: '혼잡도',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'Pretendard'),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Palette.primary,
                    ),
                    child: const Text(
                      '포화',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard'),
                    ),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  const BircaText(
                      text: '특전',
                      textSize: 14,
                      textColor: Palette.gray10,
                      fontFamily: 'Pretendard'),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Palette.primary,
                    ),
                    child: const Text(
                      '재고 없음',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 40),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '카페 이름',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '아티스트 및 그룹명',
                      border: UnderlineInputBorder(), // 밑줄 추가
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    '주최자 정보',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '트위터 계정',
                      border: UnderlineInputBorder(), // 밑줄 추가
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    '생일 카페 주최 일정',
                    style: TextStyle(
                        color: Palette.gray10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
