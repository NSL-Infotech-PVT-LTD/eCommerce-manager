import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/GetHelpModal.dart';
import 'package:funfy_scanner/Models/GetTermsAndCondition.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:flutter_html/flutter_html.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  GetTermsAndConditions gethelpdata = GetTermsAndConditions();
  bool _isLoading = false;

  @override
  void initState() {
    getHelpData();
    super.initState();
  }

  getHelpData() {
    setState(() {
      _isLoading = true;
    });
    ApiCaller().getHelpData(context).then((helpData) {
      print(
          " Help Data is ${(helpData as GetTermsAndConditions).data!.config}");
      setState(() {
        gethelpdata = helpData;
        _isLoading = false;
        print("fdsfgdg  ${gethelpdata.data?.config}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: LoadingScreen())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0.0,
              title: Text(
                AppTranslation.of(context)!.text("terms"),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
            ),
            body: (gethelpdata.data == null || gethelpdata.data?.config == "")
                ? Center(
                    child: Text("Nothing to show!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )))
                : Container(
                    color: AppColors.grayFont,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Html(data: gethelpdata.data!.config!))),
          );
  }
}
