class HostCafeHomeModel {
  int cafeId;
  bool liked;
  String name;
  String cafeImageUrl;
  String twitterAccount;
  String address;

  HostCafeHomeModel({
    required this.cafeId,
    required this.liked,
    required this.name,
    required this.cafeImageUrl,
    required this.twitterAccount,
    required this.address,
  });

  factory HostCafeHomeModel.fromJson(Map<String, dynamic> json) {
    return HostCafeHomeModel(
      cafeId: json['cafeId'],
      liked: json['liked'],
      name: json['name'],
      cafeImageUrl: json['cafeImageUrl'],
      twitterAccount: json['twitterAccount'],
      address: json['address'],
    );
  }
}
