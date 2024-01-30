import 'package:birca/colors/mainColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget{
  const OnBoardingView({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingView();

}

class _OnBoardingView extends State<OnBoardingView> {

  @override
  void initState() {
    super.initState();
  }

Widget build(BuildContext context){

    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(text: TextSpan(
              style: DefaultTextStyle.of(context).style,

              children: const [
                TextSpan(
                  text: '버카',
                  style: TextStyle(color: MainColors.main1,fontSize: 30,decoration: TextDecoration.none,fontFamily: 'PretendardBold' ),

                ),
                TextSpan(
                  text: '입니다!\n어떻게 오셨나요?',
                  style: TextStyle(color: Colors.black,fontSize: 26,decoration: TextDecoration.none,fontWeight: FontWeight.normal),

                ),
              ]
          ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 99,
          ),
          Row(
            children: [

              GestureDetector(
                onTap: (){

                  print("fan");
                },
                child:    Image.asset('lib/assets/image/img_fan.png'),

              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: (){

                  print("owner");
                },
                child:    Image.asset('lib/assets/image/img_cafe_owner.png'),

              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )

        ],
      ),)

    );
}

}