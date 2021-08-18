import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/ForgotPassword.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/sign_in.dart';
import 'package:funfy_scanner/screens/home.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';
import 'package:funfy_scanner/screens/splash_Screen.dart';
import 'package:funfy_scanner/screens/ticket_Screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FunFY',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

initialRoute: Routes.splashScreen,

      getPages: [
        GetPage(
          name: Routes.splashScreen,
          page: () => SplashScreen(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: Routes.signInScreen,
          page: () => SignIn(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: Routes.homeScreen,
          page: () => Home(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: Routes.qrCodeScannerScreen,
          page: () => QRData(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: Routes.ticketScreen,
          page: () => QRData(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
