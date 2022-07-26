import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/controllers/app_controller.dart';
import 'package:terminal_app/controllers/user_controller.dart';
import 'package:terminal_app/routes/routes.dart';
import '../component/app_constant.dart';
import '../component/colors.dart';
import '../controllers/network_status_controller.dart';
import '../models/app_model.dart';
import 'sell/input_price_page.dart';
class TerminalHome extends StatefulWidget {
  const TerminalHome({Key? key}) : super(key: key);

  @override
  State<TerminalHome> createState() => _TerminalHomeState();
}

class _TerminalHomeState extends State<TerminalHome> {

  Future _refresh() async {
    setState((){

    });
  }
  int? station_id;

  @override
  void initState(){
    _refresh();
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<NetworkStatusService>();
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
       // backgroundColor: appWhite,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: height,
                width: width,
                color: appDeepBg,
                child: GetBuilder<DailyTransactionController>(builder: (_tx){
                  Get.find<DailyTransactionController>().getDailyTransactions();
                  return  Stack(
                    children: [
                      Positioned(
                          top: 50,
                          left: 0,
                          height: 100,
                          width: width,
                          child: Container(
                            width: width,
                            height: 80,
                            margin: const EdgeInsets.only(left:20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:Color(0xFFebf8fd),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Welcome",
                                        style: TextStyle(
                                            color: appTextDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                      SizedBox(height: 5,),

                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    width: 70,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:Color(0xFFf3fafc)
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          print("here");
                                          if(Get.find<UserController>().userLoggedIn()){
                                            Get.find<UserController>().clearSharedData();
                                            Get.toNamed(RoutesClass.getInitialRoute());
                                          }
                                        },
                                        child: const Icon(
                                          Icons.login_outlined,
                                          color: appDeepBg,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        top: 260,
                        left: 0,
                        width: width,
                        height: height,
                        child: Container(
                          width: 80,
                          height: 80,
                          color: appWhite,

                        ),
                      ),
                      Positioned(
                        top: 190,
                        left: 0,
                        width: width,
                        height: 130,
                        child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            width: width,
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: appWhite,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                      offset: Offset(0,10),
                                      color: appGreyLight
                                  ),
                                ]
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Transaction Details",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: appTextPrimary
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  const Divider(thickness: 1.0,),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      const Icon(Icons.security_outlined,
                                          color: appDeepBg),
                                      const SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Today's Sales",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:appTextPrimary,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text('NGN ${_tx.dailySales}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: appTextSecondary
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        children: [
                                          const Icon(Icons.calculate_outlined,
                                              color: appSuccessSecondary),
                                          const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text("Counts",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:appTextPrimary,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text( "${_tx.transactionCount}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: appTextSecondary
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )

                        ),
                      ),

                      Positioned(
                          top: 340,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(RoutesClass.getInputPricePage());
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 4,
                                  color: appDeepBg ,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: width * 0.3,
                                    alignment: Alignment.center,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.credit_card, color: appWhite, size: 40,),
                                        SizedBox(height: 5,),
                                        Text( "Sell", style: TextStyle(
                                            fontSize: 16,
                                            color: appWhite,
                                            fontWeight: FontWeight.w700
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(RoutesClass.getTransactionPage());
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 4,
                                  color: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: width * 0.3,
                                    alignment: Alignment.center,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.monetization_on_outlined, color: appWhite, size: 40,),
                                        SizedBox(height: 5,),
                                        Text( "Transactions", style: TextStyle(
                                            fontSize: 16,
                                            color: appWhite,
                                            fontWeight: FontWeight.w700
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(RoutesClass.getVoucherCodePage());
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 4,
                                  color: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: width * 0.3,
                                    alignment: Alignment.center,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.qr_code, color: appWhite, size: 40,),
                                        SizedBox(height: 5,),
                                        Text("Voucher", style:  TextStyle(
                                            fontSize: 16,
                                            color: appWhite,
                                            fontWeight: FontWeight.w700
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  );
                })

            ),
          ],
        ),
        ),
    );
  }
  void getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    station_id = prefs.getInt('stationId');
    print("Station Id   "+station_id.toString());

  }
}
