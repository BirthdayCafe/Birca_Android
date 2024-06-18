class VisitorCafeHomeModel {
  int birthdayCafeId;
  String? mainImageUrl;
  String startDate;
  String endDate;
  String birthdayCafeName;
  bool isLiked;
  Artist artist;
  Cafe cafe;

  VisitorCafeHomeModel({
    required this.birthdayCafeId,
    required this.mainImageUrl,
    required this.startDate,
    required this.endDate,
    required this.birthdayCafeName,
    required this.isLiked,
    required this.artist,
    required this.cafe,
  });

  factory VisitorCafeHomeModel.fromJson(Map<String, dynamic> json) {
    return VisitorCafeHomeModel(
        birthdayCafeId: json['birthdayCafeId'],
        mainImageUrl: json['mainImageUrl'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        birthdayCafeName: json['birthdayCafeName'],
        isLiked: json['isLiked'],
        artist: Artist.fromJson(json['artist']),
        cafe: Cafe.fromJson(json['cafe']));
  }
}

class Artist {
  final String? groupName;
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


class HomeArtists {
  int? artistId;
  String? artistName;
  String? artistImage;

  HomeArtists(
      {required this.artistId,
        required this.artistName,
        required this.artistImage});

  factory HomeArtists.fromJson(Map<String, dynamic> json) {
    return HomeArtists(
      artistId: json['artistId'],
      artistName: json['artistName'],
      artistImage: json['artistImage'],
    );
  }
}
