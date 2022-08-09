
import 'package:get/get.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/widget/show_custom_message.dart';


class ApiClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  late String token;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = AppConstants.BASE_URL;
    token = AppConstants.TOKEN;
    timeout = Duration(seconds: 20);
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future <Response> postData(String uri, dynamic body) async{
    print(body.toString());
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> getDailyTransactions(int merchantCode) async {
    String uriExtension = "/vcards/$merchantCode/dailytransactions";
    try{
      Response response = await get('$uriExtension');
      print('$uriExtension');
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  // get voucher user information using this method
  Future<Response> getVoucherUserInfo(String uriBase, String voucherCode) async {
    try{
      Response response = await get('$uriBase$voucherCode');
      print('$uriBase$voucherCode');
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // get voucher user information using this method
  Future<Response> sendVoucherPayloadInformation(String uriBase, String voucherCode, int deviceId, var voucherBody) async {
    String endString ="/charge";
    try{
      Response response = await post('$uriBase$voucherCode$endString', voucherBody, headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // get card user information using this method
  Future<Response> getCardUserInfo(String uriBase, String userTagCode) async {
    try{
      showCustomSnackBar('$uriBase$userTagCode');
      Response response = await get('$uriBase$userTagCode');
      print('$uriBase$userTagCode');
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // Send the chard payload using a post request
  Future<Response> sendCardChargePayload(String url, dynamic chargeCardModel) async {
    try{
      Response response = await post(url, chargeCardModel, headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> getTerminalTransaction(int merchantCode) async {

    String url = "/pos/merchants/$merchantCode/devices/14";
    try{
      Response response = await get(url, headers: _mainHeaders);
      print(url);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}