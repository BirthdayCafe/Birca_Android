import 'package:birca/view/login/login.dart';
import 'package:birca/view/onboarding/onboardingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");	// 추가

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_APP_KEY'],

  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        textTheme:
            const TextTheme(bodyText2: TextStyle(color: Color(0xff303031))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // initialRoute: '/login',
      // routes: {
      //   '/login'
      // },
      home: Login(),
    );
  }
}
