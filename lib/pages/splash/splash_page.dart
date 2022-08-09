import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/user_controller.dart';
import 'package:terminal_app/routes/routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController animationController;
  late UserController controller;

  _loadResources() async => null;

  @override
  void initState(){
    super.initState();
    _loadResources();
    animationController =  AnimationController(vsync: this,
      duration: const Duration(seconds: 2)
    )..forward();
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () {
      if(Get.find<UserController>().userLoggedIn()){
        Get.offNamed(RoutesClass.getHomeRoute());
      }else{
        Get.offNamed(RoutesClass.getInitialRoute());
      }

    });
  }
  @override
  dispose(){
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDeepBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animationController,
              child: Center(child: SpinKitDancingSquare(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index.isEven ? Colors.white : Colors.deepOrange,
                    ),
                  );
                },
              ))),
          const SizedBox(height: 25,),
          const Text("Powered by Wavu", style: TextStyle(
            fontSize: 22,
            color: appWhite
          ),)
        ],
      ),
    );
  }
}

