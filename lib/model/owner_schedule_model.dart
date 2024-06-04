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
  int minimumVisitants;
  int maximumVisitants;
  String twitterAccount;
  String hostPhoneNumber;

  OwnerScheduleAddModel({
    required this.artistId,
    required this.startDate,
    required this.endDate,
    required this.minimumVisitants,
    required this.maximumVisitants,
    required this.twitterAccount,
    required this.hostPhoneNumber,
  });

  factory OwnerScheduleAddModel.fromJson(Map<String, dynamic> json) {
    return OwnerScheduleAddModel(
      artistId: json['artistId'],
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
      'artistId': artistId,
      'startDate': startDate,
      'endDate': endDate,
      'minimumVisitants': minimumVisitants,
      'maximumVisitants': maximumVisitants,
      'twitterAccount': twitterAccount,
      'hostPhoneNumber': hostPhoneNumber,
    };
  }
}
