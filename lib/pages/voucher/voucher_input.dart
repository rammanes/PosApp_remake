import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/app_controller.dart';
import 'package:terminal_app/controllers/voucher_controller.dart';
import 'package:terminal_app/models/voucher_code_model.dart';
import 'package:terminal_app/pages/voucher/voucher_confirmation.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/show_custom_message.dart';


class VoucherInputScreen extends StatefulWidget {
  const VoucherInputScreen({Key? key}) : super(key: key);

  @override
  State<VoucherInputScreen> createState() => _VoucherInputScreenState();
}

class _VoucherInputScreenState extends State<VoucherInputScreen> {
  final _formKey = GlobalKey<FormState>();
  var _codeController = TextEditingController();
  var dt = DateTime.now();
  DateFormat _dateFormat = DateFormat('yyyy-mm-dd');
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appWhite,
      body: GetBuilder<VoucherController>(builder: (_voucherController){
        return _voucherController.loading? Center(child: Container(
          child: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index){
              return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index.isEven? Colors.red:Colors.green,
                  ));
            },
          ),
        )):SingleChildScrollView(
          child: Container(
            height: height,
            margin: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                Container(
                  height: 60,
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.offAllNamed(RoutesClass.getHomeRoute());
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
                const SizedBox(height: 25,),
                const Text("Enter Voucher Code", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: appTextPrimary
                ),),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                  decoration: const  InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                    labelText: "Code",
                    labelStyle: TextStyle(color: appTextSecondary, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 25,),
                ElevatedButton(onPressed: (){
                  _verifyVoucher(_voucherController);
                },
                  style: ElevatedButton.styleFrom(
                      primary: appDeepBg,
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    child: const Text("Next", textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),),
              ],
            ),
          ),
        );
      },)
    );

  }
  _verifyVoucher(VoucherController _voucherController) async {
    String voucherCode = _codeController.text.trim();
    if(voucherCode.isEmpty){
      showCustomSnackBar("Code Field Can't be Empty", title: "Code Field Error");
    }else{
      bool voucherInputSuccess = await _voucherController.getVoucherUserInfo(voucherCode);
      if(voucherInputSuccess){
          VoucherCodeModel _voucherCodeModel = _voucherController.voucherCodeModel!;
          DateTime _codeExpirationDate = DateTime.parse(_voucherCodeModel.expirationDate);
          print(dt);
          print(_codeExpirationDate);
          //check is the code has been used
          if(_voucherCodeModel.status.compareTo("1")==0){
            showCustomSnackBar("Code has already been used", title: "Used Code");
          }else if(dt.isBefore(_codeExpirationDate)){
            Get.offAndToNamed(RoutesClass.getVoucherConfirmationPage(), arguments: VoucherConfirmationPage(voucherCodeModel: _voucherCodeModel));
          }else{
            showCustomSnackBar("Sorry! voucher has expired", title: "Expired");
          }
      }else{
        showCustomSnackBar("An error has occurred while making network call", title: "Network Error");
      }
    }
  }
}
