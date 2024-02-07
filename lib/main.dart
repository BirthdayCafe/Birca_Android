import 'package:birca/view/onboarding/onboardingview.dart';
import 'package:flutter/material.dart';

import 'assets/designsystem/palette.dart';

void main() => runApp(const Birca());

class Birca extends StatelessWidget {
  const Birca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birca',
      theme: ThemeData(
        primaryColor: Palette.primary,
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xff303031))
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const OnBoardingView(),
    );
  }
}
