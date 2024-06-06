class HostMyCafeModel {
  int birthdayCafeId;
  String? mainImageUrl;
  String startDate;
  String endDate;
  String birthdayCafeName;
  String progressState;
  Artist artist;

  HostMyCafeModel({
    required this.birthdayCafeId,
    required this.mainImageUrl,
    required this.startDate,
    required this.endDate,
    required this.birthdayCafeName,
    required this.progressState,
    required this.artist,
  });

  factory HostMyCafeModel.fromJson(Map<String, dynamic> json) {
    return HostMyCafeModel(
      birthdayCafeId: json['birthdayCafeId'],
      mainImageUrl: json['mainImageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      birthdayCafeName: json['birthdayCafeName'],
      progressState: json['progressState'],
      artist: Artist.fromJson(json['artist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birthdayCafeId': birthdayCafeId,
      'mainImageUrl': mainImageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'birthdayCafeName': birthdayCafeName,
      'progressState': progressState,
      'artist': artist.toJson(),
    };
  }
}

class Artist {
  final String? groupName;
  final String name;

  Artist({
    this.groupName,
    required this.name,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      groupName: json['groupName'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'name': name,
    };
  }
}
