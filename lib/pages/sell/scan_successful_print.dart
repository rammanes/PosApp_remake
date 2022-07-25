import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/models/charge_card_model.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/show_custom_message.dart';


class ScanSuccessPage extends StatefulWidget {
  final ReceiptModel receiptModel;
  const ScanSuccessPage({Key? key, required this.receiptModel}) : super(key: key);

  @override
  State<ScanSuccessPage> createState() => _ScanSuccessPageState();
}

class _ScanSuccessPageState extends State<ScanSuccessPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appWhite,
      body: Container(
        height: height,
        width: width,
        //padding: const EdgeInsets.only(left: 25, top: 50, right: 25),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: appDeepBg,
              padding: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.bottomCenter,
              child: const Text('Successful', style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: appWhite
              ),),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: const [
                  Icon(Icons.check_circle_outlined, color: Colors.green, size: 50,),
                  SizedBox(height: 10,),
                  Text("Transaction Successfully", style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                  ),)
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: const Divider(
                color: appTextSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text("Date", style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),),
                        Text(widget.receiptModel.transactionDate),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Category", style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),),
                        Text("PMS"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Transaction Type", style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),),
                        Text(widget.receiptModel.transactionType),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status", style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),),
                        Text(widget.receiptModel.transactionStatus),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 40,
                    color: appGreyLight,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Amount", style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
                        Text(widget.receiptModel.transactionAmount),
                      ],
                    ),
                  ),

                ],
              )
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: const Divider(
                color: appTextSecondary,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  child: ElevatedButton(onPressed: (){
                   showSuccessSnackBar("Transaction Successful", title: "Successful");
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
                      padding: const EdgeInsets.all(20),
                      child: const Text("Print", textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: appTextPrimary
                      ),),
                    ),),
                ),
                const SizedBox(width: 20,),
                Container(
                  width: 120,
                  child: ElevatedButton(onPressed: (){
                    showCustomSnackBar("Transaction cancelled", title: "Cancelled");
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
                      padding: const EdgeInsets.all(20),
                      child: const Text("Close", textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: appTextPrimary
                      ),),
                    ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
