class SoloArtistModel {
  final int groupId;
  final String groupName;
  final String groupImage;

  SoloArtistModel({
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });
  factory SoloArtistModel.fromJson(Map<String, dynamic> json) {
    return SoloArtistModel(
      groupId: json['artistId'],
      groupName: json['artistName'],
      groupImage: json['artistImage'],
    );
  }
}
