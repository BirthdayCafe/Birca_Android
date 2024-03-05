class GroupArtistModel {
  final int groupId;
  final String groupName;
  final String groupImage;

  GroupArtistModel({
    required this.groupId,
    required this.groupName,
    required this.groupImage,
  });
  factory GroupArtistModel.fromJson(Map<String, dynamic> json) {
    return GroupArtistModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupImage: json['groupImage'],
    );
  }
}