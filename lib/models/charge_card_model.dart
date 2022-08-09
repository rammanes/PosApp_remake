import 'dart:convert';

ChargeCardPayloadModel chargeCardModelFromJson(String str) => ChargeCardPayloadModel.fromJson(json.decode(str));

String chargeCardModelToJson(ChargeCardPayloadModel data) => json.encode(data.toJson());

class ChargeCardPayloadModel {
  ChargeCardPayloadModel({
    required this.deviceId,
    required this.merchantId,
    required this.vcardId,
    required this.amount,
    required this.station_id,
    required this.product,
    required this.location,
  });

  int deviceId;
  int merchantId;
  int vcardId;
  int amount;
  int station_id;
  String product;
  String location;

  factory ChargeCardPayloadModel.fromJson(Map<String, dynamic> json) => ChargeCardPayloadModel(
    deviceId: json["device_id"],
    merchantId: json["merchant_id"],
    vcardId: json["vcard_id"],
    amount: json["amount"],
    station_id: json["station_id"],
    product: json["product"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "merchant_id": merchantId,
    "vcard_id": vcardId,
    "amount": amount,
    "station_id":station_id,
    "product": product,
    "location": location,
  };
}


ChargeCardResponseModel chargeCardResponseModelFromJson(String str) => ChargeCardResponseModel.fromJson(json.decode(str));

String chargeCardResponseModelToJson(ChargeCardResponseModel data) => json.encode(data.toJson());

class ChargeCardResponseModel {
  ChargeCardResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory ChargeCardResponseModel.fromJson(Map<String, dynamic> json) => ChargeCardResponseModel(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.deviceId,
    required this.merchantId,
    required this.vcardId,
    required this.amount,
    required this.product,
    required this.location,
    required this.balance,
    required this.comAmount,
    required this.referenceNo,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int deviceId;
  int merchantId;
  int vcardId;
  int amount;
  String product;
  String location;
  int balance;
  int comAmount;
  String referenceNo;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deviceId: json["device_id"],
    merchantId: json["merchant_id"],
    vcardId: json["vcard_id"],
    amount: json["amount"],
    product: json["product"],
    location: json["location"],
    balance: json["balance"],
    comAmount: json["com_amount"],
    referenceNo: json["reference_no"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "merchant_id": merchantId,
    "vcard_id": vcardId,
    "amount": amount,
    "product": product,
    "location": location,
    "balance": balance,
    "com_amount": comAmount,
    "reference_no": referenceNo,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

class ReceiptModel{
  String transactionDate;
  String transCategory;
  String transactionAmount;
  String transactionType;
  String transactionStatus;

  ReceiptModel({required this.transactionDate, required this.transCategory, required this.transactionAmount, required this.transactionType, required this.transactionStatus});

}