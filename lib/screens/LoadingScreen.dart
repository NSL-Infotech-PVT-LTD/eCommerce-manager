import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF5349),
      body: Center(
        child: SpinKitWave(
          color: Color(0xffFFFFFF),
          size: 50.0,
        ),
      ),
    );
  }
}
