import 'package:birca/view/visitor/visitor_home.dart';
import 'package:birca/viewmodel/select_favorite_artist_viewmodel.dart';
import 'package:birca/viewmodel/select_interest_artist_viewmodel.dart';
import 'package:birca/viewModel/business_license_view_model.dart';
import 'package:birca/viewModel/nickname_view_model.dart';
import 'package:birca/viewModel/visitor_home_view_model.dart';
import 'package:birca/viewModel/visitor_search_result_view_model.dart';
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
      ChangeNotifierProvider(create: (context) => VisitorHomeViewModel()),
      ChangeNotifierProvider(
          create: (context) => SelectFavoriteArtistViewModel()),
      ChangeNotifierProvider(
          create: (context) => SelectInterestArtistViewModel()),
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
      home: const VisitorHome(),
    );
  }
}
