class ArtistModel {
  final int groupId;
  final String groupName;
  final String groupImage;

  ArtistModel({
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });
  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      groupId: json['artistId'],
      groupName: json['artistName'],
      groupImage: json['artistImage'],
    );
  }
}
