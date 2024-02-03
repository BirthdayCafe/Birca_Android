import 'package:birca/view/login/login.dart';
import 'package:birca/view/onboarding/onboardingView.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {

  KakaoSdk.init(
    nativeAppKey: '93a2601f6913f5b218bdc3d16ee0a3a8',

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
