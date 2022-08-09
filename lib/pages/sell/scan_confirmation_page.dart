import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/charge_controller.dart';
import 'package:terminal_app/controllers/user_controller.dart';
import 'package:terminal_app/models/charge_card_model.dart';
import 'package:terminal_app/pages/sell/scan_successful_print.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/show_custom_message.dart';

import '../../models/merchant_model.dart';

class ScanConfirmationPage extends StatefulWidget {
  final MerchantModel merchantModel;
  final Map<String, String> transactionInfo;
  ScanConfirmationPage({Key? key, required this.merchantModel, required this.transactionInfo}) : super(key: key);

  @override
  State<ScanConfirmationPage> createState() => _ScanConfirmationPageState();
}

class _ScanConfirmationPageState extends State<ScanConfirmationPage> {
  TextEditingController pinController = TextEditingController();
  int? station_id;

  @override
  void initState(){
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appWhite,
      body: GetBuilder<ChargeCardController>(builder: (_chargeCardController){
        return _chargeCardController.loading?
            Center(child: Container(
              child: SpinKitFadingFour(
                itemBuilder: (BuildContext context, int index){
                  return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: index.isEven? Colors.red:Colors.green,
                      ));
                },
              ),
            )) :Container(
          height: height,
          width: width,
          margin: const EdgeInsets.only(left: 25, top: 80, right: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appGreyLight
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child:  Image.asset("images/beard.png", height: 40, width: 40,) ,
                          )
                        ],
                      ),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text( widget.merchantModel.profile.name, style: const TextStyle( fontSize: 16, color: appTextPrimary),),
                          const SizedBox(height: 10,),
                          Text(widget.merchantModel.profile.phone, style: const TextStyle( fontSize: 14, color: appTextSecondary),)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("Transaction Review", textAlign: TextAlign.center, style: TextStyle(color: appTextPrimary, fontSize: 18),),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: appTextSecondary),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Transaction Amount",style: TextStyle(fontSize: 16, color: appTextSecondary),),
                      const SizedBox(height: 10,),
                      Text( ' NGN ${widget.transactionInfo["amount"]}', style: TextStyle(color: appTextPrimary),),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: appTextSecondary),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Product Category", style: TextStyle(fontSize: 16, color: appTextSecondary),),
                      const SizedBox(height: 10,),
                      Text('${widget.transactionInfo["category"]}', style: TextStyle(color: appTextPrimary),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter Card Pin", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appTextPrimary
                    ),),
                    const SizedBox(height: 10,),
                    Container(
                      width: width * 0.5,
                      child: TextFormField(
                        obscureText: true,
                        controller: pinController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                          labelText: "Pin",
                          labelStyle: TextStyle(color: appTextPrimary, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: (){
                          _confirmTransaction(_chargeCardController);
                        },
                          style: ElevatedButton.styleFrom(
                              primary: appDeepBg,
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                              )
                          ),
                          child: Container(
                            //width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(20),
                            child: const Text("Pay Now", textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),),
                        ElevatedButton(onPressed: (){
                          Get.offAllNamed(RoutesClass.getHomeRoute());
                        },
                          style: ElevatedButton.styleFrom(
                              primary: appWhite,
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                              )
                          ),
                          child: Container(
                            // width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(20),
                            child: const Text("Cancel", textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: appTextPrimary
                            ),),
                          ),),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },)
    );
  }
  Future<void> _confirmTransaction(ChargeCardController chargeCardController) async {
    String inputPin = pinController.text.trim();
    ChargeCardResponseModel? chargeCardResponseModel;
    if(inputPin.isNotEmpty){
      int inputedPin = int.parse(pinController.text.trim());
      int userStoredPin = int.parse(widget.merchantModel.pin);
      print(' the user pin $userStoredPin');
      int checkPinMatch = chargeCardController.validateInputPin(inputedPin, userStoredPin);
      if(checkPinMatch!=0){
        showCustomSnackBar("Pin mismatch", title: "Incorrect Pin");
      }else{
        print(station_id);
        var modelInfoBase = widget.merchantModel;
        int deviceId = 14;
        int merchantId = modelInfoBase.merchantId;
        int vcardId = modelInfoBase.id;
        int amount = int.parse(widget.transactionInfo["amount"]!);
        String product = widget.transactionInfo["category"]!;
        String location = "AA Rano Gudu Abuja";
       ChargeCardPayloadModel cardPayloadModel = ChargeCardPayloadModel(
           deviceId: modelInfoBase.merchant.devices[0].id,
           merchantId: merchantId,
           vcardId: vcardId,
           amount: amount,
           station_id: station_id!,
           product: product,
           location: location
       );
       if(await chargeCardController.implementCardChargePayload(cardPayloadModel)){
         ChargeCardResponseModel cardResponseModel = chargeCardController.cardResponseModel;
         var dt = DateTime.now();
         var newDt = DateFormat.yMMMEd().format(dt);
         ReceiptModel receiptModel = ReceiptModel(transactionDate: newDt, transCategory: product, transactionAmount: amount.toString(), transactionType: "Card Transaction", transactionStatus: cardResponseModel.message);
         Get.offAndToNamed(RoutesClass.getScanSuccessPage(), arguments: ScanSuccessPage(receiptModel: receiptModel));
       }else{
         showCustomSnackBar("Error in getting network data", title: "Failed");
       }
      }
    }else{
      showCustomSnackBar("Pin field can't be empty", title: "Enter Pin");
    }
  }

  void getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    station_id = prefs.getInt('stationId');
    print("Station Id   "+station_id.toString());

  }
}
