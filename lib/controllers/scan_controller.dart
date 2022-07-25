

import 'dart:async';
import 'package:get/get.dart';
import 'package:terminal_app/data/repository/scan_repo.dart';
import 'package:terminal_app/helper/tag_card_dependencies.dart';
import '../models/merchant_model.dart';

class ScanController extends GetxController implements GetxService{
  final ScanRepo scanRepo;
  ScanController({required this.scanRepo});
  //local variables
  bool loading = false;
  MerchantModel? merchantModel;
  bool isBalanceChecked = false;
  var userInfo;
  var userBalance;
  var userProductsCategory;
  var userDailyLimit;


  //local methods
  Future<bool> getScanMetaDataFromDB(var cardTagScanData) async{
    loading = true;
    update();
    Response response = await scanRepo.getCardUserInfo(TagScanHelper.readCardMetaData(cardTagScanData));
    if(response.statusCode == 200){
      merchantModel = MerchantModel.fromJson(response.body);
      userInfo = merchantModel!.merchant.user.profile;
      userBalance = merchantModel!.profile.balance;
      userProductsCategory = merchantModel!.products;
      userDailyLimit = merchantModel!.dailyLimit;
      loading = false;
      update();
      return true;
    }else{
      loading = false;
      return false;
    }
  }
  // verify if the user balance is sufficient for the transaction
  bool checkBalance(int userBalance, int inputAmount){
    return scanRepo.checkBalance(userBalance, inputAmount);
  }

  //verify if the daily limit constrained is satisfied
  bool dailyLimitIsSatisfied(int inputAmount, int dailyLimit){
    return scanRepo.dailyLimitIsSatisfied(inputAmount, dailyLimit);
  }

  //verify if user can trade product category
  bool isValidTransaction(String categories, String inputCategory){
    return scanRepo.isValidTransaction(categories, inputCategory);
  }

}