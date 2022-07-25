import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:terminal_app/component/app_constant.dart';

import '../api/api_client.dart';

class ScanRepo extends GetxService{
  final ApiClient apiClient;
  ScanRepo({required this.apiClient});
  final bool isAndroid = Platform.isAndroid;


  Future<Response> getCardUserInfo(String userIdentifier) async {
    return await  apiClient.getCardUserInfo(AppConstants.MERCHANT_INFO_URI, userIdentifier);
  }

  Future<bool> isNfcAvailable() async {
    return NfcManager.instance.isAvailable();
  }

  Future<void> closeSession() async {
    Future.delayed(const Duration(seconds: 5),()=> NfcManager.instance.stopSession());
  }

  String cleanIdentifier(String identifierString){
    var tempIdentifierString = identifierString.replaceAll(", ", "");
    var finalIdentifierString = tempIdentifierString.substring(1, tempIdentifierString.length-1);
    return finalIdentifierString;
  }
  // verify if the user balance is sufficient for the transaction
  bool checkBalance(int userBalance, int inputAmount){
    return (userBalance >= inputAmount);
  }

  //verify if the daily limit constrained is satisfied
  bool dailyLimitIsSatisfied(int inputAmount, int dailyLimit){
    return(dailyLimit >= inputAmount);
  }

  //verify if user can trade product category
  bool isValidTransaction(String categories, String inputCategory){
    if(categories != null){
      var categoryToList =  categories.split(',');
      var listToString = categoryToList.toString().replaceAll(" ", "");
      return listToString.contains(inputCategory);
    }
    return false;
  }
}