import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/ForgotPassword.dart';
import 'package:funfy_scanner/screens/home.dart';
import 'package:funfy_scanner/screens/languageScreen.dart';
import 'package:get/get.dart';

import '../ticket_Screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool hidden = true;
  bool _isLoading = false;

  gethidden() {
    setState(() {
      hidden = !hidden;
    });
  }

  getInitialState() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //bg Image
            Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/BG_2.png"),
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

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.05),

                //LOGO
                Container(
                  height: 116.21,
                  width: 87.99,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/LOGO.png"),
                  )),
                ),

                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTranslation.of(context)!.text("signIn"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF5F5F5),
                          fontSize: 30,
                          fontFamily: "AbrilFatface",
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            AppTranslation.of(context)!.text("welcome"),
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 18,
                              fontFamily: FontsDisPlay.robotoThin,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            AppTranslation.of(context)!.text("funfy party app"),
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 18,
                              fontFamily: FontsDisPlay.robotoBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                //Email TextField
                Container(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        //Email
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 33),
                              child: Text(
                                AppTranslation.of(context)!.text("email"),
                                style: TextStyle(
                                  color: Color(0xffDBDBDB),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width,
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => (value!.isEmpty)
                                    ? "Please enter a valid email !"
                                    : null,
                                style: TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontFamily: FontsDisPlay.dmSantsMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.020,
                                  ),
                                  fillColor: Color(0xff434343),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                cursorColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        //Password
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 33),
                              child: Text(
                                AppTranslation.of(context)!.text("password"),
                                style: TextStyle(
                                  color: Color(0xffDBDBDB),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              //width: MediaQuery.of(context).size.width,
                              //alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: hidden,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) => (value!.length < 6 ||
                                        value.isEmpty)
                                    ? "Please enter a 6+ characters password !"
                                    : null,
                                style: TextStyle(
                                  color: Color(0xffC5C5C5),
                                  fontFamily: FontsDisPlay.dmSantsMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.020,
                                  ),
                                  fillColor: Color(0xff434343),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffix: hidden
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              hidden = !hidden;
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/images/EYE_CLOSE.png",
                                            width: 25,
                                            height: 23.92,
                                          ))
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              hidden = !hidden;
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/images/EYE_OPEN.png",
                                            width: 25,
                                            height: 23.92,
                                          )),
                                ),
                                cursorColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //Sign In
                        _isLoading
                            ? CircularProgressIndicator(
                                color: Color(0xffFF5349),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    ApiCaller()
                                        .doLogin(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      deviceType: Platform.isAndroid
                                          ? "android"
                                          : "ios",
                                      deviceToken: "dsfdsfdsf",
                                      setInitialState: getInitialState,
                                    )
                                        .then(
                                      (userCredential) async {
                                        if (userCredential != null) {
                                          print(
                                              "account id  ${userCredential.data?.user?.stripeAccountId}");
                                          await UserData.setUserToken(
                                            key: "USERTOKEN",
                                            value: userCredential.data?.token ??
                                                "",
                                          );
                                          var value = userCredential.data?.user
                                                      ?.stripeAccountId !=
                                                  null
                                              ? "1"
                                              : "0";
                                          await UserData.setUserLanguage(
                                            key: "connected",
                                            value: value,
                                          );
                                          Get.offNamed(Routes.homeScreen);
                                        }
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFF5349),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffFF5349),
                                      )),
                                  child: Text(
                                    AppTranslation.of(context)!.text("signIn"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: FontsDisPlay.dmSantsMedium,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 40),
                        //Forgot Password
                        GestureDetector(
                          onTap: () {
                            print(
                              UserData.getUserToken("USERTOKEN"),
                            );

                            Get.toNamed(Routes.forgotScreen);
                          },
                          child: Text(
                            AppTranslation.of(context)!.text("forgotPassword"),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontsDisPlay.dmSantsMedium,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                    //Password TextField
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
