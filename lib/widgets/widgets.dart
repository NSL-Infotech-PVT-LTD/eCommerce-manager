import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:get/get.dart';

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
buildPastTicketsListTile(
    Size screenSize, String name, String date, String time, getData) {
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
                    "Thursday , $time",
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
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      side: BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(
                        Routes.ticketScreen,
                        arguments: getData,
                      );
                    },
                    child: Text(
                      "Order Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
    //  showImage() {
    //   if (userImage == null) {
    //     return AssetImage("assets/images/defaultImage.png");
    //   } else {
    //     return NetworkImage(userImage);
    //   }
    // }

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
                        width: size.width * 0.045,
                        color: Colors.grey[300],
                        child: Image.asset("$leftIconImage")),
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
  return Container(
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
                    backgroundColor: Colors.white,
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

              SizedBox(height: size.height * 0.090),
//Languages
              centerlistItem(
                  context: context,
                  title: "languages",
// rightIconImage: ,
                  leftIconImage: "assets/images/expand.png",
                  onTapfunc: () {}),
//Help
              centerlistItem(
                  context: context,
                  title: "Help",
// Help: ,
                  leftIconImage: "assets/images/expand.png",
                  onTapfunc: () {}),
//Contact Us
              centerlistItem(
                  context: context,
                  title: "Contact Us",
// rightIconImage: ,
                  leftIconImage: "assets/images/expand.png",
                  onTapfunc: () {}),
              SizedBox(
                height: size.height * 0.18,
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
                          color: Colors.grey[600],
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
                              "Log Out",
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
            ],
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
