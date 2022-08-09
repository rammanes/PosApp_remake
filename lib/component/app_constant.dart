import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class AppConstants{


  static const String APP_NAME = "";
  static const String BASE_URL =  "https://wavu-endpoint.herokuapp.com/api";
  static const String LOGIN_URI = "/sanctum/token";

  // remake the daily transaction end
  // static const String DAILY_TRANSACTION_URI = "/vcards/4/dailytransactions";
  static const String MERCHANT_INFO_URI = "/pos/vcard/";
  static const String CHARGE_CARD_PAYLOAD = "/pos/vcard/charge";
  static const String VOUCHER_CARD_URL = "/pos/vouchers/";

  // remake the transaction url end
  // static const String TRANSACTION_URL ="/pos/merchants/4/devices/14";

  static const String TOKEN = "";
  static const String FULL_NAME = "";
  static const String MERCHANT_ID = "";
  static const String STATION_ID = "";
  static const String USER_ID = "";
  static const String WAITING_FOR_CARD = "Waiting for card";
  static const String PLACE_CARD = "Place NFC card behind this device";
}

