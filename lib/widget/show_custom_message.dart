import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/routes/routes.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: const TextStyle(color: appWhite, fontSize: 16,),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: appWhite),
      ),
      colorText: appWhite,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: appRedColor,
      icon: const Icon(Icons.close, color: appWhite, size: 25,),
     );
}

void showSuccessSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: const TextStyle(color: appWhite),
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: appWhite),
    ),
    colorText: appWhite,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: appLightBg,
  );
}
