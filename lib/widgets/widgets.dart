import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/roundContainer.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Constants/strings.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/AboutUsScreen.dart';
import 'package:funfy_scanner/screens/ChangeLanguageScreen.dart';
import 'package:funfy_scanner/screens/HelpScreen.dart';
import 'package:funfy_scanner/screens/stripe_connect.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//for textField
buildCustomTextField(
  TextEditingController _emailController,
  String fieldType,
  String icon1,
  String icon2,
  bool istrue,
  VoidCallback _toogle,
  BuildContext context,
  var type,
  String validate,
  GlobalKey<FormState> formkey,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            fieldType,
            style: TextStyle(
              color: Color(0xffDBDBDB),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: formkey,
            child: TextFormField(
              controller: _emailController,
              obscureText: istrue,
              keyboardType: type,
              validator: (value) =>
                  (value!.length < 6 || value.isEmpty) ? validate : null,
              style: TextStyle(
                color: Color(0xffC5C5C5),
                fontFamily: FontsDisPlay.dmSantsMedium,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                fillColor: Color(0xff434343),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff707070))),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffix: (icon1 == "" || icon2 == "")
                    ? Container(
                        width: 30,
                        height: 30,
                      )
                    : GestureDetector(
                        onTap: _toogle,
                        child: Image.asset(
                          istrue ? icon1 : icon2,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              cursorColor: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

//for Ticket
buildTicketTile(String type, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        type,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          fontFamily: FontsDisPlay.dmSantsBold,
          color: Color(0xff3E332B),
        ),
      ),
      SizedBox(height: 3),
      Text(
        value,
        style: TextStyle(
          fontFamily: FontsDisPlay.dmSantsMedium,
          fontSize: 15,
          color: Color(0xff8A8A8A),
        ),
      ),
    ],
  );
}

//PastTicketsListTile
buildPastTicketsListTile(Size screenSize, String name, String date, String time,
    getData, String getScan) {
  return Column(
    children: [
      SizedBox(height: screenSize.height * 0.040),
      Container(
        height: screenSize.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 18),
              width: screenSize.width * 0.10,
              height: screenSize.height * 0.10,
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/images/Tick.svg"),
            ),
            SizedBox(width: screenSize.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.010),
                  Text(
                    "order Delivered on $date\,",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.010),
                  Text(
                    " $time",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenSize.width * 0.0010),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.qrCodeScannerScreen,
                        arguments: getScan,
                      );
                    },
                    child: Image.asset(
                      "assets/images/qrcodescan.png",
                      height: screenSize.width * 0.090,
                      width: screenSize.height * 0.090,
                      color: Colors.red,
                    ),
                  ),
                  // SizedBox(height: screenSize.height * 0.010),
                  // OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     backgroundColor: Colors.black87,
                  //     side: BorderSide(
                  //       color: Colors.redAccent,
                  //       width: 2,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Get.toNamed(
                  //       Routes.ticketScreen,
                  //       arguments: getData,
                  //     );
                  //   },
                  //   child: Text(
                  //     "Order Details",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        width: screenSize.width,
        height: 2,
        color: Colors.grey,
      ),
    ],
  );
}

//Profile Screen
buildProfileScreen(
  bool _isLoading,
  GetUserProfileModal userAddData,
  Size size,
  BuildContext context,
  VoidCallback _logoutFunc,
  PanelController _panelController,
) {
  final userImage = userAddData.data?.image;
  print(userImage);
  Widget centerlistItem(
      {context,
      String? leftIconImage,
      String? title,
      String? rightIconImage,
      onTapfunc}) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        onTapfunc();
      },
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.02),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.050,
                      height: size.height * 0.032,
                      child: SvgPicture.asset(
                        leftIconImage!,
                        fit: BoxFit.contain,
                        width: size.width * 0.050,
                        height: size.height * 0.032,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      title.toString(),
                      style: TextStyle(
                          fontFamily: FontsDisPlay.dmSantsRegular,
                          color: Colors.white,
                          fontSize: size.width * 0.04),
                    ),
                  ]),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.06,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: size.width * 0.07,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: Colors.white,
              thickness: size.height * 0.0003,
            ),
          ],
        ),
      ),
    );
  }

  //Main thing
  return SafeArea(
    child: Container(
      color: Colors.grey[900],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.035),
            child: Column(
              children: [
// top content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
// image
                    CircleAvatar(
                      radius: size.width * 0.085,
                      backgroundImage: userImage == null
                          ? AssetImage("assets/images/defaultImage.png")
                          : NetworkImage(userImage) as ImageProvider,
                      backgroundColor: Colors.grey.shade400,
                    ),

                    SizedBox(
                      width: size.width * 0.02,
                    ),

// name email
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${userAddData.data?.name} ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: FontsDisPlay.dmSantsBold,
                                    color: Colors.white,
                                    fontSize: size.width * 0.058),
                              ),
                              Text(
                                "${userAddData.data?.email}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: FontsDisPlay.dmSantsRegular,
                                    color: Colors.grey,
                                    fontSize: size.width * 0.046),
                              ),
                            ]),
                      ),
                    ),
                  ],
