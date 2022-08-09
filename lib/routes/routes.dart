

import 'dart:convert';

import 'package:get/get.dart';
import 'package:terminal_app/pages/home/landing_screen.dart';
import 'package:terminal_app/pages/home_page.dart';
import 'package:terminal_app/pages/auth/login_page.dart';
import 'package:terminal_app/pages/sell/input_price_page.dart';
import 'package:terminal_app/pages/sell/scan_successful_print.dart';
import 'package:terminal_app/pages/transaction_page/transaction_page.dart';
import 'package:terminal_app/pages/voucher/voucher_confirmation.dart';

import '../pages/sell/scan_confirmation_page.dart';
import '../pages/sell/scan_tag_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/voucher/voucher_input.dart';

class RoutesClass{
  static const String start = "/";
  static const  String home = "/home";
  static const String splashPage = "/splash-page";
  static const String inputPricePage ="/input-price";
  static const String scanTagPage = "/scan-tag";
  static const String scanConfirmationPage = "/scan-confirmation";
  static const String scanSuccessReceipts = "/scan-success-response";
  static const String voucherCodeScreen = "/voucher-input-screen";
  static const String voucherConfirmationPage ="/voucher-confirmation";
  static const String transactionPage = "/transaction-page";
  static const String landingpage = "/landing-page";

  static String getSplashPage()=>'$splashPage';
  static String getInitialRoute()=> '$start';
  static String getLandingPage()=> '$landingpage';
  static String getHomeRoute()=> '$home';
  static String getInputPricePage ()=> '$inputPricePage';
  static String getScanPage (String category, String inputAmount)=> '$scanTagPage?category=$category&inputAmount=$inputAmount';
  static String getScanConfirmationPage()=> '$scanConfirmationPage';
  static String getScanSuccessPage()=>'$scanSuccessReceipts';
  static String getVoucherCodePage()=>'$voucherCodeScreen';
  static String getVoucherConfirmationPage()=> '$voucherConfirmationPage';
  static String getTransactionPage()=>'$transactionPage';

  static List<GetPage> routes =[
    GetPage(name: landingpage, page: ()=> const LandingScreen()),
    GetPage(name: splashPage, page: ()=>const SplashScreen()),
    GetPage(name: start, page: ()=>const LoginScreen()),
    GetPage(name: home, page: ()=>const TerminalHome(), transition: Transition.fade, transitionDuration: const Duration(seconds: 1)),
    GetPage(name: inputPricePage, page: ()=> const InputPriceScreen(), transition: Transition.fade, transitionDuration: const Duration(seconds: 1)),
    GetPage(name: scanTagPage, page: (){
        var category = Get.parameters['category'];
        var inputAmount = Get.parameters['inputAmount'];
        return ScanTagPage(category: category, inputAmount: inputAmount);
    }, transition: Transition.fadeIn, transitionDuration: const Duration(seconds: 1)),
    GetPage(name: scanConfirmationPage, page: () {
      ScanConfirmationPage _scanConfirmationPage = Get.arguments;
      return _scanConfirmationPage;
    }),
    GetPage(name: scanSuccessReceipts, page: () {
      ScanSuccessPage _scanSuccessPage = Get.arguments;
      return _scanSuccessPage;
    }, transition: Transition.fade, transitionDuration: const Duration(seconds: 1)),
    GetPage(name: voucherCodeScreen, page: ()=>const VoucherInputScreen(), transition: Transition.fade, transitionDuration: const Duration(seconds: 1)),
    GetPage(name: voucherConfirmationPage, page: (){
      VoucherConfirmationPage _voucherConfirmationPage = Get.arguments;
      return _voucherConfirmationPage;
    }),
    GetPage(name: transactionPage, page: ()=> const TransactionPage())
  ];
}