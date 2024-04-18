import 'package:birca/designSystem/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerHome();
}

class _OwnerHome extends State<OwnerHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  var requestList = ['aaa', 'bbb', 'cc', 'd', 'e', 'f', 'g' 'h', 'i', 'j'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: SvgPicture.asset('lib/assets/image/birca.svg'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: "대관 요청"), Tab(text: "대관 완료")],
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Pretendard',
              color: Palette.primary),
          // 선택된 탭의 글꼴 스타일 설정
          unselectedLabelStyle:
              const TextStyle(fontSize: 16, color: Palette.gray10),
          // 선택되지 않은 탭의 글꼴 스타일 설정
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Palette.primary)),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // height: 140,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 14,right: 14,top: 19),
                  padding: const EdgeInsets.only(left: 26,top: 31,bottom: 28.5),
                  decoration: BoxDecoration(
                    color: Palette.gray02, // Container의 배경색
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("아티스트 : 뉴진스 민지",style: TextStyle(color: Palette.primary,fontFamily: 'Pretendard',fontWeight: FontWeight.w700,fontSize: 14),),
                      SizedBox(height: 13.5,),
                      Text("닉네임 : 홍길동",style: TextStyle(color: Palette.gray10,fontFamily: 'Pretendard',fontWeight:FontWeight.w500,fontSize: 14),),
                      SizedBox(height: 13.5,),
                      Text("일정 : 2024.01.01~2024.01.01",style: TextStyle(color: Palette.gray10,fontFamily: 'Pretendard',fontWeight:FontWeight.w500,fontSize: 14),)

                    ],

                  ),
                );
              }),
          ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // height: 140,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 14,right: 14,top: 19),
                  padding: const EdgeInsets.only(left: 26,top: 31,bottom: 28.5),
                  decoration: BoxDecoration(
                    color: Palette.gray02, // Container의 배경색
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("아티스트 : 뉴진스 민지",style: TextStyle(color: Palette.primary,fontFamily: 'Pretendard',fontWeight: FontWeight.w700,fontSize: 14),),
                      SizedBox(height: 13.5,),
                      Text("닉네임 : 홍길동",style: TextStyle(color: Palette.gray10,fontFamily: 'Pretendard',fontWeight:FontWeight.w500,fontSize: 14),),
                      SizedBox(height: 13.5,),
                      Text("일정 : 2024.01.01~2024.01.01",style: TextStyle(color: Palette.gray10,fontFamily: 'Pretendard',fontWeight:FontWeight.w500,fontSize: 14),)

                    ],

                  ),
                );
              }),
        ],
      ),
    );
  }
}
