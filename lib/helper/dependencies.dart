
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/controllers/app_controller.dart';
import 'package:terminal_app/controllers/charge_controller.dart';
import 'package:terminal_app/controllers/scan_controller.dart';
import 'package:terminal_app/controllers/transaction_controller.dart';
import 'package:terminal_app/controllers/user_controller.dart';
import 'package:terminal_app/controllers/voucher_controller.dart';
import 'package:terminal_app/data/api/api_client.dart';
import 'package:terminal_app/data/repository/app_repo.dart';
import 'package:terminal_app/data/repository/charge_card_repo.dart';
import 'package:terminal_app/data/repository/scan_repo.dart';
import 'package:terminal_app/data/repository/transaction_repo.dart';
import 'package:terminal_app/data/repository/user_repo.dart';
import 'package:terminal_app/data/repository/voucher_repo.dart';
import 'package:terminal_app/models/app_model.dart';

import '../component/api.dart';


Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: baseUrl));
  
  //repos
  Get.lazyPut(() => DailyTransactionRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ScanRepo(apiClient: Get.find()));
  Get.lazyPut(() => ChargeCardRepo(apiClient: Get.find()));
  Get.lazyPut(() => VoucherRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => DailyTransactionController(dailyTransactionRepo: Get.find()));
  Get.lazyPut(() => ScanController(scanRepo: Get.find()));
  Get.lazyPut(() => ChargeCardController(chargeCardRepo: Get.find()));
  Get.lazyPut(() => VoucherController(voucherRepo: Get.find()));
  Get.lazyPut(() => TransactionController(transactionRepo: Get.find()));

}