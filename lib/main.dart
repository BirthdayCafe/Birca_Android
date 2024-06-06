import 'package:birca/viewModel/birthday_cafe_view_model.dart';
import 'package:birca/viewModel/host_home_view_model.dart';
import 'package:birca/viewModel/host_my_cafe_view_model.dart';
import 'package:birca/viewModel/host_search_result_view_model.dart';
import 'package:birca/viewModel/mypage_view_model.dart';
import 'package:birca/viewModel/owner_home_view_model.dart';
import 'package:birca/viewModel/owner_my_cafe_view_model.dart';
import 'package:birca/viewModel/owner_request_detail_view_model.dart';
import 'package:birca/viewModel/owner_schedule_view_model.dart';
import 'package:birca/viewModel/visitor_cafe_home_view_model.dart';
import 'package:birca/viewModel/visitor_cafe_like_view_model.dart';
import 'package:birca/viewmodel/select_favorite_artist_viewmodel.dart';
import 'package:birca/viewmodel/select_interest_artist_viewmodel.dart';
import 'package:birca/viewModel/business_license_view_model.dart';
import 'package:birca/viewModel/nickname_view_model.dart';
import 'package:birca/viewModel/visitor_search_result_view_model.dart';
import 'package:birca/widgets/bottom_nav_host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'designSystem/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env"); // 추가

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_APP_KEY'],
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BusinessLicenseViewModel()),
      ChangeNotifierProvider(create: (context) => NickNameViewModel()),
      ChangeNotifierProvider(
          create: (context) => VisitorSearchResultViewModel()),
      ChangeNotifierProvider(
          create: (context) => SelectFavoriteArtistViewModel()),
      ChangeNotifierProvider(
          create: (context) => SelectInterestArtistViewModel()),
      ChangeNotifierProvider(create: (context) => HostSearchResultViewModel()),
      ChangeNotifierProvider(create: (context) => VisitorCafeLikeViewModel()),
      ChangeNotifierProvider(create: (context) => VisitorCafeHomeViewModel()),
      ChangeNotifierProvider(create: (context) => BirthdayCafeViewModel()),
      ChangeNotifierProvider(create: (context) => HostMyCafeViewModel()),
      ChangeNotifierProvider(create: (context) => OwnerHomeViewModel()),
      ChangeNotifierProvider(
          create: (context) => OwnerRequestDetailViewModel()),
      ChangeNotifierProvider(create: (context) => MypageViewModel()),
      ChangeNotifierProvider(create: (context) => OwnerMyCafeViewModel()),
      ChangeNotifierProvider(create: (context) => HostHomeViewModel()),
      ChangeNotifierProvider(create: (context) => OwnerScheduleViewModel()),
    ],
    child: const Birca(),
  ));
}

class Birca extends StatelessWidget {
  const Birca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birca',
      theme: ThemeData(
        primaryColor: Palette.primary,
        fontFamily: "Pretendard",
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: Color(0xff303031))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const BottomNavHost(),
    );
  }
}
