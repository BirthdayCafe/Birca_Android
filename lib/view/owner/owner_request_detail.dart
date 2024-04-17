import 'package:birca/designSystem/palette.dart';
import 'package:birca/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'owner_chatting.dart';
import 'owner_home.dart';
import 'owner_mypage.dart';
import 'owner_schedule.dart';

class OwnerRequestDetail extends StatefulWidget{
  const OwnerRequestDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OwnerRequestDetail();
  }
  
}

class _OwnerRequestDetail extends State<OwnerRequestDetail>{

  bool isRequestAccept = false;

  int _selectedIndex = 0;

  bool isTab = false;

  final List<Widget> _widgetOptions = <Widget>[
    const OwnerHome(),
    const OwnerChatting(),
    const OwnerSchedule(),
    const OwnerMypage()
  ];

  void _onItemTapped(int index) {
    // 탭을 클릭했을때 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
      isTab = true;
    });
  }

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
      body:  isTab
          ? _widgetOptions.elementAt(_selectedIndex)
          :SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top:28),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("아티스트",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10),),

              ),

              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("뉴진스 민지",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              Container(
                margin: const EdgeInsets.only(left: 14,right: 183),
                child:   const Divider(color: Palette.gray03,),

              ),              const SizedBox(height: 24,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("신청자",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10),),

              ),

              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("홍길동",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              Container(
                margin: const EdgeInsets.only(left: 14,right: 183),
                child:   const Divider(color: Palette.gray03,),

              ),
              const SizedBox(height: 24,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("생일카페 주최 일정",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10),),

              ),
              const SizedBox(height: 16,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                width: 238,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffD7D8DC)),
                  borderRadius: BorderRadius.circular(2), // 테두리 굴곡 설정
                ),
                alignment: Alignment.center,
                child: const Text(
                  '2020.02.02~2020.02.02',
                  style: TextStyle(
                    fontSize: 14,
                    color: Palette.gray08

                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("예상 방문자",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              const SizedBox(height: 16,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("최소 10명, 최대 20명",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("생일 카페 트위터 계정",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              const SizedBox(height: 16,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("@qq",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("핸드폰 번호",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),
              const SizedBox(height: 16,),
              Container(
                margin: const EdgeInsets.only(left: 14),
                child:
                const Text("000-0000-0000",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,fontFamily: 'Pretendard',color: Palette.gray10)),

              ),

              const SizedBox(height: 47,),

              isRequestAccept?
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40,
                    color: Palette.gray02,
                    child: const Text(
                      '요청 수락이 완료된 글입니다.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        color: Palette.gray06
                      ),
                    ),
                  )
              :Container(
                margin: const EdgeInsets.only(left: 19,right: 19),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BircaOutLinedButton(text:'요청 수락', radiusColor: Palette.primary, backgroundColor: Palette.primary, width: 170, height: 44, radius: 6, textColor: Colors.white, textSize: 14,onPressed: (){
                      setState(() {
                        isRequestAccept=true;
                      });
                    },),
                    const BircaOutLinedButton(text:'요청 거절', radiusColor: Palette.primary, backgroundColor: Colors.white, width: 170, height: 44, radius: 6, textColor: Palette.primary, textSize: 14)

                  ],
                ) ,
              )

            ],

          ),
        )

      ),
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 애니메이션 비활성화

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,size: 30,) ,label:'홈' ),
          BottomNavigationBarItem(icon: Icon(Icons.chat,size: 30) ,label:'채팅' ),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded,size: 30) ,label:'스케줄' ),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity,size: 30) ,label:'마이페이지' ),],

        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.primary,
      ),

    );
  }
  
}