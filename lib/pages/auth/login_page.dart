


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:terminal_app/controllers/user_controller.dart';
import 'package:terminal_app/data/repository/user_repo.dart';
import 'package:terminal_app/models/login_model.dart';
import 'package:terminal_app/pages/home_page.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/custom_loader.dart';
import 'package:terminal_app/widget/show_custom_message.dart';

import '../../component/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: GetBuilder<UserController>(builder: (_userController){
        return !_userController.isLoading?SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login", style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: appTextPrimary
                ),),
                const SizedBox(height: 10,),
                const Text("Securely login to Terminal App", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: appTextSecondary
                ),),
                const SizedBox(height: 50,),
                const Text("Your Username", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: appTextPrimary
                ),),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: usernameController,
                  decoration: const  InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                    labelText: "Username",
                    labelStyle: TextStyle(color: appTextSecondary, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 25,),
                const Text("Your Password", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: appTextPrimary
                ),),
                const SizedBox(height: 10,),
                TextFormField(
                  obscureText: _obscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: appTextPrimary, fontSize: 14),
                      suffixIcon: InkWell(
                        onTap: _toggle,
                        child: Icon(_obscureText?Icons.visibility_off: Icons.visibility)
                      )
                  ),
                ),
                const SizedBox(height: 35,),
                ElevatedButton(onPressed: (){
                  _login(_userController);
                  //Get.toNamed(RoutesClass.getHomeRoute());
                },
                  style: ElevatedButton.styleFrom(
                      primary: appDeepBg,
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    child: const Text("LOG IN", textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),),
                const SizedBox(height: 30,),

              ],
            ),
          ),
        ):Center(child: Container(
          child: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index){
              return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index.isEven? Colors.red:Colors.green,
                  ));
            },
          ),
        ));
      },)
    );

  }
  Future<void> _login(UserController userController) async {
   // var userController  = Get.find<UserController>();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    if(username.isEmpty){
      showCustomSnackBar("Enter a valid username", title: "username");
    }else if(password.isEmpty){
      showCustomSnackBar("Enter a valid password", title: "password");
    }else{
      LoginModel loginModel = LoginModel(username: username, password: password);
      await userController.performLogin(loginModel);
      if(userController.isSuccess){
        showSuccessSnackBar("All went well", title: "Perfect");
        Get.offAndToNamed(RoutesClass.getHomeRoute());
      }else{
        showCustomSnackBar("Login Failed", title: "Failed");
      }
    }
  }
}