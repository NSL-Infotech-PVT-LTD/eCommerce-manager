import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/localization/Application.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:get/get.dart';

enum getLang { en, es }

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  getLang initialValue = getLang.en;
  String? initialValueUse;

  @override
  void initState() {
    UserData.getUserLanguage("getUserLang").then((value) {
      setState(() {
        initialValueUse = value;
        print("iniState user Language ====>$initialValueUse");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
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
                  SizedBox(height: screenSize.height * 0.05),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTranslation.of(context)!.text("choose Language"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffF5F5F5),
                            fontSize: 25,
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
                              AppTranslation.of(context)!
                                  .text("funfy party app"),
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 18,
                                fontFamily: FontsDisPlay.robotoBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.060),
                        ListTile(
                          title: const Text('English',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          leading: Radio(
                            fillColor:
                                MaterialStateProperty.all(Color(0xffFF5349)),
                            value: getLang.en,
                            groupValue: initialValue,
                            onChanged: (value) {
                              setState(() {
                                initialValue = value as getLang;
                                initialValueUse = "en";
                                print(initialValueUse);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Spanish',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          leading: Radio(
                            fillColor:
                                MaterialStateProperty.all(Color(0xffFF5349)),
                            value: getLang.es,
                            groupValue: initialValue,
                            onChanged: (value) {
                              setState(() {
                                initialValue = value as getLang;
                                initialValueUse = "es";
                                print(initialValueUse);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffFF5349),
                              ),
                              onPressed: () {
                                print("cvbcbcvbnv =>>initialValueUse");
                                application
                                    .onLocaleChanged!(Locale(initialValueUse!));
                                UserData.setUserLanguage(
                                    key: "getUserLang",
                                    value: initialValueUse.toString());
                                Navigator.of(context).pop();
                                print(
                                    "User Language ====>>${UserData.getUserLanguage("getUserLang")}");
                              },
                              child: Text("Change Language")),
                        ),
                        SizedBox(height: screenSize.height * 0.040),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
