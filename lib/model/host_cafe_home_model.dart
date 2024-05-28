class HostCafeHomeModel {
  int cafeId;
  bool liked;
  String cafeImageUrl;
  String twitterAccount;
  String address;

  HostCafeHomeModel({
    required this.cafeId,
    required this.liked,
    required this.cafeImageUrl,
    required this.twitterAccount,
    required this.address,
  });

  factory HostCafeHomeModel.fromJson(Map<String, dynamic> json) {
    return HostCafeHomeModel(
      cafeId: json['cafeId'],
      liked: json['liked'],
      cafeImageUrl: json['cafeImageUrl'],
      twitterAccount: json['twitterAccount'],
      address: json['address'],
    );
  }
}
