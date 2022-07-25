import 'package:get/get.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';
import 'package:terminal_app/models/charge_card_model.dart';

class ChargeCardRepo extends GetxService{
  final ApiClient apiClient;
  ChargeCardRepo({required this.apiClient});

  Future<Response> implementSendCardChargePayload(ChargeCardPayloadModel cardPayloadModel) async {
    return await apiClient.sendCardChargePayload(AppConstants.CHARGE_CARD_PAYLOAD, chargeCardModelToJson(cardPayloadModel));
  }
  int validateInputPin(int inputedPin, int  userStoredPin){
    return inputedPin.compareTo(userStoredPin);
  }

}