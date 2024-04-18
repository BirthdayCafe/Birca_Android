class BirthdayCafeMenusModel{

  String name;
  String details;
  int price;

  BirthdayCafeMenusModel({required this.name, required this.details, required this.price});

  factory BirthdayCafeMenusModel.fromJson(Map<String, dynamic> json) {
    return BirthdayCafeMenusModel(
      name: json['name'],
      details: json['details'],
      price: json['price'],
    );
  }

}