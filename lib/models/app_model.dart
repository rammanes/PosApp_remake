import 'dart:convert';

List<DailyTransactionModel> dailyTransactionModelFromJson(String str) => List<DailyTransactionModel>.from(json.decode(str).map((x) => DailyTransactionModel.fromJson(x)));

String dailyTransactionModelToJson(List<DailyTransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyTransactionModel {
  DailyTransactionModel({
    required this.id,
    required this.vcardId,
    required this.merchantId,
    required this.deviceId,
    required this.stationId,
    required this.amount,
    required this.balance,
    required this.comAmount,
    required this.referenceNo,
    required this.product,
    required this.location,
    required this.status,
    required this.attendant,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int vcardId;
  int merchantId;
  int deviceId;
  int stationId;
  int amount;
  int balance;
  double comAmount;
  String referenceNo;
  String product;
  String location;
  String status;
  dynamic attendant;
  DateTime createdAt;
  DateTime updatedAt;

  factory DailyTransactionModel.fromJson(Map<String, dynamic> json) => DailyTransactionModel(
    id: json["id"],
    vcardId: json["vcard_id"],
    merchantId: json["merchant_id"],
    deviceId: json["device_id"],
    stationId: json["station_id"],
    amount: json["amount"],
    balance: json["balance"],
    comAmount: json["com_amount"].toDouble(),
    referenceNo: json["reference_no"],
    product: json["product"],
    location: json["location"],
    status: json["status"],
    attendant: json["attendant"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vcard_id": vcardId,
    "merchant_id": merchantId,
    "device_id": deviceId,
    "station_id": stationId,
    "amount": amount,
    "balance": balance,
    "com_amount": comAmount,
    "reference_no": referenceNo,
    "product": product,
    "location": location,
    "status": status,
    "attendant": attendant,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
