import 'package:birca/assets/designSystem/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../assets/colors/mainColors.dart';
import '../../assets/designSystem/text.dart';

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
    print('온보딩 시작');
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
                                    builder: (context) =>
                                        const OnboardingView2()));
                          },
                          child: Image.asset('lib/assets/image/img_fan.png')),
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
                          child: Image.asset(
                              'lib/assets/image/img_cafe_owner.png')),
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
                          onTap: () {},
                          child: Image.asset(
                              'lib/assets/image/img_fan_visitor.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OnboardingFanHostView()));
                          },
                          child:
                              Image.asset('lib/assets/image/img_fan_host.png')),
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
                    textStyle: const TextStyle(
                        fontFamily: 'PretendardMedium', fontSize: 14),
                    primary: MainColors.main03,
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OnboardingCafeOwnerCompleteView()));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xffBFC0C4),
                        ),
                        child: const Text('계정 요청하기'),
                      ))
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        )));
  }
}

//카페 사장 온보딩 완료
class OnboardingCafeOwnerCompleteView extends StatelessWidget {
  const OnboardingCafeOwnerCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          const BircaText(
              text: '곧 버카에서 만나요!',
              textSize: 20,
              textColor: MainColors.main03,
              fontFamily: 'PretendardBold'),
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset('lib/assets/image/img_complete.svg'),
          const SizedBox(
            height: 70,
          ),
          const BircaText(
              text: '계정 생성 요청이 정상적으로 완료되었습니다',
              textSize: 18,
              textColor: MainColors.main03,
              fontFamily: 'PretendardSemiBold'),
          const BircaText(
              text: '빠르게 검토 후 알람으로 알려드릴게요 (최대 1~2일 소요)',
              textSize: 14,
              textColor: Color(0xff8F9093),
              fontFamily: 'PretendardRegular'),
          const SizedBox(
            height: 158,
          ),
          SizedBox(
              width: 300,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: MainColors.main03,
                ),
                child: const Text(
                  '계정 요청하기',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    ));
  }
}

//주최자 온보딩
class OnboardingFanHostView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingFanHostView();
}

class _OnboardingFanHostView extends State<OnboardingFanHostView> {
  bool isDateChecked = false;
  bool isCountChecked = false;

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
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: '어떤 생일 카페를\n',
                        style: TextStyle(
                            color: MainColors.grey10,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                      TextSpan(
                        text: '준비',
                        style: TextStyle(
                            color: MainColors.main03,
                            fontSize: 30,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardBold'),
                      ),
                      TextSpan(
                        text: '하고 있나요?',
                        style: TextStyle(
                            color: MainColors.grey10,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontFamily: 'PretendardMedium'),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 46,
              ),
              const Row(
                children: [
                  BircaText(
                      text: '아티스트',
                      textSize: 16,
                      textColor: MainColors.grey10,
                      fontFamily: 'PretendardMedium'),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xffFE2E2E)),
                  )
                ],
              ),
              Container(
                width: 332,
                child: TextField(
                  decoration: InputDecoration(
                      //비활성화
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD7D8DC))),
                      hintText: '아티스트',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      )
                      //활성화
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: MainColors.main03)
                      // )
                      ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              BircaText(
                  text: '생일카페 주최 일정',
                  textSize: 16,
                  textColor: MainColors.grey10,
                  fontFamily: 'PretendardMedium'),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Container(
                  width: 238,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD7D8DC)),
                    borderRadius: BorderRadius.circular(2), // 테두리 굴곡 설정
                  ),
                  child: Text(''),
                ),
                SizedBox(
                  width: 11,
                ),
                BircaOutLinedButton(
                  text: '날짜 선택',
                  radiusColor: MainColors.main03,
                  width: 80,
                  height: 36,
                  radius: 6,
                  textColor: MainColors.main03,
                  textSize: 14,
                )
              ]),
              Row(
                children: [
                  Checkbox(
                    value: isDateChecked,
                    side: BorderSide(color: Color(0xffD7D8DC)),
                    onChanged: (bool? value) {
                      setState(() {
                        isDateChecked = value ?? false;
                      });
                    },
                  ),
                  BircaText(
                      text: '날짜 미정',
                      textSize: 12,
                      textColor: Color(0xff8f9093),
                      fontFamily: 'PretendardRegular')
                ],
              ),
              SizedBox(
                height: 48,
              ),
              BircaText(
                  text: '예상 방문자 수',
                  textSize: 16,
                  textColor: MainColors.grey10,
                  fontFamily: 'PretendardMedium'),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  BircaText(
                      text: '최소',
                      textSize: 14,
                      textColor: MainColors.grey10,
                      fontFamily: 'PretendardLight'),
                  Container(
                    width: 60,
                    child: TextField(
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,

                        contentPadding: EdgeInsets.zero,
                        //비활성화
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD7D8DC))),
                        hintText: '',

                        //활성화
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: MainColors.main03)
                        // )
                      ),
                    ),
                  ),
                  BircaText(
                      text: '명, ',
                      textSize: 14,
                      textColor: MainColors.grey10,
                      fontFamily: 'PretendardLight'),
                  BircaText(
                      text: '최대',
                      textSize: 14,
                      textColor: MainColors.grey10,
                      fontFamily: 'PretendardLight'),
                  Container(
                    width: 60,
                    child: const TextField(
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,

                        //비활성화
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide
                            (
                            color: Color(0xffD7D8DC),

                          ),
                        ),

                        hintText: '',

                        //활성화
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: MainColors.main03)
                        // )
                      ),
                    ),
                  ),
                  BircaText(
                      text: '명',
                      textSize: 14,
                      textColor: MainColors.grey10,
                      fontFamily: 'PretendardLight'),
                ],
              ),

              Row(
                children: [
                  Checkbox(
                    value: isCountChecked,
                    side: BorderSide(color: Color(0xffD7D8DC)),
                    onChanged: (bool? value) {
                      setState(() {
                        isCountChecked = value ?? false;
                      });
                    },
                  ),
                  BircaText(
                      text: '예상 방문자 수 미정',
                      textSize: 12,
                      textColor: Color(0xff8f9093),
                      fontFamily: 'PretendardRegular')
                ],
              ),
              SizedBox(height: 48,),
              BircaText(
                  text: '생일카페 트위터 계정',
                  textSize: 16,
                  textColor: MainColors.grey10,
                  fontFamily: 'PretendardMedium'),


                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    child: TextField(
                      style: TextStyle(
                          fontSize: 16
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(Icons.alternate_email),
                        prefixIconColor: Color(0xff8f9093),
                        prefixIconConstraints: BoxConstraints(),
                        //비활성화
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD7D8DC))),

                        //활성화
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: MainColors.main03)
                        // )
                      ),
                    ),
                  ),
              SizedBox(height: 72,),

              Container(
                alignment: Alignment.center,
                child:           BircaFilledButton(text: '버카 시작하기', color: Color(0xffbfc0c4), width: 300, height: 46)

              ),

              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
