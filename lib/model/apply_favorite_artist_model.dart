class ApplyFavoriteArtistModel {
  final int artistId;
  
  ApplyFavoriteArtistModel({
    required this.artistId
  });
  
  factory ApplyFavoriteArtistModel.fromJson(Map<String, dynamic> json) {
    return ApplyFavoriteArtistModel(artistId: json['artistId']);
  }
}