class HostCafeHomeDetailModel {
  String name;
  String twitterAccount;
  String address;
  String businessHours;
  List<RentalSchedules> rentalSchedules;


  HostCafeHomeDetailModel({
    required this.name,
    required this.businessHours,
    required this.twitterAccount,
    required this.address,
    required this.rentalSchedules
  });

  factory HostCafeHomeDetailModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> schedule = json['rentalSchedules'] ?? [];

    return HostCafeHomeDetailModel(
      name: json['name'],
      businessHours: json['businessHours'],
      address: json['address'],
      twitterAccount: json['twitterAccount'],
      rentalSchedules: schedule.map((schedules) => RentalSchedules.fromJson(schedules)).toList(),

    );
  }
}

class RentalSchedules {
   String startDate;
   String endDate;

  RentalSchedules({required this.startDate, required this.endDate});

  factory RentalSchedules.fromJson(Map<String, dynamic> json) {
    return RentalSchedules(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}
