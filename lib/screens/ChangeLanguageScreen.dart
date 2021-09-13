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
  String initialValueUse="en" ;

  @override
  void initState() {
    UserData.getUserLanguage("getUserLang").then((value) {
      setState(() {
        initialValueUse = value ;
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          height: 60.21,
                          width: 60.99,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/images/translationicon.png"),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: AppTranslation.of(context)!
                                      .text("welcome"),
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 18,
                                    fontFamily: FontsDisPlay.robotoThin,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  children: [
                                TextSpan(
                                  text: AppTranslation.of(context)!
                                      .text("funfypartyapp"),
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 18,
                                    fontFamily: FontsDisPlay.robotoBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ])),
                        ),
                        SizedBox(height: 6),
                        Text(
                          AppTranslation.of(context)!.text("choose Language"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffF5F5F5),
                            fontSize: 25,
                            fontFamily: "AbrilFatface",
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.060),
                      ],
                    ),
                  ),
                  // Language Choose Buttons
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Row(
                            children: [
                              const Text('English',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  )),
                              Spacer(),
                              Radio(
                                fillColor: MaterialStateProperty.all(
                                    Color(0xffFF5349)),
                                value: getLang.en,
                                groupValue: initialValueUse == "es"
                                    ? getLang.es
                                    : getLang.en,
                                onChanged: (value) {
                                  setState(() {
                                    initialValue = value as getLang;
                                    initialValueUse = "en";
                                    print(initialValueUse);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 2,
                          width: screenSize.width,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Row(
                            children: [
                              const Text('Spanish',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  )),
                              Spacer(),
                              Radio(
                                fillColor: MaterialStateProperty.all(
                                    Color(0xffFF5349)),
                                value: getLang.es,
                                groupValue: initialValueUse == "es"
                                    ? getLang.es
                                    : getLang.en,
                                onChanged: (value) {
                                  setState(() {
                                    initialValue = value as getLang;
                                    initialValueUse = "es";
                                    print(initialValueUse);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffFF5349),
                                  fixedSize: Size(screenSize.width, 50)),
                              onPressed: () {
                                print("cvbcbcvbnv =>>$initialValueUse");
                                application.onLocaleChanged!(
                                    Locale(initialValueUse.toString()));
                                UserData.setUserLanguage(
                                  key: "getUserLang",
                                  value: initialValueUse,
                                );
                                Navigator.of(context).pop();
                                print(
                                    "User Language ====>>${UserData.getUserLanguage("getUserLang")}");
                              },
                              child: Text("Change Language")),
                        ),
                        SizedBox(height: screenSize.height * 0.040),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
