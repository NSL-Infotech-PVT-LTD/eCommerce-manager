import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Models/LoginModel.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  static final String baseUrl =
      "https://dev.netscapelabs.com/funfy/public/api/club-admin/";
  static final String login = "login";
  static final String forgotPassword = "change-password";

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
  changeUserPassword({required String email}) async {
    Map<String, dynamic> data = {
      "email": email,
    };
    http.post(
      Uri.parse(baseUrl + forgotPassword),
      body: data,
    );
  }
}
