class BirthdayCafeModel {
  Cafe cafe;
  Artist artist;
  String startDate;
  String endDate;
  String birthdayCafeName;
  int likeCount;
  bool isLiked;
  String twitterAccount;
  int minimumVisitant;
  int maximumVisitant;
  String congestionState;
  String visibility;
  String progressState;
  String specialGoodsStockState;
  String mainImage;
  List<String> defaultImages;

  BirthdayCafeModel(
      {required this.cafe,
      required this.artist,
      required this.startDate,
      required this.endDate,
      required this.birthdayCafeName,
      required this.likeCount,
      required this.isLiked,
      required this.twitterAccount,
      required this.minimumVisitant,
      required this.maximumVisitant,
      required this.congestionState,
      required this.visibility,
      required this.progressState,
      required this.specialGoodsStockState,
      required this.mainImage,
      required this.defaultImages});

  factory BirthdayCafeModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeModel(
      cafe: Cafe.fromJson(json['cafe']),
      artist: Artist.fromJson(json['artist']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      birthdayCafeName: json['birthdayCafeName'],
      likeCount: json['likeCount'],
      isLiked: json['isLiked'],
      twitterAccount: json['twitterAccount'],
      minimumVisitant: json['minimumVisitant'],
      maximumVisitant: json['maximumVisitant'],
      congestionState: json['congestionState'],
      visibility: json['visibility'],
      progressState: json['progressState'],
      specialGoodsStockState: json['specialGoodsStockState'],
      mainImage: json['mainImage'],
      defaultImages: List<String>.from(json['defaultImages']),
    );
  }
}

class Artist {
  String groupName;
  String name;

  Artist({required this.groupName, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      groupName: json['groupName'],
      name: json['name'],
    );
  }
}

class Cafe {
  String address;
  String name;
  List<String> images;

  Cafe({required this.name, required this.address, required this.images});

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      name: json['name'],
      address: json['address'],
      images: List<String>.from(json['images']),
    );
  }
}

class BirthdayCafeInfoModel {
  String? birthdayCafeName;
  String? birthdayCafeTwitterAccount;

  BirthdayCafeInfoModel(
      {this.birthdayCafeName, this.birthdayCafeTwitterAccount});

  // JSON 데이터를 모델 객체로 변환하는 factory 생성자
  factory BirthdayCafeInfoModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeInfoModel(
      birthdayCafeName: json['birthdayCafeName'],
      birthdayCafeTwitterAccount: json['birthdayCafeTwitterAccount'],
    );
  }

  // 모델 객체를 JSON 데이터로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'birthdayCafeName': birthdayCafeName,
      'birthdayCafeTwitterAccount': birthdayCafeTwitterAccount,
    };
  }
}
