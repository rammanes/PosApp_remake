import 'package:flutter/material.dart';
import 'package:terminal_app/component/colors.dart';

class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: appWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.network_check_outlined, size: 100,),
            SizedBox(height: 30,),
            Text('Internet connection lost!', style: TextStyle(color: appTextPrimary, fontSize: 18),),
            SizedBox(height: 5,),
            Text('Check your connection and try again', style: TextStyle(color: appTextPrimary, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