// edit
                ),

                SizedBox(height: size.height * 0.060),
//Languages
                centerlistItem(
                    context: context,
                    title: AppTranslation.of(context)!.text("lang"),
// rightIconImage: ,
                    leftIconImage: "assets/images/Language.svg",
                    onTapfunc: () {
                      Get.toNamed(Routes.languageScreen);
                    }),
//History of Scanned Fiestas
                centerlistItem(
                    context: context,
                    title: AppTranslation.of(context)!.text("history"),
// rightIconImage: ,
                    leftIconImage: "assets/images/historyIco.svg",
                    onTapfunc: () {
                      Get.toNamed(Routes.scannedticketScreen);
                    }),
//Help
                centerlistItem(
                    context: context,
                    title: AppTranslation.of(context)!.text("help"),
// HelpIcon ,
                    leftIconImage: "assets/images/help.svg",
                    onTapfunc: () {
                      Get.toNamed(Routes.helpScreen);
                    }),
//Contact Us
                centerlistItem(
                    context: context,
                    title: AppTranslation.of(context)!.text("contact"),
// rightIconImage: ,
                    leftIconImage: "assets/images/ContactUS.svg",
                    onTapfunc: () {
                      Get.toNamed(Routes.contactUSScreen);
                    }),
                centerlistItem(
                    context: context,
                    title: AppTranslation.of(context)!.text("addABankAccount"),
// rightIconImage: ,
                    leftIconImage: "assets/images/stripe.svg",
                    onTapfunc: () async {
                      var isConnected =
                          await UserData.getUserLanguage("connected");
                      if (isConnected == "1") {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text(AppTranslation.of(context)!
                                  .text("already a stripe member")),
                              content: Text(AppTranslation.of(context)!
                                  .text("want to change the stripe")),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text(
                                      AppTranslation.of(context)!.text("yes")),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewXPage(),
                                        ));
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                      AppTranslation.of(context)!.text("no")),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        print("webview");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewXPage(),
                            ));
                      }
                    }),
                SizedBox(
                  height: size.height * 0.050,
                ),

                InkWell(
                  onTap: _logoutFunc,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Color(0xffFF5349),
                        )
                      : Container(
                          width: size.width * 0.60,
                          height: size.height * 0.060,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff3E332B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * 0.030,
                                width: size.width * 0.10,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/logout.png",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.090),
                              Text(
                                AppTranslation.of(context)!.text("logout"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//show BookigList
// buildBookingList(Size screeSize ) {
// return  Column(
//   children: [
//     //Custom AppBar
//
//       // Container(
//       //   height: screeSize.height * 0.18,
//       //   width: screeSize.width,
//       //   decoration: BoxDecoration(
//       //     color: Colors.redAccent,
//       //     borderRadius: BorderRadius.only(
//       //       bottomRight: Radius.circular(15),
//       //       bottomLeft: Radius.circular(15),
//       //     ),
//       //   ),
//       //   child: Padding(
//       //     padding: const EdgeInsets.only(left: 18.0),
//       //     child: Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         SizedBox(height: screeSize.height * 0.05),
//       //         SizedBox(height: screeSize.height * 0.03),
//       //         // Text(
//       //         //   "Scanned List",
//       //         //   style: TextStyle(
//       //         //     color: Colors.white,
//       //         //     fontWeight: FontWeight.w900,
//       //         //     fontSize: 20,
//       //         //   ),
//       //         // ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//
// // List Tile
//     buildPastTicketsListTile(screeSize),
//   ],
// );
// }
String k_m_b_generator(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} K";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(1)} K";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} M";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} B";
  } else {
    // print(num);
    return num.toString();
  }
}

