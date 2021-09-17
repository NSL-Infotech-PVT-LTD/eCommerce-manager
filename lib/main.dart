import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/localization/Application.dart';
import 'package:funfy_scanner/screens/AboutUsScreen.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/ForgotPassword.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/sign_in.dart';
import 'package:funfy_scanner/screens/ChangeLanguageScreen.dart';
import 'package:funfy_scanner/screens/GlobalQRScanner.dart';
import 'package:funfy_scanner/screens/HelpScreen.dart';
import 'package:funfy_scanner/screens/TicketsList.dart';
import 'package:funfy_scanner/screens/home.dart';
import 'package:funfy_scanner/screens/pastTicketsList.dart';
import 'package:funfy_scanner/screens/profilePage.dart';
import 'package:funfy_scanner/screens/profileScreen.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';
import 'package:funfy_scanner/screens/splash_Screen.dart';
import 'package:funfy_scanner/screens/ticket_Screen.dart';
import 'package:funfy_scanner/screens/ticket_Screen1.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import 'localization/appTranslationDelegate.dart';

void main() async {


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate = AppTranslationsDelegate();

  bool _loading = true;

  @override
  void initState() {
    UserData.getUserLanguage("getUserLang").then((userLanguage) {
      print("vdvdfvv$userLanguage");

      _newLocaleDelegate =
          AppTranslationsDelegate(newlocale: Locale(userLanguage ?? "en"));

      application.onLocaleChanged = onLocaleChange;
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FunfY Club Admin',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.dark,
            ),
            localizationsDelegates: [
              _newLocaleDelegate,
              const AppTranslationsDelegate(),
              // _newLocaleDelegate as AppTranslationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: application.supportedLocales(),
            initialRoute: Routes.splashScreen,
            getPages: [
              GetPage(
                name: Routes.splashScreen,
                page: () => SplashScreen(),
                transition: Transition.native,
                transitionDuration: Duration(milliseconds: 2000),
                curve: Curves.bounceIn,
              ),
              GetPage(
                name: Routes.signInScreen,
                page: () => SignIn(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.homeScreen,
                page: () => Home(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.qrCodeScannerScreen,
                page: () => QRData(),
                transition: Transition.downToUp,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.globalScannerScreen,
                page: () => GlobalQrScanner(),
                transition: Transition.downToUp,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.ticketScreen,
                page: () => TicketScreen(),
                transition: Transition.downToUp,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.ticket1Screen,
                page: () => TicketScreen1(),
                transition: Transition.downToUp,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.forgotScreen,
                page: () => ForgotPassword(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.helpScreen,
                page: () => HelpScreen(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.contactUSScreen,
                page: () => AboutUsScreen(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.scannedticketScreen,
                page: () => TicketsList(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
              GetPage(
                name: Routes.languageScreen,
                page: () => ChangeLanguageScreen(),
                transition: Transition.rightToLeftWithFade,
                transitionDuration: Duration(milliseconds: 400),
              ),
            ],
          );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newlocale: locale);
    });
  }
}
