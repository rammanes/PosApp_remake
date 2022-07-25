import 'package:get/get.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';

import '../../models/app_model.dart';
// Daily Transaction counts and sale total
class DailyTransactionRepo extends GetxService{
  final ApiClient apiClient;
  DailyTransactionRepo({required this.apiClient});
  int dailySales= 0;
  DailyTransactionModel? dailyTransactionModel;

  Future<Response> getDailyTransaction() async {
    Response response = await apiClient.getDailyTransactions(AppConstants.DAILY_TRANSACTION_URI);
    return response;
  }


  int dailyTransactionCount(List<dynamic> dailyTransactionList) {
    int count =0;
    if(dailyTransactionList == null){
      return 0;
    }else {
      for(int index = 0; index < dailyTransactionList.length; index++) {
        count += 1;
        dailySales += dailyTransactionModel!.amount;
      }
      return count;
    }
  }
}