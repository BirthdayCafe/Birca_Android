class OwnerScheduleModel {
  int birthdayCafeId;
  String startDate;
  String endDate;

  OwnerScheduleModel({
    required this.birthdayCafeId,
    required this.startDate,
    required this.endDate,
  });

  factory OwnerScheduleModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleModel(
      birthdayCafeId: json['birthdayCafeId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

class OwnerScheduleAddModel {
  Artist artist;
  String startDate;
  String endDate;
  int minimumVisitants;
  int maximumVisitants;
  String twitterAccount;
  String hostPhoneNumber;

  OwnerScheduleAddModel({
    required this.artist,
    required this.startDate,
    required this.endDate,
    required this.minimumVisitants,
    required this.maximumVisitants,
    required this.twitterAccount,
    required this.hostPhoneNumber,
  });

  factory OwnerScheduleAddModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleAddModel(
      artist: Artist.fromJson(json['artist']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      minimumVisitants: json['minimumVisitants'],
      maximumVisitants: json['maximumVisitants'],
      twitterAccount: json['twitterAccount'],
      hostPhoneNumber: json['hostPhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artist': artist.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'minimumVisitants': minimumVisitants,
      'maximumVisitants': maximumVisitants,
      'twitterAccount': twitterAccount,
      'hostPhoneNumber': hostPhoneNumber,
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
