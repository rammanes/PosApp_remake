import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal_app/component/app_constant.dart';
import 'package:terminal_app/data/api/api_client.dart';
import 'package:terminal_app/models/login_model.dart';

class UserRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> performLogin(LoginModel loginModel) async {
    Response response = await apiClient.postData(AppConstants.LOGIN_URI, loginModelToJson(loginModel));
    return response;
  }
  //get saved token here


  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.USER_ID);
  }


  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveDetails(String token, int userId, int stationId, int merchantID)
  async {
    try{
      await sharedPreferences.setString(AppConstants.TOKEN, token);
      await sharedPreferences.setInt(AppConstants.USER_ID, userId);
      await sharedPreferences.setInt(AppConstants.MERCHANT_ID, merchantID);
      await sharedPreferences.setInt(AppConstants.STATION_ID, stationId);
      //await sharedPreferences.setString(AppConstants.TOKEN, token);
    }catch(e){
      throw e;
    }

  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER_ID);
    sharedPreferences.remove(AppConstants.MERCHANT_ID);
    sharedPreferences.remove(AppConstants.STATION_ID);
    apiClient.token="";
    apiClient.updateHeader("");
    return true;
  }

}