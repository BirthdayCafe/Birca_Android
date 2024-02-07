import 'package:birca/view/login/login.dart';
import 'package:birca/view/onboarding/onboardingview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'designSystem/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env"); // 추가

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_APP_KEY'],
  );
  runApp(Birca());
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
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: Color(0xff303031))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
