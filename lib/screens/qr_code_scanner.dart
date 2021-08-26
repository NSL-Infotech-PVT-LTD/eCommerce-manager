import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';

// import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/Models/getScannedDataModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _qrKey = GlobalKey(debugLabel: "QR");
QRViewController? _controller;

class QRData extends StatefulWidget {
  const QRData({Key? key}) : super(key: key);

  @override
  _QRDataState createState() => _QRDataState();
}

int count = 0;

class _QRDataState extends State<QRData> {
  Barcode? data;
  PanelController _panelController = PanelController();
  QRViewController? controller;
  bool _isLoading = false;

  String _loadingS = "Loading...";

//for QR View
  _qrViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scannedData) {
      controller.pauseCamera();
      print("====>>><<<<${scannedData.code}");
      setState(() {
        data = scannedData;

        if (data!.code.isNotEmpty && data!.code != "") {
          controller.resumeCamera();

          _panelController.open();
          UserData.getUserToken("USERTOKEN").then((userToken) {
            print(userToken);
            ApiCaller()
                .getScannedData(
              data!.code,
              userToken,
            )
                .then((dataById) {
              print("fkhfskh $dataById");
              _panelController.close();
              if (dataById == null) {
                // print("Qr scannned IN condituion  ${dataById.code.toString()}");
                _panelController.close();
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text('Login Error'),
                      content: Text('Please enter the valid email !'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    );
                  },
                );
              } else {
                print("dfjsghfj ${dataById.toJson()}");

                if (dataById.data != null &&
                    dataById.data!.currentPage != null &&
                    dataById.data!.data!.length > 0) {
                  print("dfjsghfj ${dataById.data!.data!.first.toJson()}");

                  DataUser datauser = dataById.data!.data!.first;
                  _panelController.close();
                  // controller.dispose();

                  Get.toNamed(
                    Routes.ticketScreen,
                    arguments: datauser,
                    // arguments: data.code,
                  );
                } else {
                  print("dfjsghfj ${dataById.toJson()}");
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text('Login Error'),
                        content: Text('Please enter the valid email !'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    },
                  );
                  print("data not found");
                }
              }
            });
          });
        }
      });
    }).onDone(
      () {
        _panelController.close();

        // Navigate to Ticket Screen
      },
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.resumeCamera();
    } else if (Platform.isIOS) {
      _controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _displayLoadingBottomSheet() {
    return SlidingUpPanel(
      maxHeight: 90,
      minHeight: 0,
      color: Color(0xffFF5349),
      controller: _panelController,
      defaultPanelState: PanelState.CLOSED,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      panel: Container(
        decoration: BoxDecoration(),
        child: Row(
          children: [
            SizedBox(width: 30),
            CircularProgressIndicator(
              color: Color(0xffFFFFFF),
            ),
            SizedBox(width: 15),
            Text(
              "Please Wait",
              style: TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 21,
                fontFamily: FontsDisPlay.dmSantsBold,
              ),
            ),
          ],
        ),
      ),
      body: Scaffold(
        backgroundColor: Color(0xff000000),
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                //Qr code Scanner
                QRView(
                  key: _qrKey,
                  cameraFacing: CameraFacing.back,
                  onQRViewCreated: _qrViewCreate,
                ),
                Container(
                  color: Colors.black54,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    Text(
                      AppTranslation.of(context)!.text("scan QR Code"),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: FontsDisPlay.robotoBold,
                        fontSize: 29,
                      ),
                    ),
                    SizedBox(height: 6),
                    Column(
                      children: [
                        SizedBox(height: 5),
                        Text(
                          AppTranslation.of(context)!.text("scan the booked Qr code from"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontsDisPlay.robotoLight,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          AppTranslation.of(context)!.text("Customer Booking details."),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontsDisPlay.robotoLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                      height: 230,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xffFFEFBB)),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        child: Center(
                      child: (data != null)
                          ? Text("Data is :=) ${data?.code}")
                          : Text(""),
                    )),
                    SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return _displayLoadingBottomSheet();
  }
}
