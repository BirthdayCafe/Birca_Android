import 'dart:developer';
import 'dart:io';
import 'package:birca/model/api.dart';
import 'package:birca/model/birthday_cafe_lucky_draws_model.dart';
import 'package:birca/model/birthday_cafe_menus_model.dart';
import 'package:birca/model/birthday_cafe_model.dart';
import 'package:birca/model/birthday_cafe_special_goods_model.dart';
import 'package:birca/view/login/token.dart';
import 'package:birca/viewModel/visitor_cafe_home_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BirthdayCafeViewModel extends ChangeNotifier {
  Dio dio = Dio();
  Api api = Api();

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

  final List<TextEditingController> _goodsNameController = [];

  List<TextEditingController> get goodsNameController => _goodsNameController;

  final List<TextEditingController> _goodsDetailsController = [];

  List<TextEditingController> get goodsDetailsController =>
      _goodsDetailsController;
  final List<TextEditingController> _menuNameController = [];

  List<TextEditingController> get menuNameController => _menuNameController;
  final List<TextEditingController> _menuDetailsController = [];

  List<TextEditingController> get menuDetailsController =>
      _menuDetailsController;
  final List<TextEditingController> _menuPriceController = [];

  List<TextEditingController> get menuPriceController => _menuPriceController;

  final List<TextEditingController> _luckyDrawsRankController = [];

  List<TextEditingController> get luckyDrawsRankController =>
      _luckyDrawsRankController;

  final List<TextEditingController> _luckyDrawsPrizeController = [];

  List<TextEditingController> get luckyDrawsPrizeController =>
      _luckyDrawsPrizeController;

  final TextEditingController _birthDayCafeNameController =
      TextEditingController();

  TextEditingController get birthDayCafeNameController =>
      _birthDayCafeNameController;

  final TextEditingController _twitterController = TextEditingController();

  TextEditingController get twitterController => _twitterController;

  final TextEditingController _cafeAddressController = TextEditingController();

  TextEditingController get cafeAddressController => _cafeAddressController;

  String _visibility = '';
  String get visibility => _visibility;


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
    _cafeID = cafeID;
    notifyListeners(); // 상태 변경 알림
  }

  static const storage = FlutterSecureStorage();
  var baseUrl = dotenv.env['BASE_URL'];
  Token tokenInstance = Token();

  //생일 카페 상세 가져오기
  Future<void> getBirthdayCafes(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getBirthdayCafes Response: ${response.data}');

      _birthdayCafeModel = BirthdayCafeModel.fromJson(response.data);

      if(_birthdayCafeModel!.visibility=='PUBLIC'){
        _visibility = '공개';
      } else {
        _visibility = '비공개';
      }
      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일 카페 특전 조회
  Future<void> getSpecialGoods(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //생일 카페 메뉴 조회
  Future<void> getMenus(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/menus',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getMenus Response: ${response.data}');

      _birthdayCafeMenusModel = [];

      List<dynamic> jsonData = response.data;
      List<BirthdayCafeMenusModel> menusModels =
          jsonData.map((e) => BirthdayCafeMenusModel.fromJson(e)).toList();

      _birthdayCafeMenusModel?.addAll(menusModels);

      for (int i = 0; i < _birthdayCafeMenusModel!.length; i++) {
        _menuNameController.add(TextEditingController());
        _menuDetailsController.add(TextEditingController());
        _menuPriceController.add(TextEditingController());
      }
      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일 카페 럭키드로우 조회
  Future<void> getLuckDraws(int birthdayCafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.get(
          '${baseUrl}api/v1/birthday-cafes/$birthdayCafeId/lucky-draws',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // 서버 응답 출력
      log('getLuckDraws Response: ${response.data}');

      _birthdayCafeLuckyDrawsModel = [];

      List<dynamic> jsonData = response.data;
      List<BirthdayCafeLuckyDrawsModel> luckyDrawsModels =
          jsonData.map((e) => BirthdayCafeLuckyDrawsModel.fromJson(e)).toList();

      // _visitorCafeHomeModelList 추가
      _birthdayCafeLuckyDrawsModel?.addAll(luckyDrawsModels);

      for (int i = 0; i < _birthdayCafeLuckyDrawsModel!.length; i++) {
        _luckyDrawsRankController.add(TextEditingController());
        _luckyDrawsPrizeController.add(TextEditingController());
      }

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일 카페 사진 편집
  Future<void> postImage(int cafeId, List<PickedFile> pickedFiles) async {

    patchInfo(cafeId, BirthdayCafeInfoModel(birthdayCafeName: birthDayCafeNameController.text,birthdayCafeTwitterAccount: twitterController.text));
    String token = await tokenInstance.getToken();

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
    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //생일 카페 대표 사진 편집
  Future<void> postMainImage(int cafeId, PickedFile pickedFile) async {
    patchInfo(cafeId, BirthdayCafeInfoModel(birthdayCafeName: birthDayCafeNameController.text,birthdayCafeTwitterAccount: twitterController.text));

    String token = await tokenInstance.getToken();

    // PickedFile 리스트를 File 리스트로 변환
    File cafeImage = File(pickedFile.path);

    // 업로드할 파일을 FormData로 변환
    FormData formData = FormData.fromMap({
      'mainImage': await MultipartFile.fromFile(
        cafeImage.path,
      )
    });

    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //생일카페 정보 수정
  Future<void> patchInfo(
      int cafeId, BirthdayCafeInfoModel birthdayCafeInfoModel) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //생일카페 특전 수정
  Future<void> postSpecialGoods(int cafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //생일카페 menu 수정
  Future<void> postMenus(int cafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();
    List<Map<String, dynamic>>? jsonList =
        _birthdayCafeMenusModel?.map((item) => item.toJson()).toList();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/menus',
        data: jsonList,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // 서버 응답 출력
      log('postMenus Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일카페 luckydraws 수정
  Future<void> postLuckyDraws(int cafeId) async {
    String token = await tokenInstance.getToken();

    api.logInterceptor();
    List<Map<String, dynamic>>? jsonList =
        _birthdayCafeLuckyDrawsModel?.map((item) => item.toJson()).toList();

    try {
      // API 엔드포인트 및 업로드
      Response response = await dio.post(
        '${baseUrl}api/v1/birthday-cafes/$cafeId/lucky-draws',
        data: jsonList,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      patchCafeState(cafeId, 'visibility', 'PUBLIC');
      // 서버 응답 출력
      log('postLuckyDraws Response: ${response.data}');

      notifyListeners();
    } catch (e) {
      api.errorCheck(e);
    }
  }

  //생일카페 상태 수정
  Future<void> patchCafeState(
      int cafeId, String stateName, String state) async {

    patchInfo(cafeId, BirthdayCafeInfoModel(birthdayCafeName: birthDayCafeNameController.text,birthdayCafeTwitterAccount: twitterController.text));

    String token = await tokenInstance.getToken();
    if(_birthdayCafeModel!.visibility=='PUBLIC'){
      _visibility = '공개';
    } else {
      _visibility = '비공개';
    }
    api.logInterceptor();

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
      api.errorCheck(e);
    }
  }

  //menu 삭제
  void deleteMenus(int index) {
    update();

    _menuNameController[index].dispose();
    _menuPriceController[index].dispose();
    _menuDetailsController[index].dispose();

    _menuNameController.removeAt(index);
    _menuPriceController.removeAt(index);
    _menuDetailsController.removeAt(index);

    _birthdayCafeMenusModel?.removeAt(index);

    notifyListeners();
  }

  //menu 생성
  void addMenus() {
    update();

    _menuNameController.add(TextEditingController());
    _menuPriceController.add(TextEditingController());
    _menuDetailsController.add(TextEditingController());

    _birthdayCafeMenusModel?.add(
        BirthdayCafeMenusModel(name: 'name', details: 'details', price: 0));

    notifyListeners();
  }

  //  특전 삭제
  void deleteGoods(int index) {
    update();

    _goodsNameController[index].dispose();
    _goodsDetailsController[index].dispose();

    _goodsNameController.removeAt(index);
    _goodsDetailsController.removeAt(index);
    _birthdayCafeSpecialGoodsModel?.removeAt(index);

    notifyListeners();
  }

  //특전 생성
  void addGoods() {
    update();

    _goodsNameController.add(TextEditingController());
    _goodsDetailsController.add(TextEditingController());
    _birthdayCafeSpecialGoodsModel
        ?.add(BirthdayCafeSpecialGoodsModel(name: 'name', details: 'details'));

    notifyListeners();
  }

  //  luckydraws 삭제
  void deleteLuckyDraws(int index) {
    update();

    _luckyDrawsRankController[index].dispose();
    _luckyDrawsPrizeController[index].dispose();

    _luckyDrawsRankController.removeAt(index);
    _luckyDrawsPrizeController.removeAt(index);
    birthdayCafeLuckyDrawsModel?.removeAt(index);

    notifyListeners();
  }

  //luckydraws 생성
  void addLuckyDraws() {
    update();
    _luckyDrawsRankController.add(TextEditingController());
    _luckyDrawsPrizeController.add(TextEditingController());
    birthdayCafeLuckyDrawsModel
        ?.add(BirthdayCafeLuckyDrawsModel(rank: 0, prize: '상품'));

    notifyListeners();
  }


  void update() {
    for (int i = 0; i < birthdayCafeMenusModel!.length; i++) {
      birthdayCafeMenusModel![i].name = menuNameController[i].text;
      birthdayCafeMenusModel![i].details = menuDetailsController[i].text;
      birthdayCafeMenusModel![i].price = int.parse(menuPriceController[i].text);
    }

    for (int i = 0; i < birthdayCafeSpecialGoodsModel!.length; i++) {
      birthdayCafeSpecialGoodsModel![i].name = goodsNameController[i].text;
      birthdayCafeSpecialGoodsModel![i].details =
          goodsDetailsController[i].text;
    }

    for (int i = 0; i < birthdayCafeLuckyDrawsModel!.length; i++) {
      birthdayCafeLuckyDrawsModel![i].prize = luckyDrawsPrizeController[i].text;
      birthdayCafeLuckyDrawsModel![i].rank =
          int.parse(luckyDrawsRankController[i].text);

      birthdayCafeModel?.birthdayCafeName = birthDayCafeNameController.text.toString();
      birthdayCafeModel?.twitterAccount = twitterController.text.toString();

      notifyListeners();
    }

    birthdayCafeModel?.birthdayCafeName = birthDayCafeNameController.text;
    birthdayCafeModel?.twitterAccount = twitterController.text;
  }

  void changeIcon(int id, BuildContext context) {
    if (birthdayCafeModel != null) {
      if (birthdayCafeModel!.isLiked) {
        Provider.of<VisitorCafeHomeViewModel>(context, listen: false)
            .dislike(id);

        birthdayCafeModel!.isLiked = false;
        notifyListeners();
      } else {
        Provider.of<VisitorCafeHomeViewModel>(context, listen: false).like(id);

        birthdayCafeModel!.isLiked = true;
        notifyListeners();
      }
    }
  }
}
