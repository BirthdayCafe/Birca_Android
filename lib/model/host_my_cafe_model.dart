class HostMyCafeModel {
   int birthdayCafeId;
   String mainImageUrl;
   String startDate;
   String endDate;
   String birthdayCafeName;
   Artist artist;
   String progressState;


   HostMyCafeModel({
    required this.birthdayCafeId,
    required this.mainImageUrl,
    required this.startDate,
    required this.endDate,
    required this.birthdayCafeName,
    required this.artist,
    required this.progressState
  });

  factory HostMyCafeModel.fromJson(Map<String, dynamic> json) {
    return HostMyCafeModel(
        birthdayCafeId: json['birthdayCafeId'],
        mainImageUrl: json['mainImageUrl'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        birthdayCafeName: json['birthdayCafeName'],
        artist: Artist.fromJson(json['artist']),
    progressState: json['progressState']);
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

