import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';

import 'LoadingScreen.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({Key? key}) : super(key: key);

  @override
  _TicketsListState createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  bool _isLoading = false;
  GetScannedHistoryModal getScannedHistoryData = GetScannedHistoryModal();

  @override
  void initState() {
    getHistory();
    super.initState();
  }

//Get Scanned History
  getHistory() {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then((userToken) {
      print(userToken);
      ApiCaller().getScannedHistory(userToken).then((scannedHistory) {
        setState(() {
          getScannedHistoryData = scannedHistory;
          _isLoading = false;
          print(getScannedHistoryData.data?.data?[0].fiestaBookingDetail
              ?.fiestaBookingItems?.ticketPrice);
        });
      });
    });
  }

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
                          image: AssetImage(
                            "assets/images/BgImage.png",
                          ))),
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
                          SizedBox(height: screeSize.height * 0.060),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 60,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      SizedBox(width: screeSize.width * 0.035),
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        AppTranslation.of(context)!
                                            .text("back"),
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                          fontFamily:
                                              FontsDisPlay.productsSansRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                AppTranslation.of(context)!.text("ticketList"),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 24,
                                  fontFamily: FontsDisPlay.productsSansRegular,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                "assets/images/icon.png",
                                height: 16,
                                width: 14.4,
                                color: AppColors.brown,
                              ),
                              SizedBox(width: screeSize.width * 0.035),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          // Container(
                          //   margin: EdgeInsets.only(top: 15),
                          //   width: screeSize.width * 0.60,
                          //   height: 27,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //     color: Color(0xff3E332B),
                          //     borderRadius: BorderRadius.circular(5),
                          //   ),
                          //   child: Text(
                          //       "Booking on  24 July, Thursday,08:30 PM",
                          //       style: TextStyle(
                          //         fontSize: 10,
                          //         fontFamily: FontsDisPlay.productsSansRegular,
                          //         color: AppColors.white,
                          //       )),
                          // ),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    getScannedHistoryData.data?.data?.length,
                                padding: EdgeInsets.only(top: 10),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data =
                                      getScannedHistoryData.data?.data?[index];
                                  final ticketPrice = data?.fiestaBookingDetail
                                      ?.fiestaBookingItems?.ticketPrice;

                                  final ticketQuantity =
                                      data?.fiestaBookingDetail?.totalTickets;
                                  final bookingID = data?.bookingId;
                                  print('dfdsv$bookingID');
                                  final ticketType = data?.fiestaBookingDetail
                                      ?.fiestaBookingItems?.ticketType;

                                  return TicketsListTile(
                                    ticketPrice: ticketPrice.toString(),
                                    ticketQuantity: ticketQuantity.toString(),
                                    bookingID: bookingID.toString(),
                                    ticketType: ticketType.toString(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

class TicketsListTile extends StatelessWidget {
  final String ticketPrice;
  final String ticketQuantity;
  final String bookingID;
  final String ticketType;

  const TicketsListTile({
    Key? key,
    required this.ticketPrice,
    required this.ticketQuantity,
    required this.bookingID,
    required this.ticketType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 106,
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(bookingID,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontFamily: FontsDisPlay.productsSansRegular))
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff3E3832),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.white,
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset("assets/images/Ticket.svg")),
              SizedBox(width: screenSize.width * 0.035),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticketType,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: FontsDisPlay.productsSansRegular,
                      )),
                  SizedBox(height: screenSize.height * 0.015),
                  Text(
                    "Qty:$ticketQuantity",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontFamily: FontsDisPlay.productsSansRegular,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                "€ $ticketPrice",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
