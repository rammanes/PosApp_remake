

import 'package:get/get.dart';
import 'package:terminal_app/data/repository/voucher_repo.dart';
import 'package:terminal_app/models/voucher_code_model.dart';

class VoucherController extends GetxController implements GetxService{
  final VoucherRepo voucherRepo;
  VoucherController({required this.voucherRepo});
  bool loading = false;
  bool isUsed = false;
  VoucherCodeModel? voucherCodeModel;
  VoucherPayloadModel? voucherPayloadModel;

  Future<bool> getVoucherUserInfo(String voucherCode) async {
    loading = true;
    update();
    Response response = await voucherRepo.getVoucherUserInfo(voucherCode);
    if(response.statusCode==200){
      loading= false;
      voucherCodeModel = VoucherCodeModel.fromJson(response.body);
      update();
      return true;
    }

    loading = false;
    update();
    return false;
  }

  Future<bool> sendVoucherPayloadInformation(String voucherCode) async {
    loading = true;
    update();
    Response response = await voucherRepo.sendVoucherPayloadInformation(voucherCode);
    print(response.statusCode);
    if(response.statusCode == 200){
      voucherPayloadModel = VoucherPayloadModel.fromJson(response.body);
      loading = false;
      isUsed= false;
      update();
      return true;
    }else if(response.statusCode == 406){
      isUsed= true;
      loading = false;
      update();
      return false;
    }
    loading = false;
    update();
    return false;
  }
}