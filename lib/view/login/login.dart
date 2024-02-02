import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();

}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/image/img_logo.svg'),
            SvgPicture.asset('lib/assets/image/img_logo_text.svg'),
            SizedBox(height: 64,),
            Image.asset('lib/assets/image/kakao_login_medium_wide.png'),
            SizedBox(height: 40,),
            Image.asset('lib/assets/image/apple_login.png',width: 300,)

          ],
        ),
      ),
    );
  }

}