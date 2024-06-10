
class HostCafeHomeDetailModel {
  bool liked;
  String name;
  String twitterAccount;
  String address;
  String businessHours;
  List<RentalSchedule> rentalSchedules;
  List<String> cafeImages;
  List<CafeMenu> cafeMenus;
  List<CafeOption> cafeOptions;

  HostCafeHomeDetailModel({
    required this.liked,
    required this.name,
    required this.twitterAccount,
    required this.address,
    required this.businessHours,
    required this.rentalSchedules,
    required this.cafeImages,
    required this.cafeMenus,
    required this.cafeOptions,
  });

  factory HostCafeHomeDetailModel.fromJson(Map<String, dynamic> json) {
    return HostCafeHomeDetailModel(
      liked: json['liked'],
      name: json['name'],
      twitterAccount: json['twitterAccount'],
      address: json['address'],
      businessHours: json['businessHours'],
      rentalSchedules: List<RentalSchedule>.from(json['rentalSchedules'].map((schedule) => RentalSchedule.fromJson(schedule))),
      cafeImages: List<String>.from(json['cafeImages']),
      cafeMenus: List<CafeMenu>.from(json['cafeMenus'].map((menu) => CafeMenu.fromJson(menu))),
      cafeOptions: List<CafeOption>.from(json['cafeOptions'].map((option) => CafeOption.fromJson(option))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'liked':liked,
      'name': name,
      'twitterAccount': twitterAccount,
      'address': address,
      'businessHours': businessHours,
      'rentalSchedules': rentalSchedules.map((schedule) => schedule.toJson()).toList(),
      'cafeImages': cafeImages,
      'cafeMenus': cafeMenus.map((menu) => menu.toJson()).toList(),
      'cafeOptions': cafeOptions.map((option) => option.toJson()).toList(),
    };
  }
}

class RentalSchedule {
  String startDate;
  String endDate;

  RentalSchedule({
    required this.startDate,
    required this.endDate,
  });

  factory RentalSchedule.fromJson(Map<String, dynamic> json) {
    return RentalSchedule(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class CafeMenu {
  String name;
  int price;

  CafeMenu({
    required this.name,
    required this.price,
  });

  factory CafeMenu.fromJson(Map<String, dynamic> json) {
    return CafeMenu(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}

class CafeOption {
  String name;
  int price;

  CafeOption({
    required this.name,
    required this.price,
  });

  factory CafeOption.fromJson(Map<String, dynamic> json) {
    return CafeOption(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
class HostRequestModel {
  final int artistId;
  final int cafeId;
  final String startDate;
  final String endDate;
  final int minimumVisitant;
  final int maximumVisitant;
  final String twitterAccount;
  final String hostPhoneNumber;

  HostRequestModel({
    required this.artistId,
    required this.cafeId,
    required this.startDate,
    required this.endDate,
    required this.minimumVisitant,
    required this.maximumVisitant,
    required this.twitterAccount,
    required this.hostPhoneNumber,
  });

  factory HostRequestModel.fromJson(Map<String, dynamic> json) {
    return HostRequestModel(
      artistId: json['artistId'],
      cafeId: json['cafeId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      minimumVisitant: json['minimumVisitant'],
      maximumVisitant: json['maximumVisitant'],
      twitterAccount: json['twitterAccount'],
      hostPhoneNumber: json['hostPhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artistId': artistId,
      'cafeId': cafeId,
      'startDate': startDate,
      'endDate': endDate,
      'minimumVisitant': minimumVisitant,
      'maximumVisitant': maximumVisitant,
      'twitterAccount': twitterAccount,
      'hostPhoneNumber': hostPhoneNumber,
    };
  }
}