

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
  int _transactionCount = 0;
  int _dailySales = 0;
  //List<dynamic> dailyTransactionModel;

  bool get isSuccess => _isSuccess;
  bool get isLoading => _isLoading;
  int get transactionCount => _transactionCount;
  int get dailySales => _dailySales;
  List<DailyTransactionModel> get dailyTransactionModel => _dailyTransactionModel;



  Future<void> getDailyTransactions() async {
    _isLoading = true;
    _isSuccess = false;
    int dailySum = 0;
    update();
    Response response = await dailyTransactionRepo.getDailyTransaction();
    if(response.statusCode == 200){

      _dailyTransactionModel = [];
      //DailyTransactionModel transactionModel = DailyTransactionModel.fromJson(response.body);
      _dailyTransactionModel.addAll(dailyTransactionModelFromJson(jsonEncode(response.body)));
      _transactionCount = dailyTransactionModel.length;
       _dailyTransactionModel.forEach((element) {
         dailySum += element.amount;
       });
       _dailySales = dailySum;
      print(dailySum);
      print(_transactionCount);
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