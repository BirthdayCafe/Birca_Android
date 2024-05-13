class OwnerRequestDetailModel {
  int birthdayCafeId;
  String startDate;
  String endDate;
  Artist artist;
  int minimumVisitants;
  int maximumVisitants;
  String twiiterAccount;
  String hostPhoneNumber;

  OwnerRequestDetailModel(
      {required this.birthdayCafeId,
      required this.minimumVisitants,
      required this.maximumVisitants,
      required this.startDate,
      required this.endDate,
      required this.twiiterAccount,
      required this.artist,
      required this.hostPhoneNumber});

  factory OwnerRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return OwnerRequestDetailModel(
        birthdayCafeId: json['birthdayCafeId'],
        minimumVisitants: json['minimumVisitants'],
        maximumVisitants: json['maximumVisitants'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        twiiterAccount: json['twiiterAccount'],
        artist: Artist.fromJson(json['artist']),
        hostPhoneNumber: json['hostPhoneNumber']);
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
