class OwnerMyCafeDetailModel {
  String cafeName;
  String cafeAddress;
  String twitterAccount;
  String businessHours;
  List<MenuModel> cafeMenus;
  List<OptionModel> cafeOptions;
  List<String> cafeImages;

  OwnerMyCafeDetailModel({
    required this.cafeName,
    required this.cafeAddress,
    required this.twitterAccount,
    required this.businessHours,
    required this.cafeMenus,
    required this.cafeOptions,
    required this.cafeImages,
  });

  factory OwnerMyCafeDetailModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> menuList = json['cafeMenus'] ?? [];
    List<dynamic> optionList = json['cafeOptions'] ?? [];
    List<dynamic> imageList = json['cafeImages'] ?? [];

    return OwnerMyCafeDetailModel(
        cafeName: json['cafeName'],
        cafeAddress: json['cafeAddress'],
        twitterAccount: json['twitterAccount'],
        businessHours: json['businessHours'],
        cafeMenus: menuList.map((menu) => MenuModel.fromJson(menu)).toList(),
        cafeOptions:
            optionList.map((option) => OptionModel.fromJson(option)).toList(),
        cafeImages: imageList.map((image) => image.toString()).toList());
  }
}

class MenuModel {
   String name;
   int price;

  MenuModel({required this.name, required this.price});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      name: json['name'],
      price: json['price'],
    );
  }

   Map<String, Object> toMap() {
     return {
       'name': name,
       'price': price,
     };
   }
}

class OptionModel {
   String name;
   int price;

  OptionModel({required this.name, required this.price});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      name: json['name'],
      price: json['price'],
    );
  }

   Map<String, Object> toMap() {
     return {
       'name': name,
       'price': price,
     };
   }
}
