import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';
import 'package:funfy_scanner/widgets/widgets.dart';
import 'package:get/get.dart';

class GetBookingList extends StatefulWidget {
  final int? clubID;

  const GetBookingList({
    Key? key,
    this.clubID,
  }) : super(key: key);

  @override
  _GetBookingListState createState() => _GetBookingListState();
}

class _GetBookingListState extends State<GetBookingList> {
  List? timeStamp = [];
  String? forTime;
  String? forDate;
  bool _isLoading = false;
  BookingListModal getBookingData = BookingListModal();

  @override
  void initState() {
    //    //for Booking List
    getBookingList();
    super.initState();
    print("Gewt Booking  Screen ====>${widget.clubID.toString()}");
  }

  //for Booking List Screen
  getBookingList() {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then((userToken) {
      print(userToken);

      ApiCaller()
          .getBookingList(
        userToken,
        widget.clubID.toString(),
      )
          .then((getBookingListData) {
        print("Booking List Data ==>$getBookingListData");

        setState(() {
          getBookingData = getBookingListData;
          _isLoading = false;
        });
      });
    });
  }

  //Navigate to qr scan screen

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

    return _isLoading
        ? Center(child: LoadingScreen())
        : Scaffold(
            backgroundColor: Colors.black87,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/BgImage.png"))),
                ),
                Column(
                  children: [
                    Container(
                      width: screeSize.width,
                      height: 90,
                      decoration: BoxDecoration(
                          color: AppColors.brown,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Column(
                        children: [
                          SizedBox(height: screeSize.height * 0.050),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(width: 14),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width: 60,
                                      height: 50,
                                      // color: Colors.red,

                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios,
                                            color: AppColors.white,
                                            size: 15,
                                          ),
                                          Text(
                                            "Back",
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 14,
                                              fontFamily: FontsDisPlay
                                                  .productsSansRegular,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppTranslation.of(context)!.text("fiestaList"),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 24,
                                        fontFamily: FontsDisPlay
                                            .productsSansRegular,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screeSize.height * 0.010),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Fiestas List",
                          //       style: TextStyle(
                          //         color: AppColors.white,
                          //         fontSize: 24,
                          //         fontFamily: FontsDisPlay.productsSansRegular,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: screeSize.width * 0.020),
                        ],
                      ),
                    ),
                    Expanded(
                      child: getBookingData.data!.data!.isEmpty
                          ? Center(child: Text("Nothing to show! "))
                          : ListView.builder(
                              itemCount: getBookingData.data?.data?.length,
                              padding: EdgeInsets.only(top: 10),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = getBookingData.data?.data![index];
                                var userName = data?.userDetail?.name;
                                timeStamp = data?.fiestaDetail!.timestamp!
                                    .toString()
                                    .split(" ");
                                print(
                                    "Date And Time is ====>${timeStamp.toString()}");
                                forDate = timeStamp!.first.toString();
                                forTime = timeStamp![1].toString();
                                var bookingId =
                                    getBookingData.data?.data![index].id;

                                final fiestaImage =
                                    data?.fiestaDetail?.clubDetail?.image;
                                final fiestaName =
                                    data?.fiestaDetail?.clubDetail?.name;
                                final fiestaAttendes =
                                    data?.fiestaDetail?.totalMembers;
                                final bookingID = data?.id;
                                print(" Booking Id{$bookingId}");
                                print("$forDate DatAndTime Is $forTime");
                                print("fiesta image is $fiestaImage ");

                                return FiestaTile(
                                  fiestaImage: fiestaImage.toString(),
                                  fiestaName: fiestaName.toString(),
                                  fiestatiming: forTime,
                                  fiestaDate: forDate,
                                  totalAttendenes: fiestaAttendes.toString(),
                                  clubid: widget.clubID.toString(),
                                  bookingid: bookingID.toString(),
                                );
                              }),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

class FiestaTile extends StatelessWidget {
  final String? fiestaName;
  final String? fiestatiming;
  final String? fiestaDate;

  final String? totalAttendenes;
  final String? fiestaImage;
  final String? clubid;
  final String? bookingid;

  const FiestaTile({
    Key? key,
    required this.fiestaName,
    required this.fiestatiming,
    required this.fiestaDate,
    required this.totalAttendenes,
    required this.fiestaImage,
    required this.clubid,
    required this.bookingid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 158,
      margin: EdgeInsets.only(top: 15, left: 10, right: 20),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 125.21,
            width: screenSize.width * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: fiestaImage!.isEmpty ||
                          fiestaImage == null ||
                          fiestaImage == "null"
                      ? AssetImage("assets/images/Appicon.png")
                      : NetworkImage(fiestaImage!) as ImageProvider,
                )),
          ),
          SizedBox(width: screenSize.width * 0.035),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.010),
              Container(
                width: 150,
                child: Text(fiestaName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontFamily: FontsDisPlay.robotoBold,
                    )),
              ),
              SizedBox(height: screenSize.height * 0.014),
              Text("${fiestatiming!} | $fiestaDate",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontFamily: FontsDisPlay.robotoRegular,
                  )),
              SizedBox(height: screenSize.height * 0.014),
              Text(
                "Total Attendies :$totalAttendenes",
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: FontsDisPlay.robotoRegular,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: screenSize.height * 0.010),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.orangeColor,
                        width: 2,
                      ),
                      primary: AppColors.brown,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size(150, 30)),
                  onPressed: () {
                    Get.toNamed(
                      Routes.qrCodeScannerScreen,
                      arguments: [
                        {"clubid": clubid},
                        {"bookingid": bookingid},
                      ],
                    );
                  },
                  child: Text("SCAN TICKET",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontFamily: FontsDisPlay.robotoBold,
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
