import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/sign_in.dart';
import 'package:funfy_scanner/screens/home.dart';

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
        if (_token == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => SignIn()));
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
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                // Spacer(),
                // Image.asset(
                //   "images/LOGO.png",
                //   height: 80,
                //   width: 80,
                //   fit: BoxFit.cover,
                // ),\
              ],
            ),
          ),

          Positioned(
            bottom: 5.0,
            left: screenSize.width * 0.40,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/scanner.png",
                  height: 84.75,
                  width: 78,
                  fit: BoxFit.cover,
                ),
                // SizedBox(height: 10),
                // Text(
                //   "SCANNER",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w900,
                //     fontSize: 18,
                //   ),
                // ),
                SizedBox(height: screenSize.height * 0.05)
              ],
            ),
          )
        ],
      ),
    );
  }
}
