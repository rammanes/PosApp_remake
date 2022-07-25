import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/charge_controller.dart';
import 'package:terminal_app/controllers/voucher_controller.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/show_custom_message.dart';
import '../../models/charge_card_model.dart';
import '../../models/voucher_code_model.dart';
import '../sell/scan_successful_print.dart';

class VoucherConfirmationPage extends StatefulWidget {
  final VoucherCodeModel voucherCodeModel;
  VoucherConfirmationPage({Key? key, required this.voucherCodeModel}) : super(key: key);

  @override
  State<VoucherConfirmationPage> createState() => _VoucherConfirmationPageState();
}

class _VoucherConfirmationPageState extends State<VoucherConfirmationPage> {
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: appWhite,
        body: GetBuilder<VoucherController>(builder: (_voucherController){
          return _voucherController.loading?
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
                            Text( widget.voucherCodeModel.profile.name, style: const TextStyle( fontSize: 16, color: appTextPrimary),),
                            const SizedBox(height: 10,),
                            Text(widget.voucherCodeModel.profile.phone, style: const TextStyle( fontSize: 14, color: appTextSecondary),)
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
                        Text( ' NGN ${widget.voucherCodeModel.amount}', style: TextStyle(color: appTextPrimary),),
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
                        Text('${widget.voucherCodeModel.product}', style: TextStyle(color: appTextPrimary),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: (){
                            _initiateTransaction(_voucherController);
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

  _initiateTransaction(VoucherController _vController){
    if(widget.voucherCodeModel.profile.balance >= int.parse(widget.voucherCodeModel.amount)){
      _confirmTransaction(_vController);
    }else{
      showCustomSnackBar("Account Balance Insufficient for this Transaction", title: "Insufficient Balance");
    }
  }
  Future<void> _confirmTransaction(VoucherController _voucherController) async {
    if(await _voucherController.sendVoucherPayloadInformation(widget.voucherCodeModel.pin)){
      print(_voucherController.voucherPayloadModel!.amount);
      var todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      ReceiptModel _receiptModel = ReceiptModel(transactionDate: todayDate,
          transCategory: widget.voucherCodeModel.product,
          transactionAmount: widget.voucherCodeModel.amount,
          transactionType: "Voucher Transaction",
          transactionStatus: "Successful");
      Get.offAndToNamed(RoutesClass.getScanSuccessPage(), arguments: ScanSuccessPage(receiptModel: _receiptModel));
    }else{
      showCustomSnackBar("Network error", title:"Network Error");
    }
  }
}
