class ArtistSearchModel {
  final int artistId;
  final String artistName;
  final String artistImageUrl;
  final String groupName;

  ArtistSearchModel({
    required this.artistId,
    required this.artistName,
    required this.artistImageUrl,
    required this.groupName,
  });

  factory ArtistSearchModel.fromJson(Map<String, dynamic> json) {
    return ArtistSearchModel(
      artistId: json['artistId'],
      artistName: json['artistName'],
      artistImageUrl: json['artistImageUrl'],
      groupName: json['groupName'],
    );
  }
}
