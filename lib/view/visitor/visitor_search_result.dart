import 'package:birca/designSystem/palette.dart';
import 'package:birca/designSystem/text.dart';
import 'package:birca/viewModel/visitor_search_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class VisitorSearchResult extends StatefulWidget {
  const VisitorSearchResult({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorSearchResult();
}

class _VisitorSearchResult extends State<VisitorSearchResult> {


  var searchResult =['a','a','a','a'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title:Consumer<VisitorSearchResultViewModel>(builder: (context,viewModel,child){
          return BircaText(text: '"${viewModel.search}" 검색 결과', textSize: 18, textColor: Palette.gray10, fontFamily: 'Pretednard');
        }) ,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),


      ),
      body:  ListView.builder(
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: searchResult.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white, // Container의 배경색
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // 그림자 색상
                    spreadRadius: 1, // 그림자 확산 정도
                    blurRadius: 1, // 그림자의 흐림 정도
                    // offset: Offset(0, 3), // 그림자의 위치 조절 (가로, 세로)
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //이미지
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Image.asset(
                        'lib/assets/image/img_cafe_test.png'),
                  ),

                  //카페 정보
                  Container(
                    height: 140,
                    margin: const EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // Text('샤이니 민호'),
                        const BircaText(
                            text: '샤이니 민호',
                            textSize: 12,
                            textColor: Palette.gray08,
                            fontFamily: 'Pretendard'),

                        // Text('1월 1일~1월 2일'),
                        const BircaText(
                          text: '1월 1일~1월 2일',
                          textSize: 12,
                          textColor: Palette.gray08,
                          fontFamily: 'Pretendard',
                        ),
                        // Text('카페 이름'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'cafe name',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                        Expanded(child: Container()),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Palette.gray08,
                              size: 20,
                            ),
                            Text(
                              '서울 서초구 서초대로',
                              style: TextStyle(
                                color: Palette.gray08,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle
                                    .solid, // 밑줄의 스타일
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(child: Container()),

                  //heart
                  const Icon(
                    Icons.favorite,
                    color: Color(0xffF3F3F3),
                  )
                ],
              ),
            );
          })

    );
  }

}