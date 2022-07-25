import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/user_controller.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("I am using the loading screen"+Get.find<UserController>().isLoading.toString());
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: appDeepBg
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: appWhite,
        ),
      ),
    );
  }
}
