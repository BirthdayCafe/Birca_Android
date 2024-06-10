import 'dart:developer';
import 'dart:io';
import 'package:birca/model/birthday_cafe_lucky_draws_model.dart';
import 'package:birca/model/birthday_cafe_menus_model.dart';
import 'package:birca/model/birthday_cafe_model.dart';
import 'package:birca/model/birthday_cafe_special_goods_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class BirthdayCafeViewModel extends ChangeNotifier {
  Dio dio = Dio();

  int? _cafeID;

  int? get cafeID => _cafeID;

  BirthdayCafeModel? _birthdayCafeModel;

  BirthdayCafeModel? get birthdayCafeModel => _birthdayCafeModel;

  List<BirthdayCafeLuckyDrawsModel>? _birthdayCafeLuckyDrawsModel;

  List<BirthdayCafeLuckyDrawsModel>? get birthdayCafeLuckyDrawsModel =>
      _birthdayCafeLuckyDrawsModel;

  List<BirthdayCafeMenusModel>? _birthdayCafeMenusModel;

  List<BirthdayCafeMenusModel>? get birthdayCafeMenusModel =>
      _birthdayCafeMenusModel;

  List<BirthdayCafeSpecialGoodsModel>? _birthdayCafeSpecialGoodsModel;

  List<BirthdayCafeSpecialGoodsModel>? get birthdayCafeSpecialGoodsModel =>
      _birthdayCafeSpecialGoodsModel;

  List<TextEditingController> _goodsNameController = [];

  List<TextEditingController> get goodsNameController => _goodsNameController;

  List<TextEditingController> _goodsDetailsController = [];

  List<TextEditingController> get goodsDetailsController =>
      _goodsDetailsController;

  //현재 상태를 저장하는 변수
  final String _congestionState = 'UNKNOWN';
  final String _specialGoodsState = 'UNKNOWN';

  String get congestionState => _congestionState;

  String get specialGoodsState => _specialGoodsState;

  // congestionState를 한글로 변환하는 매핑
  Map<String, String> congestionStateMapping = {
    'SMOOTH': '원활',
    'MODERATE': '보통',
    'CONGESTED': '혼잡',
  };

  // progressState를 한글로 변환하는 함수
  String getCongestionStateInKorean(String congestionState) {
    return congestionStateMapping[congestionState] ?? '알 수 없음';
  }

  // specialGoodsStockState를 한글로 변환하는 매핑
  Map<String, String> specialGoodsStockStateMapping = {
    'EXHAUSTED': '소진',
    'SCARCE': '적음',
    'ABUNDANT': '많음',
  };

  // progressState를 한글로 변환하는 함수
  String getSpecialGoodsStockStateInKorean(String specialGoodsStockState) {
    return specialGoodsStockStateMapping[specialGoodsStockState] ?? '알 수 없음';
  }

  //로딩 상태 관리
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  BirthdayCafeViewModel() {
    _birthdayCafeLuckyDrawsModel = [];
    _birthdayCafeMenusModel = [];
    _birthdayCafeSpecialGoodsModel = [];
    _birthdayCafeModel?.defaultImages = [];
  }

  Future<void> fetchData(int cafeID) async {
    // 여기서 cafeID를 사용하여 해당 카페의 데이터를 가져옵니다.
    // 예를 들어 네트워크 호출이나 데이터베이스 쿼리를 수행할 수 있습니다.
    // cafeID를 사용하여 데이터를 가져옵니다.
    // cafeID에 해당하는 데이터를 가져온 후 상태를 업데이트합니다.
    _cafeID = cafeID;
    notifyListeners(); // 상태 변경 알림
  }

  //생일 카페 상세 가져오기
  Future<void> getBirthdayCafes(int birthdayCafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getBirthdayCafes Response: ${response.data}');

      // final Map<String, dynamic> responseData = json.decode(response.data);

      _birthdayCafeModel = BirthdayCafeModel.fromJson(response.data);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getBirthdayCafes');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getBirthdayCafes.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getBirthdayCafes.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getBirthdayCafes.');
      }
    }
  }

  //생일 카페 특전 조회
  Future<void> getSpecialGoods(int birthdayCafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/special-goods',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getSpecialGoods Response: ${response.data}');

      _birthdayCafeSpecialGoodsModel = [];

      List<dynamic> jsonData = response.data;
      List<BirthdayCafeSpecialGoodsModel> specialGoodsModels = jsonData
          .map((e) => BirthdayCafeSpecialGoodsModel.fromJson(e))
          .toList();

      // _visitorCafeHomeModelList 추가
      _birthdayCafeSpecialGoodsModel?.addAll(specialGoodsModels);

      for (int i = 0; i < _birthdayCafeSpecialGoodsModel!.length; i++) {
        _goodsNameController.add(TextEditingController());
        _goodsDetailsController.add(TextEditingController());
      }

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getSpecialGoods');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getSpecialGoods.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getSpecialGoods.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getSpecialGoods.');
      }
    }
  }

  //생일 카페 메뉴 조회
  Future<void> getMenus(int birthdayCafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/menus',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getMenus Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<BirthdayCafeMenusModel> menusModels =
          jsonData.map((e) => BirthdayCafeMenusModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _birthdayCafeMenusModel?.addAll(menusModels);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getMenus');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getMenus.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getMenus.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getMenus.');
      }
    }
  }

  //생일 카페 럭키드로우 조회
  Future<void> getLuckDraws(int birthdayCafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';
    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';

    //
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/lucky-draws',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getLuckDraws Response: ${response.data}');

      List<dynamic> jsonData = response.data;
      List<BirthdayCafeLuckyDrawsModel> luckyDrawsModels =
          jsonData.map((e) => BirthdayCafeLuckyDrawsModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _birthdayCafeLuckyDrawsModel?.addAll(luckyDrawsModels);

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to getLuckDraws');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to getLuckDraws.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to getLuckDraws.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to getLuckDraws.');
      }
    }
  }

  //생일 카페 사진 편집
  Future<void> postImage(int cafeId, List<PickedFile> pickedFiles) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // PickedFile 리스트를 File 리스트로 변환
    List<File> cafeImages =
        pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();

    // 업로드할 파일을 FormData로 변환
    FormData formData = FormData();

    for (int i = 0; i < cafeImages.length; i++) {
      formData.files.add(MapEntry(
          'defaultImages',
          await MultipartFile.fromFile(
            cafeImages[i].path,
          )));
    }
    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    log(formData.toString());

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/images',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('postImage Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postImage');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postImage.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postImage.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postImage.');
      }
    }
  }

  //생일 카페 대표 사진 편집
  Future<void> postMainImage(int cafeId, PickedFile pickedFile) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // PickedFile 리스트를 File 리스트로 변환
    File cafeImage = File(pickedFile.path);

    // 업로드할 파일을 FormData로 변환
    FormData formData = FormData.fromMap({
      'mainImage': await MultipartFile.fromFile(
        cafeImage.path,
      )
    });

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    log(formData.toString());

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/images/main',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('postImage Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postImage');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postImage.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postImage.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postImage.');
      }
    }
  }

  //생일카페 정보 수정
  Future<void> patchInfo(
      int cafeId, BirthdayCafeInfoModel birthdayCafeInfoModel) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.patch(
        '${baseUrl}api/v1/birthday-cafes/$cafeId',
        data: birthdayCafeInfoModel.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('patchInfo Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to patchInfo');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to patchInfo.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to patchInfo.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to patchInfo.');
      }
    }
  }

  //생일카페 특전 수정
  Future<void> postSpecialGoods(int cafeId) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    List<Map<String, dynamic>>? jsonList =
        _birthdayCafeSpecialGoodsModel?.map((item) => item.toJson()).toList();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/special-goods',
        data: jsonList,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('postSpecialGoods Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to postSpecialGoods');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to postSpecialGoods.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to postSpecialGoods.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to postSpecialGoods.');
      }
    }
  }

  //생일카페 상태 수정
  Future<void> patchCafeState(
      int cafeId, String stateName, String state) async {
    // const storage = FlutterSecureStorage();
    var baseUrl = dotenv.env['BASE_URL'];
    var token = '';

    token =
        'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNzEyMjMxMzYwLCJleHAiOjE3MzAyMzEzNjB9.Rz0qqN10T-ZM2L0PC1hFd_UR5X9djywjhyiINTTd3M4';
    // var kakaoLoginInfo = await storage.read(key: 'kakaoLoginInfo');
    //
    // // 토큰 가져오기
    // if (kakaoLoginInfo != null) {
    //   Map<String, dynamic> loginData = json.decode(kakaoLoginInfo);
    //   token = loginData['accessToken'].toString();
    // }

    // LogInterceptor 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.patch(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/$stateName',
        data: {'state': state},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('patchCafeState Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        // Dio exception handling
        if (e.response != null) {
          // Server responded with an error
          if (e.response!.statusCode == 400) {
            // Handle HTTP 400 Bad Request error
            log('Bad Request - Server returned 400 status code');
            throw Exception('Failed to patchCafeState');

            // Additional error handling logic here if needed
          } else {
            // Handle other HTTP status codes
            log('Server error - Status code: ${e.response!.statusCode}');
            throw Exception('Failed to patchCafeState.');
            // Additional error handling logic here if needed
          }
        } else {
          // No response from the server (network error, timeout, etc.)
          log('Dio error: ${e.message}');
          throw Exception('Failed to patchCafeState.');
        }
      } else {
        // Handle other exceptions if necessary
        log('Error: $e');
        throw Exception('Failed to patchCafeState.');
      }
    }
  }

  //  특전 삭제
  void deleteGoods(int index) {
    _goodsNameController[index].dispose();
    goodsDetailsController[index].dispose();

    _goodsNameController.removeAt(index);
    _goodsDetailsController.removeAt(index);
    _birthdayCafeSpecialGoodsModel?.removeAt(index);

    notifyListeners();
  }

  //특전 생성
  void addGoods() {
    _goodsNameController.add(TextEditingController());
    _goodsDetailsController.add(TextEditingController());
    _birthdayCafeSpecialGoodsModel
        ?.add(BirthdayCafeSpecialGoodsModel(name: 'name', details: 'details'));

    notifyListeners();
  }
}
