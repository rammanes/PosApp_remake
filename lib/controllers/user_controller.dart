import 'package:get/get.dart';
import 'package:terminal_app/data/repository/user_repo.dart';
import 'package:terminal_app/models/login_model.dart';
import 'package:terminal_app/models/login_response.dart';


class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isSuccess = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;


  Future<void>performLogin(LoginModel loginModel) async{
    _isLoading = true;
    _isSuccess = false;
    update();
    Response response = await userRepo.performLogin(loginModel);
    LoginResponse? loginResponse;
    if(response.statusCode == 200){
      _isSuccess = true;
      userRepo.saveUserToken(response.body["token"]);
      loginResponse = LoginResponse.fromJson(response.body);
      String userToken = loginResponse.token;
      int userId = loginResponse.data.userId;
      int stationId = loginResponse.data.stationId;
      int merchantId = loginResponse.data.merchantId;
      userRepo.saveDetails(userToken, userId, stationId, merchantId);
      print(loginResponse.data.fullName);
    }else{
     _isSuccess= false;
    }
    _isLoading = false;
    update();

  }
  void saveDetails(String token, int userId, int stationId, int merchantID){
    userRepo.saveDetails(token, userId, stationId, merchantID);
  }
  bool userLoggedIn() {
   return userRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return userRepo.clearSharedData();
  }

}