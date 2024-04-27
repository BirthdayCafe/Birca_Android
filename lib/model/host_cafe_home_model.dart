class HostCafeHomeModel {
   int birthdayCafeId;
   String mainImageUrl;
   String startDate;
   String endDate;
   String birthdayCafeName;
   Artist artist;
   String progressState;


   HostCafeHomeModel({
    required this.birthdayCafeId,
    required this.mainImageUrl,
    required this.startDate,
    required this.endDate,
    required this.birthdayCafeName,
    required this.artist,
    required this.progressState
  });

  factory HostCafeHomeModel.fromJson(Map<String, dynamic> json) {
    return HostCafeHomeModel(
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

