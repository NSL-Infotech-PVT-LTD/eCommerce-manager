import 'package:flutter/material.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/GetAboutUsModal.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GetAboutUsModal getAboutData = GetAboutUsModal();
  bool _isLoading = false;
  @override
  void initState() {
    getAboutUsData();
    super.initState();
  }

  getAboutUsData() {
    setState(() {
      _isLoading = true;
    });
    ApiCaller().getAboutUS(context).then((aboutUsData) {
      print("AboutUs ${(aboutUsData as GetAboutUsModal).data?.config}");
      setState(() {
        getAboutData = aboutUsData;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: LoadingScreen())
        : Scaffold(
            backgroundColor: Colors.white,
            body: (getAboutData.data == null || getAboutData.data?.config == "")
                ? Center(
                    child: Text("Nothing to show !",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )))
                : Container(
                    child: Center(
                      child: Text(
                        "${getAboutData.data?.config}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
          );
  }
}
