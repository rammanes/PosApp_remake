
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../component/colors.dart';
import '../../controllers/transaction_controller.dart';
import '../../routes/routes.dart';


class TempTrans extends StatelessWidget {
  const TempTrans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<TransactionController>(builder: (_transactionController){
     // _getTransactions(_transactionController);
      return _transactionController.loading? Center(child: Container(
        child: SpinKitFadingFour(
          itemBuilder: (BuildContext context, int index){
            return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: index.isEven? Colors.red:Colors.green,
                ));
          },
        ),
      )):Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left:25, top: 50, right: 25),
        child: Column(
          children: [
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
            const SizedBox(height: 15,),
            Container(
              width: width,
              alignment: Alignment.center,
              child: const Text("Transactions", style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: appDeepBg
              ),),
            ),
            const SizedBox(height: 25,),
            const Divider( color: appTextSecondary,),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  height: 60,
                  padding: const EdgeInsets.only(top: 8),
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
                              Text( 'NGN transactionModel.amount', style: const TextStyle(fontSize: 16),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: appLightBg, size: 15,),
                              const SizedBox(width: 5,),
                              Text("Jahi Abuja", style: TextStyle(fontSize: 14),)
                            ],
                          )
                        ],
                      ),
                      Container(child: Text("Today at 23:02:20"),),
                      Container(child: Text("Successfully"),),
                    ],
                  ),
                );
              },
              itemCount: 5,
            )
          ],
        ),
      );
    });
  }
}
