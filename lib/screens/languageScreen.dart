import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';

import '../../../main.dart';

class TranslationPage extends StatefulWidget {
  final bool fromSplash;

  const TranslationPage({Key? key, required this.fromSplash}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

enum SingingCharacter { English, Spanish }

class _SigninState extends State<TranslationPage> {
  bool _loading = false;

  // next() async {
  //   var net = await Internetcheck.check();
  //   if (net != true) {
  //     Internetcheck.showdialog(context: context);
  //   } else {
  //     setState(() {
  //       _loading = true;
  //     });
  //     await getIntrodata().then((value) {
  //       setState(() {
  //         _loading = false;
  //       });
  //
  //       if (value.length != 0 && value != []) {
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) =>
  //                 Constants.prefs?.getString("token") != null &&
  //                         Constants.prefs?.getString("token") != ""
  //                     ? Home(
  //                         pageIndexNum: 0,
  //                       )
  //                     : Intro()));
  //       } else {
  //         // print("no intro data");
  //
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) =>
  //                 Constants.prefs?.getString("token") != null &&
  //                         Constants.prefs?.getString("token") != ""
  //                     ? Home(
  //                         pageIndexNum: 0,
  //                       )
  //                     : Signin()));
  //       }
  //     });
  //   }
  // }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String devicetype = "ios";

  var newValue;
  SingingCharacter? _character;

  // void changeLanguage(String enes) async {
  //   Locale locale = await setLocale(enes);
  //   MyApp.setLocale(context, locale);
  //
  //   // print("here is value - $enes");
  //
  //   // if (enes == "en") {
  //   //   Constants.prefs!.setString("en", "$enes");
  //   // }
  //   // if (enes == "es") {
  //   //   Constants.prefs!.setString("es", "$enes");
  //   // }
  //
  //   if (_character == SingingCharacter.English) {
  //     Constants.prefs?.setString(Strings.radioValue, "en");
  //   } else if (_character == SingingCharacter.Spanish) {
  //     Constants.prefs?.setString(Strings.radioValue, "es");
  //   }
  // }

  @override
  void initState() {
    // // print("radio value - ${Strings.radioValue}");
    // var radioini = Constants.prefs!.getString(Strings.radioValue);
    // // print("first language " + radioini.toString());
    //
    // _character = radioini == null
    //     ? SingingCharacter.English
    //     : radioini == "en"
    //         ? SingingCharacter.English
    //         : SingingCharacter.Spanish;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          body: Stack(alignment: Alignment.topLeft, children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/BG_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Image.asset("assets/images/translationicon.png"),
                  // app logo
                  SizedBox(
                    height: size.height * 0.05,
                  ),

                  // title

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "welcome to",
                              // Strings.welcometo,
                              style: TextStyle(
                                  // fontFamily: Fonts.dmSansMedium,
                                  fontSize: size.width * 0.048,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              "funfypartyapp",
                              // Strings.funfypartyapp,
                              style: TextStyle(
                                  // fontFamily: Fonts.dmSansMedium,
                                  fontSize: size.width * 0.048,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          "ChooseLanguage",
                          //  Strings.TranslationPage,
                          style: TextStyle(
                              fontSize: size.width * 0.088,
                              // fontFamily: FontsDisPlay.abrilFatface,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                      ],
                    ),
                  ),
                  // or
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ListTile(
                    title: Text(
                      'English',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.045),
                    ),
                    trailing: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Radio<SingingCharacter>(
                        // activeColor: AppColors.radioColor,
                        value: SingingCharacter.English,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                            if (value == SingingCharacter.English) {
                              newValue = "en";
                              // changeLanguage(newValue);
                              // print(newValue);
                            } else {
                              newValue = "es";
                              // changeLanguage(newValue);
                              // print(newValue);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: size.height * 0.0006,
                    color: Colors.white,
                  ),
                  ListTile(
                    title: Text(
                      'Spanish',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.045),
                    ),
                    trailing: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Radio<SingingCharacter>(
                        // activeColor: AppColors.radioColor,
                        value: SingingCharacter.Spanish,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                            if (value == SingingCharacter.English) {
                              newValue = "en";
                              // changeLanguage(newValue);
                              // print(newValue);
                            } else {
                              newValue = "es";
                              // changeLanguage(newValue);
                              // print(newValue);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  // forgot password
                  SizedBox(
                    height: size.height * 0.20,
                  ),
                  // TranslationPage Button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // print(_character);

                        if (_character == SingingCharacter.English) {
                          // Constants.prefs?.setString(Strings.radioValue, "en");
                          // Constants.prefs?.setString("language", "en");
                        } else if (_character == SingingCharacter.Spanish) {
                          // Constants.prefs?.setString(Strings.radioValue, "es");
                          // Constants.prefs?.setString("language", "es");
                        }

                        // Constants.prefs
                        //     ?.setString(Strings.radioValue, newValue ?? "es");
                        if (widget.fromSplash) {
                          // next();
                          //  navigatorPushFun(context, TranslationPage(fromSplash: true));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      // child: roundedBox(
                      //     width: size.width * 0.78,
                      //     height: size.height * 0.058,
                      //     backgroundColor: AppColors.siginbackgrond,
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         "${getTranslated(context, "Proceed")}",
                      //         // Strings.TranslationPage,
                      //         style: TextStyle(
                      //             fontFamily: Fonts.dmSansMedium,
                      //             fontSize: size.width * 0.05,
                      //             color: AppColors.white),
                      //       ),
                      //     )),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                   Colors.red,
                    // AppColors.siginbackgrond,
                  )))
                : SizedBox()
          ])),
    );
  }
}

socialSigninButton({context, String? title, String? iconImage, func}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: func,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        // roundedBox(
        //     width: size.width * 0.78,
        //     height: size.height * 0.053,
        //     backgroundColor: Colors.white,
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Text(
        //         // "${getTranslated(context, "title")}",
        //         title.toString(),
        //         style: TextStyle(
        //           color: AppColors.fbappletitle,
        //           fontFamily: FontsDisPlay.dmSantsMedium,
        //           // fontSize: size.width * 0.045,
        //           fontSize: size.width * 0.04,
        //         ),
        //       ),
        //     )),
        Positioned(
          left: size.width * 0.101,
          child: Container(
              width: size.width * 0.05,
              child: Image.asset(
                iconImage.toString(),
                // height: size.height * 0.02,
                width: size.width * 0.07,
                fit: BoxFit.cover,
              )),
        ),
      ],
    ),
  );
}
