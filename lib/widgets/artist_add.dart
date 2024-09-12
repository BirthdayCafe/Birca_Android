import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../designSystem/palette.dart';
import '../designSystem/text.dart';

class ArtistAdd extends StatefulWidget {
  const ArtistAdd({super.key});

  @override
  State<StatefulWidget> createState() => _ArtistAdd();
}

class _ArtistAdd extends State<ArtistAdd> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const BircaText(
                text: '원하는 아티스트를 요청해보세요!',
                textSize: 20,
                textColor: Palette.primary,
                fontFamily: 'PretendardBold'),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset('lib/assets/image/img_complete.svg'),
            const SizedBox(
              height: 50,
            ),

            const BircaText(
                text: '최애의 아티스트가 없다면',
                textSize: 18,
                textColor: Palette.primary,
                fontFamily: 'PretendardSemiBold'),
            const BircaText(
                text: '아래의 이메일로 추가 요청 해주세요!',
                textSize: 18,
                textColor: Palette.primary,
                fontFamily: 'PretendardSemiBold'),
            const BircaText(
                text: 'tmdrbs8846@gmail.com',
                textSize: 16,
                textColor: Palette.gray08,
                fontFamily: 'PretendardRegular'),
            const SizedBox(
              height: 120,
            ),

          ],
        ),
      )

    );
  }
}
