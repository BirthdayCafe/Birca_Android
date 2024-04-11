class BirthdayCafeModel{

  final Cafe cafe;
  final Artist artist;
  final String startDate;
  final String endDate;
  final String birthdayCafeName;
  final int likeCount;
  final bool isLiked;
  final String twitterAccount;
  final int minimumVisitant;
  final int maximumVisitant;
  final String congestionState;
  final String visibility;
  final String progressState;
  final String specialGoodsStockState;
  final String mainImage;
  final List<String> defaultImages;

  BirthdayCafeModel({
    required this.cafe,
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
    required this.defaultImages
});

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
  final String groupName;
  final String name;

  Artist({required this.groupName, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      groupName: json['groupName'],
      name: json['name'],
    );
  }
}

class Cafe {
  final String address;
  final String name;
  final List<dynamic> images;

  Cafe({required this.name, required this.address, required this.images});

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      name: json['name'],
      address: json['address'],
      images: List<Images>.from(json['images'].map((x) => Images.fromJson(x))),
    );
  }
}

class Images {
  String url;

  Images({required this.url});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(url: json['url']);
  }

}