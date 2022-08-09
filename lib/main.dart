import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terminal_app/pages/home_page.dart';
import 'package:terminal_app/routes/routes.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(TerminalApp());
}

class TerminalApp extends StatelessWidget {
  const TerminalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // home: TerminalHome(),
    initialRoute: RoutesClass.getSplashPage(),
    getPages: RoutesClass.routes,
  );

}
