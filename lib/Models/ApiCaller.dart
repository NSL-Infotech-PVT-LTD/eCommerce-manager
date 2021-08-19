import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/LoginModel.dart';
import 'package:funfy_scanner/Models/forgotPasswordModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  static final String baseUrl =
      "https://dev.netscapelabs.com/funfy/public/api/club-admin/";
  static final String baseurl =
      "https://dev.netscapelabs.com/funfy/public/api/";
  static final String login = "login";
  static final String forgotPassword = "reset-password";
  static final String signOut = "logout";

// Sign in User
  Future<LoginModel?> doLogin(
      {required String email,
      required BuildContext context,
      required String password,
      required String deviceType,
      required String deviceToken}) async {
    Map<String, String> data = {
      "email": "$email",
      "password": "$password",
      "device_type": "$deviceType",
      "device_token": "$deviceToken",
    };

    var response = await http.post(Uri.parse(baseUrl + login), body: data);
    print("${response.body}");
    // return LoginModel();
    if (response.statusCode == 200) {
      return LoginModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email or password !'),
            actions: <Widget>[
              // CupertinoDialogAction(
              //   child: Text('Don\'t Allow'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  //Forgot Password
  Future changeUserPassword(String email, BuildContext context, VoidCallback onPress) async {
    Map<String, dynamic> data = {
      "email": email,
    };
    final response = await http.post(
      Uri.parse(baseurl + forgotPassword),
      body: data,
    );
    if (response.statusCode == 201) {
      return ForgotPaswordModal.fromJson(jsonDecode(response.body));
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {

          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email !'),
            actions: <Widget>[
              // CupertinoDialogAction(
              //   child: Text('Don\'t Allow'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              CupertinoDialogAction(
                child: Text('Ok'),
                // onPressed: () {
                //   Navigator.of(context).pop();
                // },
                onPressed:onPress
              ),
            ],
          );
        },
      );
    }
    print(response.body);
  }

  //logout
  Future logout(String token) async {
    Map<String, String> data = {
      "device_token": "dsvfdjfldksjfdkls",
      "device_type": "android",
    };
    print("======> unable to logOut");
    final response = await http.post(
      Uri.parse(baseurl + signOut),
      headers: {
        // "Content-type": "application/json",
        'Authorization': "Bearer " + token,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      UserData.clearData();
    }
    print("===================?>${response.body}");
  }
}
