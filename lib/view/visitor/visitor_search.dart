import 'package:birca/view/visitor/visitor_cafe_tour.dart';
import 'package:birca/view/visitor/visitor_favorite.dart';
import 'package:birca/view/visitor/visitor_home.dart';
import 'package:birca/view/visitor/visitor_mypage.dart';
import 'package:flutter/material.dart';
import '../../designSystem/palette.dart';

class VisitorSearch extends StatefulWidget {
  const VisitorSearch({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorSearch();
}

class _VisitorSearch extends State<VisitorSearch> {
  int _selectedIndex = 0;

  bool isTab = false;

  TextEditingController searchController = TextEditingController();

  final List<Widget> _widgetOptions = <Widget>[
    const VisitorHome(),
    const VisitorFavorite(),
    const VisitorCafeTour(),
    const VisitorMyPage()
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
      body: SafeArea(
          child: isTab
              ? _widgetOptions.elementAt(_selectedIndex)
              : Column(
                  children: [
                    Container(
                        margin:
                            const EdgeInsets.only(left: 17, right: 17, top: 30),
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              // height: 40,
                              // width: 350,
                              child: TextField(
                                controller: searchController,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(fontSize: 14),
                                onChanged: (text) {},
                                decoration: const InputDecoration(
                                  //비활성화
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.primary),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(37))),

                                  //활성화
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.primary),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(37))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Palette.primary,
                                size: 25,
                              ),
                            )
                          ],
                        ))
                  ],
                )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // 애니메이션 비활성화

        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 30,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30), label: '찜한 카페'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_location_alt_outlined, size: 30),
              label: '카페 투어'),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity, size: 30), label: '마이페이지'),
        ],

        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_cafe_tour.svg') ,label:'카페 투어' ),
        // BottomNavigationBarItem(icon:SvgPicture.asset('lib/assets/image/img_bottom_nav_mypage.svg') ,label:'마이페이지' ),],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.primary,
      ),
    );
  }
}
