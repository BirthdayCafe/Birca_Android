
class BusinessLicenseModel{

  final String cafeName;
  final String businessLicenseNumber;
  final String owner;
  final String address;
  final int uploadCount;

  BusinessLicenseModel({
    required this.cafeName,
    required this.businessLicenseNumber,
    required this.owner,
    required this.address,
    required this.uploadCount
  });

  factory BusinessLicenseModel.fromJson(Map<String, dynamic> json){
    return BusinessLicenseModel(cafeName: json['cafeName'],
        businessLicenseNumber: json['businessLicenseNumber'],
        owner: json['owner'], address: json['address'], uploadCount: json['uploadCount']);
  }
}