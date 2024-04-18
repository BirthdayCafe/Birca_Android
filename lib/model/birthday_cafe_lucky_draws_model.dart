class BirthdayCafeLuckyDrawsModel{
  int rank;
  String prize;

  BirthdayCafeLuckyDrawsModel({required this.rank, required this.prize});

  factory BirthdayCafeLuckyDrawsModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeLuckyDrawsModel(
      rank: json['rank'],
      prize: json['prize'],
    );
  }
}