

import 'package:get/get.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';

class TransactionRepo{
  final ApiClient apiClient;
  TransactionRepo({required this.apiClient});


  Future<Response> getTerminalTransaction() async{
    return await apiClient.getTerminalTransaction(AppConstants.TRANSACTION_URL);
  }
}