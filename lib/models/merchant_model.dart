// To parse this JSON data, do
//
//     final merchantModel = merchantModelFromJson(jsonString);

import 'dart:convert';

MerchantModel merchantModelFromJson(String str) => MerchantModel.fromJson(json.decode(str));

String merchantModelToJson(MerchantModel data) => json.encode(data.toJson());

class MerchantModel {
  MerchantModel({
    required this.id,
    required this.profileId,
    required this.merchantId,
    required this.cardUid,
    required this.cardNumber,
    required this.pin,
    required this.status,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.expirationDate,
    required this.commission,
    required this.cardType,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
    required this.merchant,
    required this.dailyTransactionLimit,
  });

  int id;
  int profileId;
  int merchantId;
  String cardUid;
  String cardNumber;
  String pin;
  int status;
  int dailyLimit;
  int monthlyLimit;
  DateTime expirationDate;
  int commission;
  String cardType;
  String products;
  DateTime createdAt;
  DateTime updatedAt;
  Profile profile;
  Merchant merchant;
  dynamic dailyTransactionLimit;

  factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
    id: json["id"],
    profileId: json["profile_id"],
    merchantId: json["merchant_id"],
    cardUid: json["card_uid"],
    cardNumber: json["card_number"],
    pin: json["pin"],
    status: json["status"],
    dailyLimit: json["daily_limit"],
    monthlyLimit: json["monthly_limit"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    commission: json["commission"],
    cardType: json["card_type"],
    products: json["products"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profile: Profile.fromJson(json["profile"]),
    merchant: Merchant.fromJson(json["merchant"]),
    dailyTransactionLimit: json["daily_transaction_limit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_id": profileId,
    "merchant_id": merchantId,
    "card_uid": cardUid,
    "card_number": cardNumber,
    "pin": pin,
    "status": status,
    "daily_limit": dailyLimit,
    "monthly_limit": monthlyLimit,
    "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    "commission": commission,
    "card_type": cardType,
    "products": products,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "profile": profile.toJson(),
    "merchant": merchant.toJson(),
    "daily_transaction_limit": dailyTransactionLimit,
  };
}

class Merchant {
  Merchant({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.numberOfStations,
    required this.depositedFund,
    required this.commission,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.numberOfTerminals,
    required this.user,
    required this.devices,
  });

  int id;
  int userId;
  String accountNumber;
  String accountName;
  String bankName;
  int numberOfStations;
  String depositedFund;
  String commission;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  int numberOfTerminals;
  User user;
  List<Device> devices;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["id"],
    userId: json["user_id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    numberOfStations: json["number_of_stations"],
    depositedFund: json["deposited_fund"],
    commission: json["commission"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    numberOfTerminals: json["number_of_terminals"],
    user: User.fromJson(json["user"]),
    devices: List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "number_of_stations": numberOfStations,
    "deposited_fund": depositedFund,
    "commission": commission,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "number_of_terminals": numberOfTerminals,
    "user": user.toJson(),
    "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
  };
}

class Device {
  Device({
    required this.id,
    required this.deviceId,
    required this.merchantId,
    required this.stationId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int deviceId;
  int merchantId;
  int stationId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    deviceId: json["device_id"],
    merchantId: json["merchant_id"],
    stationId: json["station_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "device_id": deviceId,
    "merchant_id": merchantId,
    "station_id": stationId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.emailVerifiedAt,
    required this.profileType,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
  });

  int id;
  String name;
  String username;
  DateTime emailVerifiedAt;
  String profileType;
  DateTime createdAt;
  DateTime updatedAt;
  Profile profile;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    profileType: json["profile_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "profile_type": profileType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "profile": profile.toJson(),
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
    required this.status,
    required this.city,
    required this.state,
    required this.business,
  });

  int id;
  int userId;
  String name;
  String address;
  String phone;
  String email;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  dynamic city;
  dynamic state;
  dynamic business;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"] == null ? "" : json["email"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
    city: json["city"],
    state: json["state"],
    business: json["business"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email == null ? null : email,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "city": city,
    "state": state,
    "business": business,
  };
}
