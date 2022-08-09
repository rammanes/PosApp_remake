import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:terminal_app/component/colors.dart';

void showCustomDialog(String message,
    {bool isError = true, String title = "Error"}) {
  Get.defaultDialog(
    title: title,
    titleStyle: const TextStyle(color: appTextSecondary, fontSize: 16,),
    middleText: message,
    middleTextStyle: const TextStyle(color: appTextPrimary),
    backgroundColor: appWhite,
    textCancel: "Cancel",
    cancelTextColor: appTextPrimary,
    onCancel: (){
      Get.back();
    },
    barrierDismissible: false
  );
}

