import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';

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
buildPastTicketsListTile(Size screenSize) {
  return Column(
    children: [
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
                    "Pack \"La havanna\" ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.010),
                  Text(
                    "order Delivered on 24 July \,",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.010),
                  Text(
                    "Thursday , 08:30 PM",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
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
                    onPressed: () {},
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
