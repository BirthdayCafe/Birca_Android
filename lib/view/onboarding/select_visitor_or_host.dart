import 'dart:convert';
import 'dart:developer';

import 'package:birca/view/onboarding/apply_visitor_nickname_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
                           await postRoleChange('VISITANT');
                            if(context.mounted){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ApplyVisitorNickNameScreen()));
                            }

                          },
                          child: Image.asset(
                              'lib/assets/image/img_fan_visitor.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                           await postRoleChange('HOST');
                            if(context.mounted){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ApplyHostNickNameScreen()));
                            }
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


//post role change
Future<void> postRoleChange(String role) async {
  const storage = FlutterSecureStorage();

  Dio dio = Dio();
  Response response;
  var baseUrl = dotenv.env['BASE_URL'];

  var token = '';
  var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

  //토큰 가져오기
  if (kakaoLoginInfo != null) {
    Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    token = loginData['accessToken'].toString();
  }

  try {
    response = await dio.post('${baseUrl}api/v1/members/role-change',
        data: {'role': role},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    log('kakaoLoginInfo : $kakaoLoginInfo');


    log(response.data.toString());


  } catch (e) {
    log(e.toString());

  }
}