import 'dart:convert';
import 'dart:developer';

import 'package:birca/view/onboarding/onboarding_cafe_owner.dart';
import 'package:birca/view/onboarding/select_visitor_or_host.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../designSystem/palette.dart';
import '../../widgets/appbar.dart';

class SelectFanOrCafeOwner extends StatefulWidget {
  const SelectFanOrCafeOwner({super.key});

  @override
  State<StatefulWidget> createState() => _SelectFanOrCafeOwner();
}

class _SelectFanOrCafeOwner extends State<SelectFanOrCafeOwner> {
  @override
  void initState() {
    super.initState();
    log('온보딩 시작');
  }

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
                            text: '버카',
                            style: TextStyle(
                                color: Palette.primary,
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
                                        const SelectVisitorOrHost()));
                          },
                          child: Image.asset('lib/assets/image/img_fan.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                            await postRoleChange('OWNER');
                            if(context.mounted){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OnboardingCafeOwner()));
                            }
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

//post role change
Future<void> postRoleChange(String role) async {
  const storage = FlutterSecureStorage();

  Dio dio = Dio();
  Response response;
  var baseUrl = dotenv.env['BASE_URL'];
  Map<String, dynamic>? loginData;
  String? token = '';
  var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

  //토큰 가져오기
  if (kakaoLoginInfo != null) {
    loginData = json.decode(kakaoLoginInfo);
    token = loginData?['accessToken'].toString();
  }

  try {
    response = await dio.post('${baseUrl}api/v1/members/role-change',
        data: {'role': role},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    // log('kakaoLoginInfo : $kakaoLoginInfo');

    log(response.data.toString());

  } catch (e) {
    log(e.toString());

  }
}
