

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:terminal_app/pages/network_error.dart';
import 'package:terminal_app/routes/routes.dart';

class NetworkStatusService extends GetxService{
  NetworkStatusService(){
    InternetConnectionChecker().onStatusChange.listen((event) {
      _getNetworkStatus(event);
    });
  }

  void _getNetworkStatus(InternetConnectionStatus status){
    if(status == InternetConnectionStatus.connected){
      _validateSession();
    }else{
      Get.dialog(NetworkErrorPage(), useSafeArea: false);
    }
  }

  void _validateSession(){
    Get.offNamedUntil(RoutesClass.getInitialRoute(), (route) => false);
  }
}