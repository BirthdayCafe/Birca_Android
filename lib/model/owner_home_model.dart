class OwnerHomeModel {
  final int birthdayCafeId;
  final String hostName;
  final String startDate;
  final String endDate;
  final Artist artist;

  OwnerHomeModel({
    required this.hostName,
    required this.birthdayCafeId,
    required this.startDate,
    required this.endDate,
    required this.artist,
  });

  factory OwnerHomeModel.fromJson(Map<String, dynamic> json) {
    return OwnerHomeModel(
      birthdayCafeId: json['birthdayCafeId'],
      hostName: json['hostName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      artist: Artist.fromJson(json['artist']),
    );
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
