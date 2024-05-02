import 'package:birca/designSystem/palette.dart';
import 'package:birca/view/host/host_chatting.dart';
import 'package:birca/view/host/host_home.dart';
import 'package:birca/view/host/host_my_cafe.dart';
import 'package:birca/view/host/host_mypage.dart';
import 'package:flutter/material.dart';

class BottomNavHost extends StatefulWidget {
  const BottomNavHost({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavHost();

}

class _BottomNavHost extends State<BottomNavHost> {

  int _selectedIndex = 0;

  //위젯 선언
  final List<Widget> _widgetOptions = <Widget>[
    const HostHome(),
    const HostChatting(),
    const HostCafe(),
    const HostMyPage()
  ];

  void _onItemTapped(int index) { // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:  _widgetOptions.elementAt(_selectedIndex),
      ) ,
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 애니메이션 비활성화

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,size: 30,) ,label:'홈' ),
          BottomNavigationBarItem(icon: Icon(Icons.chat,size: 30) ,label:'채팅' ),
          BottomNavigationBarItem(icon: Icon(Icons.cake_rounded,size: 30) ,label:'생일카페' ),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity,size: 30) ,label:'마이페이지' ),],

        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_cafe_tour.svg') ,label:'카페 투어' ),
        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_mypage.svg') ,label:'마이페이지' ),],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.primary,
      ),
    );




  }
}