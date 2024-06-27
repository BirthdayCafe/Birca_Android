import 'package:birca/view/onboarding/apply_visitor_nickname_screen.dart';
import 'package:flutter/material.dart';
import '../../designSystem/palette.dart';
import '../../widgets/appbar.dart';
import 'apply_host_nickname_screen.dart';

class SelectVisitorOrHost extends StatelessWidget {
  const SelectVisitorOrHost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bircaAppBar(() {
          Navigator.pop(context);
        }),
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
                                color: Palette.primary,
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
                          onTap: () async {
                            // await Provider.of<MypageViewModel>(context,
                            //         listen: false)
                            //     .postRoleChange('VISITANT')
                            //     .then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ApplyVisitorNickNameScreen()));
                          },
                          child: Image.asset(
                              'lib/assets/image/img_fan_visitor.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                            // await Provider.of<MypageViewModel>(context,
                            //         listen: false)
                            //     .postRoleChange('HOST')
                            //     .then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ApplyHostNickNameScreen()));
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
