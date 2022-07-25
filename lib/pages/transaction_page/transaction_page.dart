import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:terminal_app/widget/show_custom_message.dart';

import '../../component/colors.dart';
import '../../controllers/transaction_controller.dart';
import '../../models/transaction_model.dart';
import '../../routes/routes.dart';
class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late bool isTransactionReturned;
  Future _refresh() async{
    setState((){

    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TransactionModel? transactionModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body:RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              height: 150,
              width: double.infinity,
              color: appGreyLight,
              child: Column(
                children: [
                  Container(
                    height: 50,
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
                  const SizedBox(height: 10,),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: const Text("Transactions", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: appDeepBg
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<TransactionController>(
                  builder: (_tc){
                    Get.find<TransactionController>().getTerminalTransaction();
                    return !_tc.loading?Center(child: Container(
                      child: SpinKitFadingFour(
                        itemBuilder: (BuildContext context, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: index.isEven? Colors.red:Colors.green,
                              ));
                        },
                      ),
                    )) :ListView.builder(
                        itemCount: _tc.transactionModel.length,
                        itemBuilder: (context, index){
                          var newDt = DateFormat.yMMMEd().format(_tc.transactionModel[index]!.updatedAt);
                          var time = DateFormat.jms().format(_tc.transactionModel[index]!.updatedAt);
                          return  Container(
                            height: 60,
                            margin: const EdgeInsets.only(top: 8, left: 25, right: 25),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: appTextSecondary),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text( 'NGN ${_tc.transactionModel[index]!.amount}', style: const TextStyle(fontSize: 16, color: Colors.green),),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 15,),
                                        const SizedBox(width: 5,),
                                        Text(_tc.transactionModel[index]!.location, style: TextStyle(fontSize: 14),)
                                      ],
                                    )
                                  ],
                                ),
                                Container(child: Column(
                                  children: [
                                    Text(newDt, style: const TextStyle(
                                        color: appTextPrimary
                                    ),),
                                    const SizedBox(height: 5,),
                                    Text(time, style: const TextStyle(
                                        color: appTextSecondary
                                    ),),
                                  ],
                                ),),
                                Container(child: Text('${_tc.transactionModel[index]!.product}', style: const TextStyle(
                                    color: appTextSecondary
                                ),),),
                              ],
                            ),
                          );
                        }
                    );
                  }
              ),
            ),
          ],
        ),
      )

    );
  }
  // _getTransactions(TransactionController transactionController)async {
  //   isTransactionReturned = await transactionController.getTerminalTransaction();
  //   if(isTransactionReturned){
  //     showSuccessSnackBar("Values returned", title: "Success");
  //   }else{
  //     showCustomSnackBar("values not returned", title:"Failed");
  //   }
  // }
}
