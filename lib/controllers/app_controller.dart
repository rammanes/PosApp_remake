

import 'dart:convert';

import 'package:get/get.dart';
import 'package:terminal_app/data/repository/app_repo.dart';
import 'package:terminal_app/models/app_model.dart';

class DailyTransactionController extends GetxController implements GetxService{
  final DailyTransactionRepo dailyTransactionRepo;
  DailyTransactionController({required this.dailyTransactionRepo});

  List<DailyTransactionModel> _dailyTransactionModel = [];
  bool _isSuccess = false;
  bool _isLoading = false;
  var _transactionCount = 0.obs;
  var _dailySales = 0.obs;
  //List<dynamic> dailyTransactionModel;

  bool get isSuccess => _isSuccess;
  bool get isLoading => _isLoading;
  int get transactionCount => _transactionCount.value;
  int get dailySales => _dailySales.value;
  List<DailyTransactionModel> get dailyTransactionModel => _dailyTransactionModel;



  Future<void> getDailyTransactions() async {
    _isLoading = true;
    _isSuccess = false;
    int dailySum = 0;
   // update();
    Response response = await dailyTransactionRepo.getDailyTransaction();
    if(response.statusCode == 200){
      _dailyTransactionModel = [];
      _dailyTransactionModel.addAll(dailyTransactionModelFromJson(jsonEncode(response.body)));
      _transactionCount.value = dailyTransactionModel.length;
       _dailyTransactionModel.forEach((element) {
         dailySum += element.amount;
       });
       _dailySales.value = dailySum;
      _isLoading = false;
      _isSuccess = true;
      update();
    }
    _isLoading = true;
    _isSuccess = false;
    update();
  }

  // int dailyTransactionCount(List dailyTransactionList){
  //   return  dailyTransactionRepo.dailyTransactionCount(dailyTransactionList);
  // }

  List<String> _productCategories = ['PMS','AGO','DPK','LPG'];
  List<String> get productCategories => _productCategories;
}