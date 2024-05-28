class MypageModel {
  String nickname;

  MypageModel({
    required this.nickname,
  });

  factory MypageModel.fromJson(Map<String, dynamic> json) {
    return MypageModel(
      nickname: json['nickname'],
    );
  }
}
