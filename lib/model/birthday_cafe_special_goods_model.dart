class BirthdayCafeSpecialGoodsModel{
  String name;
  String details;

  BirthdayCafeSpecialGoodsModel({required this.name, required this.details});

  factory BirthdayCafeSpecialGoodsModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeSpecialGoodsModel(
      name: json['name'],
      details: json['details'],
    );
  }
}