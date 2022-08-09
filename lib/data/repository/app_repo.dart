import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';

import '../../models/app_model.dart';
// Daily Transaction counts and sale total
class DailyTransactionRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  DailyTransactionRepo({required this.apiClient, required this.sharedPreferences});
  int dailySales= 0;
  DailyTransactionModel? dailyTransactionModel;





  Future <String> getMerchantId() async {
    return await sharedPreferences.getString(AppConstants.MERCHANT_ID)??"None";
  }

  Future<Response> getDailyTransaction() async {
    var merchantId = await sharedPreferences.getInt("merchantId");
    Response response = await apiClient.getDailyTransactions(merchantId!);
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