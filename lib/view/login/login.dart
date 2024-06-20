import 'dart:convert';
import 'dart:developer';
import 'package:birca/widgets/bottom_nav_host.dart';
import 'package:birca/widgets/bottom_nav_owner.dart';
import 'package:birca/widgets/bottom_nav_visitor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../onboarding/select_fan_or_cafe_owner.dart';

class Login extends StatefulWidget {
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
            Image.asset('lib/assets/image/img_logo.png'),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset('lib/assets/image/img_logo_text.svg'),
            const SizedBox(
              height: 64,
            ),
            GestureDetector(
              onTap: () async {
                await kakaoLogin(context);

                // String role = await getRole();
                // if (!mounted) return;
                //
                // if (role == 'VISITANT') {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => const BottomNavVisitor()));
                // } else if (role == 'HOST') {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => const BottomNavHost()));
                // } else if (role == 'OWNER') {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => const BottomNavOwner()));
                // } else {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => const SelectFanOrCafeOwner()));
                // }
              },
              child: Image.asset('lib/assets/image/kakao_login_medium_wide.png'),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'lib/assets/image/apple_login.png',
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> kakaoLogin(BuildContext context) async {
  // 카카오 로그인 구현 예제

  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      //token
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      User user = await UserApi.instance.me();
      log('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
      log('카카오톡으로 로그인 성공 \n 토큰: ${token.accessToken}');

      await postKakaoToken(token.accessToken,context);
    } catch (error) {
      log('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        //token
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        User user = await UserApi.instance.me();
        log('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}'
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
        log('카카오계정으로 로그인 성공  \n 토큰: ${token.accessToken}');
        await postKakaoToken(token.accessToken, context);
      } catch (error) {
        log('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      //token
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      User user = await UserApi.instance.me();
      log('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
      log('카카오계정으로 로그인 성공  \n 토큰: ${token.accessToken}');

      await postKakaoToken(token.accessToken, context);
    } catch (error) {
      log('카카오계정으로 로그인 실패 $error');
    }
  }
}

//post token
Future<void> postKakaoToken(String token,BuildContext context) async {
  const storage = FlutterSecureStorage();

  Dio dio = Dio();
  Response response;
  var baseUrl = dotenv.env['BASE_URL'];
  log('token : $token');

  try {
    response = await dio
        .post('${baseUrl}api/v1/oauth/login/kakao', data: {'accessToken': token});

    var kakaoLoginInfo = jsonEncode(response.data);
    log('kakaoLoginInfo : $kakaoLoginInfo');


    await storage.write(key: 'kakaoLoginInfo', value: kakaoLoginInfo);

    String role = await getRole();

    if (role == 'VISITANT') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavVisitor()));
    } else if (role == 'HOST') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavHost()));
    } else if (role == 'OWNER') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavOwner()));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SelectFanOrCafeOwner()));
    }


  } catch (e) {
    log(e.toString());
    throw Exception('Failed to login.');
  }
}

Future<String> getRole() async {
  Dio dio = Dio();

  const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  var token = '';
  var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');

  // 토큰 가져오기
  if (kakaoLoginInfo != null) {
    Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    token = loginData['accessToken'].toString();
  }

  // LogInterceptor 추가
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  try {
    // API 엔드포인트 및 업로드
    Response response = await dio.get('${baseUrl}api/v1/members/role',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    // 서버 응답 출력
    log('Response: ${response.data}');
    // JSON 문자열을 Map으로 파싱
    Map<String, dynamic> decodedResponse = response.data;

    // "role" 값 추출
    return decodedResponse['role'] as String;
  } catch (e) {
    if (e is DioException) {
      // Dio exception handling
      if (e.response != null) {
        // Server responded with an error
        if (e.response!.statusCode == 400) {
          // Handle HTTP 400 Bad Request error
          log('Bad Request - Server returned 400 status code');
          throw Exception('Failed to getHostMyCafe');
        } else {
          // Handle other HTTP status codes
          log('Server error - Status code: ${e.response!.statusCode}');
          throw Exception('Failed to getHostMyCafe.');
        }
      } else {
        // No response from the server (network error, timeout, etc.)
        log('Dio error: ${e.message}');
        throw Exception('Failed to getHostMyCafe.');
      }
    } else {
      // Handle other exceptions if necessary
      log('Error: $e');
      throw Exception('Failed to getHostMyCafe.');
    }
  }
}