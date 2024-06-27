import 'dart:convert';
import 'dart:developer';
import 'package:birca/model/api.dart';
import 'package:birca/view/login/token.dart';
import 'package:birca/view/onboarding/onboarding_cafe_owner_complete.dart';
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
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../viewModel/mypage_view_model.dart';
import '../onboarding/select_fan_or_cafe_owner.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

Api api = Api();
Dio dio = Dio();
var baseUrl = dotenv.env['BASE_URL'];

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
              },
              child:
                  Image.asset('lib/assets/image/kakao_login_medium_wide.png'),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                signInWithApple(context);
              },
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

      await postKakaoToken(token.accessToken, context);
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
Future<void> postKakaoToken(String token, BuildContext context) async {
  const storage = FlutterSecureStorage();

  Response response;
  var baseUrl = dotenv.env['BASE_URL'];
  log('token : $token');

  try {
    response = await dio.post('${baseUrl}api/v1/oauth/login/kakao',
        data: {'accessToken': token});

    var loginToken = jsonEncode(response.data);
    log('loginToken : $loginToken');

    await storage.write(key: 'loginToken', value: loginToken);

    String role = await Provider.of<MypageViewModel>(context,
        listen: false).getRole();

    if (role == 'VISITANT') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavVisitor()));
    } else if (role == 'HOST') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNavHost()));
    } else if (role == 'OWNER') {
      var check = await licenseCheck();

      if (check == 'YES') {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BottomNavOwner()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const OnboardingCafeOwnerComplete()));
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SelectFanOrCafeOwner()));
    }
  } catch (e) {
    log(e.toString());
    throw Exception('Failed to login.');
  }
}

void signInWithApple(BuildContext context) async {
  try {
    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: dotenv.env['APPLE_CLIENT_ID']!,
        redirectUri: Uri.parse(''),
      ),
    );

    log('credential.state = $credential');
    log('credential.state = ${credential.email}');
    log('credential.state = ${credential.userIdentifier}');

    await postAppleToken(credential.identityToken ?? '', context);
  } catch (error) {
    print('error = $error');
  }
}

//post token
Future<void> postAppleToken(String token, BuildContext context) async {
  const storage = FlutterSecureStorage();

  Dio dio = Dio();
  Response response;
  var baseUrl = dotenv.env['BASE_URL'];
  log('token : $token');

  try {
    response = await dio.post('${baseUrl}api/v1/oauth/login/apple',
        data: {'accessToken': token});

    var loginToken = jsonEncode(response.data);
    log('loginToken : $loginToken');

    await storage.write(key: 'loginToken', value: loginToken);

    String role = await Provider.of<MypageViewModel>(context,
        listen: false).getRole();

    if (role == 'VISITANT') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavVisitor()));
    } else if (role == 'HOST') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNavHost()));
    } else if (role == 'OWNER') {
      var check = await licenseCheck();
      if (check == 'YES') {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BottomNavOwner()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const OnboardingCafeOwnerComplete()));
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SelectFanOrCafeOwner()));
    }
  } catch (e) {
    log(e.toString());
    throw Exception('Failed to login.');
  }
}

Future<String> licenseCheck() async {
  Token tokenInstance = Token();
  String token = await tokenInstance.getToken();

  api.logInterceptor();

  try {
    // API 엔드포인트 및 업로드
    Response response = await dio.get(
        '${baseUrl}api/v1/business-license/status',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    // 서버 응답 출력
    log('Response: ${response.data}');
    // JSON 문자열을 Map으로 파싱
    Map<String, dynamic> decodedResponse = response.data;

    var registrationApproved = decodedResponse['registrationApproved'] as bool;
    if (registrationApproved) {
      return "YES";
    } else {
      return "NO";
    }
  } catch (e) {
    api.errorCheck(e);
    throw Exception('Failed to licenseCheck.');
  }
}
