import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ClubListModal.dart';
import 'package:funfy_scanner/Models/GetAboutUsModal.dart';
import 'package:funfy_scanner/Models/GetHelpModal.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';
import 'package:funfy_scanner/Models/GetStripeDataModal.dart';
import 'package:funfy_scanner/Models/LoginModel.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/Models/forgotPasswordModel.dart';
import 'package:funfy_scanner/Models/getScannedDataModal.dart';
import 'package:funfy_scanner/screens/Auth%20Screens/sign_in.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  static final String baseUrl =
      "https://dev.netscapelabs.com/funfy/public/api/club-admin/";
  static final String baseurl =
      "https://dev.netscapelabs.com/funfy/public/api/";
  static final String login = "login";
  static final String forgotPassword = "reset-password";
  static final String signOut = "logout";
  static final String getById = "booking/detailById";
  static final String getUSer = "get-profile";
  static final String getBookinglist = "booking/list";
  static final String getclublist = "club/list";
  static final String getStripe = "payment-config";
  static final String connectStripe = "update/account";
  static final String aboutUs = "config/about_us";
  static final String scanID = "scan/booking";
  static final String MyScan = "scanned/bookinglist";

  static final String help = "config/help_and_contact_us";

// Sign in User
  Future<LoginModel?> doLogin({
    required String email,
    required BuildContext context,
    required String password,
    required String deviceType,
    required String deviceToken,
    required VoidCallback setInitialState,
  }) async {
    Map<String, String> data = {
      "email": "$email",
      "password": "$password",
      "device_type": "$deviceType",
      "device_token": "$deviceToken",
    };

    var response = await http.post(Uri.parse(baseUrl + login), body: data);
    print(" User Login===>>>>>${response.body}");
    // return LoginModel();
    if (response.statusCode == 200) {
      return LoginModel.fromJson(
        jsonDecode(response.body),
      );
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    setInitialState();
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
    }
  }

// Get User Profile
  Future getUserProfile(String userToken, BuildContext context) async {
    final response = await http.post(Uri.parse(baseurl + getUSer), headers: {
      "Authorization": "Bearer " + userToken,
    });
    print("dbfdbs${response.body}");

    if (response.statusCode == 200) {
      return GetUserProfileModal.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Please check your connection!'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
    }
  }

//Forgot Password
  Future changeUserPassword(
      String email, BuildContext context, VoidCallback onPress) async {
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
              CupertinoDialogAction(child: Text('Ok'), onPressed: onPress),
            ],
          );
        },
      );
    }
    print(response.body);
  }

//logout
  Future logout(String token, BuildContext context) async {
    Map<String, String> data = {
      "device_token": "dsvfdjfldksjfdkls",
      "device_type": "android",
    };
    print("======> unable to logOut");
    final response = await http.post(
      Uri.parse(baseurl + signOut),
      headers: {
        'Authorization': "Bearer " + token,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      UserData.clearData();
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    }
    print("===================?>${response.body}");
  }

// get Booking List
  Future getBookingList(String userToken, String clubID, String ordering,
      BuildContext context) async {
    Map<String, dynamic> data = {
      "club_id": clubID,
      "sort_by": ordering,
    };
    final response = await http.post(
      Uri.parse(baseUrl + getBookinglist),
      body: data,
      headers: {
        // "Content-type": "application/json",
        'Authorization': "Bearer " + userToken,
      },
    );
    if (response.statusCode == 200) {
      print("BookingLIstModal===============>=${response.body}");
      return BookingListModal.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    }
  }

  //Get Club List
  Future getClubList(
    String userToken,
    BuildContext context,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl + getclublist),
      headers: {
        "Authorization": "Bearer " + userToken,
      },
    );
    if (response.statusCode == 200) {
      return ClubListModal.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
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

  //Get Scanned Data
  Future getScannedData(String id, String userToken, String? clubId) async {
    // print("Clubid==>$clubId");
    Map<String, dynamic> data = clubId == null || clubId == "null"
        ? {
            "booking_id": id,
          }
        : {
            "booking_id": id,
            "club_id": clubId,
          };

    // print("Data==> $data");
    final response = await http.post(Uri.parse(baseUrl + getById),
        headers: {
          "Authorization": "Bearer " + userToken,
        },
        body: data);
    print(jsonEncode(response.body));

    if (response.statusCode == 200) {
      return GetScanData.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //add Scanned Id
  Future addScannedid(String userToken, String bookingID) async {
    Map<String, dynamic> data = {
      "booking_id": bookingID,
    };
    final response = await http.post(
      Uri.parse(baseUrl + scanID),
      body: data,
      headers: {
        "Authorization": "Bearer " + userToken,
      },
    );
    print("Add Booking id ====>>>>${response.body}");
  }

//get Scanned History
  Future getScannedHistory(String userToken, BuildContext context) async {
    final response = await http.post(
      Uri.parse(baseUrl + MyScan),
      headers: {
        "Authorization": "Bearer " + userToken,
      },
    );

    if (response.statusCode == 200) {
      print("Get Scanned History Data${response.body}");
      return GetScannedHistoryModal.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    } else {
      print("Getscanned Not Found");
    }
  }

  //for Stripe
  Future getStripeData(String userToken) async {
    final response = await http.get(
      Uri.parse(baseurl + getStripe),
      headers: {
        "Authorization": "Bearer " + userToken,
      },
    );
    if (response.statusCode == 200) {
      return GetStripeDataModal.fromJson(json.decode(response.body));
    } else {
      return print("errro in Stripe");
    }
  }

  Future connectStripAccount(
      String userToken, accountId, BuildContext context) async {
    Map<String, dynamic> data = {
      "account_id": accountId.toString(),
    };
    final response = await http.post(Uri.parse(baseUrl + connectStripe),
        headers: {
          "Authorization": "Bearer " + userToken,
        },
        body: data);
    print("Coonect URL ===> ${baseUrl + connectStripe}");
    print("Coonect URL ===> ${baseUrl + connectStripe}");
    print("Coonect Body ===> $data");
    print("response ===> ${response.body}");
    if (response.statusCode == 201) {
      return GetStripeDataModal.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    } else {
      return print("errro in Stripe");
    }
  }

//  for Contact Us
  Future getAboutUS(BuildContext context) async {
    {
      final response = await http.get(Uri.parse(baseurl + aboutUs));

      if (response.statusCode == 200) {
        return GetAboutUsModal.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Login Error'),
              content: Text('Please enter the valid email and password !'),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text('Ok'),
                    onPressed: () {
                      Future.delayed(Duration(seconds: 1), () {
                        UserData.clearData();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                            (route) => false);
                      });
                    }),
              ],
            );
          },
        );
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
  }

  // for Help
  Future getHelpData(BuildContext context) async {
    final response = await http.get(Uri.parse(baseurl + help));

    if (response.statusCode == 200) {
      return GetHelpModal.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Login Error'),
            content: Text('Please enter the valid email and password !'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('Ok'),
                  onPressed: () {
                    Future.delayed(Duration(seconds: 1), () {
                      UserData.clearData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    });
                  }),
            ],
          );
        },
      );
    }
  }
}
