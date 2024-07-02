class OwnerRequestDetailModel {
  int birthdayCafeId;
  String startDate;
  String endDate;
  Artist artist;
  int? minimumVisitant;
  int? maximumVisitant;
  String twitterAccount;
  String hostPhoneNumber;

  OwnerRequestDetailModel(
      {required this.birthdayCafeId,
      required this.minimumVisitant,
      required this.maximumVisitant,
      required this.startDate,
      required this.endDate,
      required this.twitterAccount,
      required this.artist,
      required this.hostPhoneNumber});

  factory OwnerRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return OwnerRequestDetailModel(
        birthdayCafeId: json['birthdayCafeId'],
        minimumVisitant: json['minimumVisitant'],
        maximumVisitant: json['maximumVisitant'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        twitterAccount: json['twitterAccount'],
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
