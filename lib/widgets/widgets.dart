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
