import 'package:birca/viewModel/host_search_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../designSystem/text.dart';

class HostSearchResult extends StatefulWidget {
  const HostSearchResult({super.key});

  @override
  State<StatefulWidget> createState() => _HostSearchResult();
}

class _HostSearchResult extends State<HostSearchResult>{

  var searchResult =['a','a','a','a'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title:Consumer<HostSearchResultViewModel>(builder: (context,viewModel,child){
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
                margin:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                // padding: const EdgeInsets.all(8),
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
                      width: 210,
                      child: Image.asset(
                        'lib/assets/image/img_cafe_test.png',
                        fit: BoxFit.fill,
                      ),
                    ),

                    //카페 정보

                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 40),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '카페 이름',
                            style: TextStyle(
                                fontSize: 14,
                                color: Palette.gray10,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          Text(
                            '@twitter',
                            style: TextStyle(
                                fontSize: 12,
                                color: Palette.gray08,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Palette.gray08,
                                size: 12,
                              ),
                              Text(
                                '서울특별시~~',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.gray08,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(child: Container()),

                    //heart
                    Container(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: const Icon(
                        Icons.favorite,
                        color: Color(0xffF3F3F3),
                      ),
                    )
                  ],
                ),
              );
            })
    );
  }

}