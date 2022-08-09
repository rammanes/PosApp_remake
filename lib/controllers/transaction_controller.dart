

import 'dart:convert';

import 'package:get/get.dart';
import 'package:terminal_app/data/repository/transaction_repo.dart';
import 'package:terminal_app/models/transaction_model.dart';

class TransactionController extends GetxController implements GetxService{
  final AppTransactionsListRepo appTransactionsListRepo;
  TransactionController({required this.appTransactionsListRepo});
  bool loading = false;
  List<dynamic> transactionModel=[];
  TransactionModel? transaction;

  Future<void> getTerminalTransaction() async{
    loading = true;
    update();
    Response response = await appTransactionsListRepo.getAppTransactionList();
    //print(response.statusCode);
    if(response.statusCode == 200){
      transactionModel = [];
      transactionModel.addAll(transactionModelFromJson(jsonEncode(response.body)));
      loading = false;
    }
   loading = false;
    update();
  }
}
