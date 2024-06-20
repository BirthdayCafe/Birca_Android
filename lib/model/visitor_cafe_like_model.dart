class VisitorCafeLikeModel {
  final int birthdayCafeId;
  final String? mainImageUrl;
  final String startDate;
  final String endDate;
  final String birthdayCafeName;
  final String twitterAccount;
  final Artist artist;

  VisitorCafeLikeModel(
      {required this.birthdayCafeId,
      required this.mainImageUrl,
      required this.startDate,
      required this.endDate,
      required this.birthdayCafeName,
      required this.twitterAccount,
      required this.artist});

  factory VisitorCafeLikeModel.fromJson(Map<String, dynamic> json) {
    return VisitorCafeLikeModel(
      birthdayCafeId: json['birthdayCafeId'],
      mainImageUrl: json['mainImageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      birthdayCafeName: json['birthdayCafeName'],
      twitterAccount: json['twitterAccount'],
      artist: Artist.fromJson(json['artist']),
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
