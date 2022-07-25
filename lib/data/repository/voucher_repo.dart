
import 'dart:convert';

import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';
import 'package:get/get.dart';
class VoucherRepo{
  final ApiClient apiClient;
  VoucherRepo({required this.apiClient});


  Future<Response> getVoucherUserInfo(String voucherCode) async {
    return await apiClient.getVoucherUserInfo(AppConstants.VOUCHER_CARD_URL, voucherCode);
  }

  Map<String, dynamic> voucherPayloadBody = {
    "device_id":14,
    "location": "Abuja",
    "status": "1"
  };

  Future<Response> sendVoucherPayloadInformation(String voucherCode) async {
    return await apiClient.sendVoucherPayloadInformation(AppConstants.VOUCHER_CARD_URL, voucherCode, 14, jsonEncode(voucherPayloadBody));
  }
}