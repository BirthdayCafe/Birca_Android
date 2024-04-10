class VisitorHomeModel{

  final int birthdayCafeId;
  final String mainImageUrl;
  final String startDate;
  final String endDate;
  final String birthdayCafeName;
  final bool isLiked;
  final Artist artist;
  final Cafe cafe;

  VisitorHomeModel(
      {required this.birthdayCafeId,
        required this.mainImageUrl,
        required this.startDate,
        required this.endDate,
        required this.birthdayCafeName,
        required this.isLiked,
        required this.artist,
        required this.cafe});


  factory VisitorHomeModel.fromJson(Map<String, dynamic> json) {
    return VisitorHomeModel(
      birthdayCafeId: json['birthdayCafeId'],
      mainImageUrl: json['mainImageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      birthdayCafeName: json['birthdayCafeName'],
      isLiked: json['isLiked'],
      artist: Artist.fromJson(json['artist']),
      cafe: Cafe.fromJson(json['cafe']),
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

  Cafe({required this.address});

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      address: json['address'],
    );
  }
}