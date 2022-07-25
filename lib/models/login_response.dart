

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.data,
  });

  String token;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.fullName,
    required this.merchantId,
    required this.stationId,
    required this.userId,
  });

  String fullName;
  int merchantId;
  int stationId;
  int userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fullName: json["fullName"],
    merchantId: json["merchantId"],
    stationId: json["stationId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "merchantId": merchantId,
    "stationId": stationId,
    "userId": userId,
  };
}
