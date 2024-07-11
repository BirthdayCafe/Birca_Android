class Artist {
  String? groupName;
  String name;

  Artist({
    required this.groupName,
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

class OwnerScheduleModel {
  int birthdayCafeId;
  String nickname;
  Artist artist;
  String startDate;
  String endDate;
  String memo;

  OwnerScheduleModel({
    required this.birthdayCafeId,
    required this.nickname,
    required this.artist,
    required this.startDate,
    required this.endDate,
    required this.memo,

  });

  factory OwnerScheduleModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleModel(
      birthdayCafeId: json['birthdayCafeId'],
      nickname: json['nickname'],
      artist: Artist.fromJson(json['artist']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      memo: json['memo'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birthdayCafeId': birthdayCafeId,
      'nickname': nickname,
      'artist': artist.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'memo':memo
    };
  }
}

class OwnerScheduleAddModel {
  int artistId;
  String startDate;
  String endDate;
  int minimumVisitant;
  int maximumVisitant;
  String twitterAccount;
  String hostPhoneNumber;

  OwnerScheduleAddModel({
    required this.artistId,
    required this.startDate,
    required this.endDate,
    required this.minimumVisitant,
    required this.maximumVisitant,
    required this.twitterAccount,
    required this.hostPhoneNumber,
  });

  factory OwnerScheduleAddModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleAddModel(
      artistId: json['artistId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      minimumVisitant: json['minimumVisitant'],
      maximumVisitant: json['maximumVisitant'],
      twitterAccount: json['twitterAccount'],
      hostPhoneNumber: json['hostPhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artistId': artistId,
      'startDate': startDate,
      'endDate': endDate,
      'minimumVisitant': minimumVisitant,
      'maximumVisitant': maximumVisitant,
      'twitterAccount': twitterAccount,
      'hostPhoneNumber': hostPhoneNumber,
    };
  }
}

class OwnerScheduleExistModel {
  int startYear;
  int startMonth;
  int startDay;
  int endYear;
  int endMonth;
  int endDay;

  OwnerScheduleExistModel(
      {required this.startYear,
      required this.startMonth,
      required this.startDay,
      required this.endYear,
      required this.endMonth,
      required this.endDay});

  factory OwnerScheduleExistModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleExistModel(
      startYear: json['startYear'],
      startMonth: json['startMonth'],
      startDay: json['startDay'],
      endYear: json['endYear'],
      endMonth: json['endMonth'],
      endDay: json['endDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startYear': startYear,
      'startMonth': startMonth,
      'startDay': startDay,
      'endYear': endYear,
      'endMonth': endMonth,
      'endDay': endDay,
    };
  }
}
