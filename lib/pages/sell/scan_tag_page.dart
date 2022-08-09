import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/scan_controller.dart';
import 'package:terminal_app/models/merchant_model.dart';
import 'package:terminal_app/pages/sell/scan_confirmation_page.dart';
import 'package:terminal_app/widget/show_custom_dialog.dart';
import 'package:terminal_app/widget/show_custom_message.dart';
import '../../routes/routes.dart';


class ScanTagPage extends StatefulWidget {
  var category;
  var inputAmount;
  ScanTagPage( {Key? key, required this.category, required this.inputAmount}) : super(key: key);

  @override
  State<ScanTagPage> createState() => _ScanTagPageState();
}

class _ScanTagPageState extends State<ScanTagPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  Timer? _timer;
  String _nfcIdentifier = "";
  ScanController get scanController => Get.find<ScanController>();
  @override
  void initState(){
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async{
        await NfcManager.instance.isAvailable();
        _tagRead(scanController);
    });
    super.initState();
  }

  @override
  void dispose(){
    _timer!.cancel();
    NfcManager.instance.stopSession();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appWhite,
        body: GetBuilder<ScanController>(builder: (_scanDataController){
          return !_scanDataController.loading? Container(
            height: height,
            width: width,
            margin: const EdgeInsets.only(left: 25, top: 50, right: 25),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: (){
                        Get.offNamed(RoutesClass.getInputPricePage());
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 4,
                        color: appLightBg,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(Icons.arrow_back, size: 30, color: appWhite,)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: const Text(AppConstants.WAITING_FOR_CARD, style: TextStyle(color: appTextPrimary, fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: height * 0.45,
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/animation.gif'), fit: BoxFit.fill
                        )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: const Text(AppConstants.PLACE_CARD, style: TextStyle(color: appTextPrimary, fontSize: 16, fontWeight: FontWeight.w500),),
                  ),

                ],
              ),
            ),
          ):Center(child: Container(
            child: SpinKitFadingFour(
              itemBuilder: (BuildContext context, int index){
                return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index.isEven? Colors.red:Colors.green,
                    ));
              },
            ),
          ));
        })
    );
  }
  void _tagRead(ScanController scanController){
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async{
      result.value = tag.data;
      showSuccessSnackBar("${result.value}");
      NfcManager.instance.stopSession();
      print(result.value);
      bool isCardDetailsInDB = await scanController.getScanMetaDataFromDB(result.value);
      if(!isCardDetailsInDB){
        // showCustomSnackBar("Card not in database", title: "Not Found Error");
        showCustomDialog("card not in database", title: "Card Not Found");
      }else{
        MerchantModel merchantModel = scanController.merchantModel!;
        print(merchantModel.profile.name);
        Map<String, String> transactionInfo = {"category":widget.category, "amount":widget.inputAmount};
        //check the balance requirements
        scanController.checkBalance(scanController.userBalance, int.parse(widget.inputAmount))?
            //if balance requirements is met check the validity of the transaction
          scanController.isValidTransaction(scanController.userProductsCategory, widget.category)?
              //check if daily limit is exceeded
              !scanController.dailyLimitIsSatisfied(int.parse(widget.inputAmount), scanController.userDailyLimit)?
                  // Get.toNamed(RoutesClass.getScanConfirmationPage(),
                  //   arguments: ScanConfirmationPage(merchantModel: merchantModel, transactionInfo: transactionInfo))
                    Get.toNamed(RoutesClass.getScanConfirmationPage(),
                      arguments: ScanConfirmationPage(merchantModel: merchantModel, transactionInfo: transactionInfo)
                    )
              :showCustomSnackBar("Daily limit crushed", title: "Daily Limit Error")
          :showCustomSnackBar("Can't trade product category", title: "Product Category Error")
        :showCustomSnackBar("Insufficient Balance", title: "Balance Error");
      }
    });

  }
}