Widget ratingstars({size, ittempading, color, double rating = 1.0}) {
  return RatingBar.builder(
    itemSize: size,
    initialRating: rating,
    ignoreGestures: true,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    unratedColor: AppColors.starUnselect,
    itemPadding: EdgeInsets.symmetric(horizontal: ittempading),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: color,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

Widget fiestasItem(
    {context, DataUser? postModeldata, required String getData}) {
  bool available = false;
  var size = MediaQuery.of(context).size;
  DateTime? date = DateTime.parse("${postModeldata?.fiestaDetail!.timestamp}");
  String month = DateFormat('MMM').format(date);
  String price = k_m_b_generator(
      int.parse("${postModeldata?.fiestaDetail!.ticketPriceNormal}"));
  double rating = 0.0;
  if (postModeldata?.fiestaDetail!.leftNormalTicket.toString() == "0" &&
      postModeldata?.fiestaDetail!.leftStandardTicket.toString() == "0" &&
      postModeldata?.fiestaDetail!.leftVipTicket.toString() == "0") {
    available = true;
  }
  if (postModeldata?.fiestaDetail!.clubRating == null ||
      postModeldata?.fiestaDetail!.clubRating == 0) {
    rating = 0.0;
  } else {
    rating = double.parse("${postModeldata?.fiestaDetail!.clubRating}");
  }
  return InkWell(
    onTap: () {
      if (available != true) {
        Get.toNamed(
          Routes.qrCodeScannerScreen,
          arguments: getData,
        );
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.width * 0.04),
            width: size.width,
            height: size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                image: DecorationImage(
                    image:
                        postModeldata?.fiestaDetail?.clubDetail?.image == null
                            ? AssetImage("assets/images/Appicon.png")
                            : NetworkImage(
                                "${postModeldata?.fiestaDetail?.clubDetail?.image}",
                              ) as ImageProvider,
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.0035),
                    color: AppColors.homeBackground.withOpacity(0.4),
                    width: size.width * 0.1,
                    height: size.height * 0.055,
                    child: Container(
                      height: size.height * 0.047,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "${date.day}",
                              style: TextStyle(
                                  fontSize: size.width * 0.043,
                                  fontFamily: FontsDisPlay.dmSantsBold,
                                  color: Color(0xffFFFFFF)),
                            ),
                          ),
                          Text(
                            "${month.toUpperCase()}",
                            style: TextStyle(
                                fontSize: size.width * 0.027,
                                fontFamily: FontsDisPlay.dmSantsMedium,
                                color: Color(0xffFFFFFF)),
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.01),
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                      color: AppColors.homeBackground,
                      border: Border(
                        left: BorderSide(
                            width: size.height * 0.001,
                            color: available == false
                                ? AppColors.tagBorder
                                : AppColors.blackBackground),
                        right: BorderSide(
                            width: size.height * 0.001,
                            color: available == false
                                ? AppColors.tagBorder
                                : AppColors.blackBackground),
                        bottom: BorderSide(
                            width: size.height * 0.001,
                            color: available == false
                                ? AppColors.tagBorder
                                : AppColors.blackBackground),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${postModeldata?.fiestaDetail?.name}",
                            style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontFamily: FontsDisPlay.dmSantsBold,
                                color: AppColors.white),
                          ),
                          SizedBox(
                            height: size.height * 0.004,
                          ),
                          Text(
                            "${postModeldata?.fiestaDetail?.distanceMiles}",
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontFamily: FontsDisPlay.dmSantsMedium,
                                color: Color(0xffFFFFFF)),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Container(
                              // width: size.width * 0.3,
                              child: ratingstars(
                                  size: size.width * 0.05,
                                  ittempading: size.width * 0.0001,
                                  color: AppColors.tagBorder,
                                  rating: rating))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Strings.startingfrom,
                            style: TextStyle(
                                fontSize: size.width * 0.025,
                                fontFamily: FontsDisPlay.dmSantsMedium,
                                color: AppColors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Strings.euro,
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontFamily: FontsDisPlay.dmSantsBold,
                                    color: AppColors.white),
                              ),
                              Text(
                                // postModeldata!.ticketPrice!.length > 9
                                //     ? "${postModeldata.ticketPrice?.substring(0, 9)}"
                                //     : "${postModeldata.ticketPrice}",
                                "$price",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: size.width * 0.068,
                                    fontFamily: FontsDisPlay.dmSantsBold,
                                    color: AppColors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     if (available != true) {
                          //       // navigatorPushFun(context,
                          //       //     BookNowBeta(fiestasID: postModeldata?.id));
                          //     }
                          //   },
                          //   child: roundedBoxR(
                          //       width: size.width * 0.23,
                          //       // height: size.height * 0.033,
                          //       radius: 3.0,
                          //       backgroundColor: available
                          //           ? Colors.grey[800]
                          //           : AppColors.siginbackgrond,
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         padding: EdgeInsets.symmetric(
                          //             vertical: size.height * 0.008,
                          //             horizontal: size.width * 0.01),
                          //         child: Text(
                          //           // Strings.booknow,
                          //           available
                          //               ? "${AppTranslation.of(context)!.text("outofstock")}"
                          //               : "${AppTranslation.of(context)!.text("bookNow")}",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               fontSize: size.width * 0.03,
                          //               fontFamily: FontsDisPlay.dmSantsBold,
                          //               color: AppColors.white),
                          //         ),
                          //       )),
                          // )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // up
          available
              ? Container(
                  margin: EdgeInsets.only(top: size.width * 0.04),
                  width: size.width,
                  height: size.height * 0.28,
                  color: Colors.black.withOpacity(0.4),
                )
              : SizedBox()
        ],
      ),
    ),
  );
}
