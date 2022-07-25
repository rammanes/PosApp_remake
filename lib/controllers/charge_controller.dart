
import 'package:get/get.dart';
import 'package:terminal_app/data/repository/charge_card_repo.dart';
import 'package:terminal_app/models/charge_card_model.dart';

class ChargeCardController extends GetxController implements GetxService{
  final ChargeCardRepo chargeCardRepo;
  ChargeCardController({required this.chargeCardRepo});

  bool loading = false;
  var cardResponseModel;

  Future<bool> implementCardChargePayload(ChargeCardPayloadModel cardPayloadModel) async {
    loading = true;
    update();
    Response response = await chargeCardRepo.implementSendCardChargePayload(cardPayloadModel);
    print(response.body);
    if(response.statusCode == 200){
      loading = false;
      cardResponseModel = ChargeCardResponseModel.fromJson(response.body);
      update();
      return true;
    }
    loading = true;
    update();
    return false;
  }

  int validateInputPin(int inputedPin, int userStoredPin){
    return chargeCardRepo.validateInputPin(inputedPin, userStoredPin);
  }

}