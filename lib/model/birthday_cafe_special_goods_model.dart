class BirthdayCafeSpecialGoodsModel {
  String name;
  String details;

  BirthdayCafeSpecialGoodsModel({required this.name, required this.details});

  factory BirthdayCafeSpecialGoodsModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeSpecialGoodsModel(
      name: json['name'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'details': details,
    };
  }

  Map<String, Object> toMap() {
    return {
      'name': name,
      'details': details,
    };
  }
}
