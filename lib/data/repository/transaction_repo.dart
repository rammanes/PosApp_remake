

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';

class TransactionRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TransactionRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getTerminalTransaction() async{
    var merchantCode = await sharedPreferences.getInt("merchantId");
    return await apiClient.getTerminalTransaction(merchantCode!);
  }
}

class AppTransactionsListRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AppTransactionsListRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getAppTransactionList() async {
    var merchantId = await sharedPreferences.getInt("merchantId");
    return await apiClient.getTerminalTransaction(merchantId!);
  }
}