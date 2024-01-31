import 'package:birca/colors/main_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            margin: const EdgeInsets.only(top: 87),
            child: Center(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: '버카',
                            style: TextStyle(
                                color: MainColors.main03,
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
                                fontFamily: 'PretendardMedium'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OnboardingView2()));
                        },
                        child: Image.asset('lib/assets/image/img_fan.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnboardingCafeOwnerView()));
                        },
                        child:
                            Image.asset('lib/assets/image/img_cafe_owner.png'),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}

//방문자, 주최자 선택
class OnboardingView2 extends StatelessWidget {
  const OnboardingView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 87),
            child: Center(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: '생일 카페',
                            style: TextStyle(
                                color: MainColors.main03,
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
                                fontFamily: 'PretendardMedium'),
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
                          // print("fan_visitor");
                        },
                        child:
                            Image.asset('lib/assets/image/img_fan_visitor.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // print("fan_host");
                        },
                        child: Image.asset('lib/assets/image/img_fan_host.png'),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}

//사장님 온보딩
class OnboardingCafeOwnerView extends StatefulWidget {
  const OnboardingCafeOwnerView({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingCafeOwnerView();
}

class _OnboardingCafeOwnerView extends State<OnboardingCafeOwnerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: '카페 정보',
                        style: TextStyle(
                            color: MainColors.main03,
                            fontSize: 30,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardBold'),
                      ),
                      TextSpan(
                        text: '를 등록해주세요',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                    ]),
              ),
              const Padding(padding: EdgeInsets.only(top: 52)),
              const Text(
                "사업자등록증",
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 16),
              ),
              const SizedBox(
                height: 18,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    foregroundColor: MainColors.main03, textStyle:
                        const TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
                    side: const BorderSide(color: MainColors.main03),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text(
                  '파일 업로드',
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '카페 이름',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: MainColors.main03)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '사장님 이름',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: MainColors.main03)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '사업자등록증 번호',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: MainColors.main03)
                  // )
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '카페 주소',
                style: TextStyle(fontFamily: 'PretendardMedium', fontSize: 14),
              ),
              const SizedBox(
                height: 11,
              ),
              const TextField(
                decoration: InputDecoration(
                  //비활성화
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7D8DC))),

                  //활성화
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: MainColors.main03)
                  // )
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xffBFC0C4),
                        ),
                        child: const Text('계정 요청하기'),
                      ))
                ],
              ),
              const SizedBox(height: 100,)
            ],
          ),
        )));
  }
}
