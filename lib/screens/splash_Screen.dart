import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      UserData.getUserToken("USERTOKEN").then((_token) {
        print("$_token jdfkjskfj");
        if (_token == null) {
          Get.offNamed(Routes.signInScreen);
        } else {
          Get.offNamed(Routes.homeScreen);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //bg Image
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/BG_1.png"),
            )),
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.black87,
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.white12,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/LOGO.png",
                  height: 204.69,
                  width: 154.99,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 5.0,
            left: screenSize.width * 0.40,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/qrcodescan.svg",
                    height: 54.09,
                    width: 54.09,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    "SCANNER",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      fontFamily: FontsDisPlay.gretarosRegular,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
