import 'package:birca/colors/mainColors.dart';
import 'package:flutter/material.dart';


//팬, 사장님 선택
class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingView();
}

class _OnBoardingView extends State<OnBoardingView> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
        body:
            Container(
                margin: EdgeInsets.only(top: 87),

                child: Center(

                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: '버카',
                                style: TextStyle(
                                    color: MainColors.main1,
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'PretendardBold'),
                              ),
                              TextSpan(
                                text: '입니다!\n어떻게 오셨나요?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 99,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("fan");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingView2()));
                            },
                            child: Image.asset('lib/assets/image/img_fan.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("owner");
                            },
                            child: Image.asset('lib/assets/image/img_cafe_owner.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            )

    );
  }
}

//방문자, 주최자 선택
class OnboardingView2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body:
            Container(

              margin: EdgeInsets.only(top: 87),

                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ElevatedButton(onPressed: (){}, child: Image.asset('lib/assets/image/btn_back.png')),
                      RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: '생일 카페',
                                style: TextStyle(
                                    color: MainColors.main1,
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'PretendardBold'),
                              ),
                              TextSpan(
                                text: '를\n어떻게 이용하실 건가요?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 99,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("fan_visitor");
                            },
                            child: Image.asset('lib/assets/image/img_fan_visitor.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("fan_host");
                            },
                            child: Image.asset('lib/assets/image/img_fan_host.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            )

    );

  }


}