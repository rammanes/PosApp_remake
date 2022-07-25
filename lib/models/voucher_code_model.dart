// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VoucherCodeModel voucherCodeFromJson(String str) => VoucherCodeModel.fromJson(json.decode(str));

String voucherCodeToJson(VoucherCodeModel data) => json.encode(data.toJson());

class VoucherCodeModel {
  VoucherCodeModel({
    required this.id,
    required this.profileId,
    required this.merchantId,
    required this.pin,
    required this.expirationDate,
    required this.amount,
    required this.product,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
    required this.merchant,
  });

  int id;
  int profileId;
  int merchantId;
  String pin;
  String expirationDate;
  String amount;
  String product;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Profile profile;
  Merchant merchant;

  factory VoucherCodeModel.fromJson(Map<String, dynamic> json) => VoucherCodeModel(
    id: json["id"],
    profileId: json["profile_id"],
    merchantId: json["merchant_id"],
    pin: json["pin"],
    expirationDate: json["expiration_date"],
    amount: json["amount"],
    product: json["product"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profile: Profile.fromJson(json["profile"]),
    merchant: Merchant.fromJson(json["merchant"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_id": profileId,
    "merchant_id": merchantId,
    "pin": pin,
    "expiration_date": expirationDate,
    "amount": amount,
    "product": product,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "profile": profile.toJson(),
    "merchant": merchant.toJson(),
  };
}

class Merchant {
  Merchant({
    required this.id,
    required this.userId,
    required this.bankAccount,
    required this.bankName,
    required this.numberOfStations,
    required this.depositedFund,
    required this.status,
    required this.totalDevices,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String bankAccount;
  String bankName;
  int numberOfStations;
  String depositedFund;
  dynamic status;
  String totalDevices;
  String commission;
  DateTime createdAt;
  DateTime updatedAt;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["id"],
    userId: json["user_id"],
    bankAccount: json["bank_account"]?? '',
    bankName: json["bank_name"],
    numberOfStations: json["number_of_stations"]??'',
    depositedFund: json["deposited_fund"],
    status: json["status"],
    totalDevices: json["total_devices"]??'',
    commission: json["commission"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_account": bankAccount,
    "bank_name": bankName,
    "number_of_stations": numberOfStations,
    "deposited_fund": depositedFund,
    "status": status,
    "total_devices": totalDevices,
    "commission": commission,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Profile {
  Profile({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String name;
  String address;
  String phone;
  dynamic email;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

String voucherPayloadToJson(VoucherPayloadModel data) => json.encode(data.toJson());
VoucherPayloadModel voucherPayloadFromJson(String str) => VoucherPayloadModel.fromJson(json.decode(str));
class VoucherPayloadModel {
  VoucherPayloadModel({
    required this.vcardId,
    required this.merchantId,
    required this.deviceId,
    required this.amount,
    required this.location,
    required this.status,
    required this.commission,
    required this.product
  });

  int vcardId;
  int merchantId;
  int deviceId;
  String amount;
  String location;
  String status;
  double commission;
  String product;

  factory VoucherPayloadModel.fromJson(Map<String, dynamic> json) => VoucherPayloadModel(
      vcardId: json['vcard_id'],
      merchantId:json['merchant_id'],
      deviceId:json['device_id'],
      amount: json['amount'],
      location: json['location'],
      status:json['status'],
      commission:json['com_amount'],
      product:json['product']
  );
  Map<String, dynamic> toJson() => {
    "vcard_id": vcardId,
    "merchant_id": merchantId,
    "device_id": deviceId,
    "amount": amount,
    "location": location,
    "status": status,
    "com_amount": commission,
    "product": product,
  };
}

class UserChargeInfo{
  String name;
  String phone;
  String pin;

  UserChargeInfo({required this.name, required this.phone, required this.pin});
}