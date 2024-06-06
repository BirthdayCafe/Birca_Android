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
