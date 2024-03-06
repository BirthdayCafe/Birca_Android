import 'package:birca/designSystem/palette.dart';
import 'package:birca/view/visitor/visitor_cafe_tour.dart';
import 'package:birca/view/visitor/visitor_favorite.dart';
import 'package:birca/view/visitor/visitor_home.dart';
import 'package:birca/view/visitor/visitor_mypage.dart';
import 'package:flutter/material.dart';

class BottomNavVisitor extends StatefulWidget {
  const BottomNavVisitor({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavVisitor();

}

class _BottomNavVisitor extends State<BottomNavVisitor> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const VisitorHome(),
    const VisitorFavorite(),
    const VisitorCafeTour(),
    const VisitorMyPage()
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 30) ,label:'찜한 카페' ),
          BottomNavigationBarItem(icon: Icon(Icons.edit_location_alt_outlined,size: 30) ,label:'카페 투어' ),
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