import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';

// import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TicketScreen1 extends StatefulWidget {
  const TicketScreen1({
    Key? key,
  }) : super(key: key);

  @override
  _TicketScreen1State createState() => _TicketScreen1State();
}

class _TicketScreen1State extends State<TicketScreen1> {
  int caroselSliderIndex = 0;
  CarouselPageChangedReason? carouselPageChangedReason;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    DataUser scannedData = Get.arguments;
    // bool isScanned = (Get.arguments["isScanned"]);
    // print("ISSvanne==> $isScanned");

    List? timeStamp = [];
    String forTime;
    String forDate;
    //get DataTime
    timeStamp =
        // scannedData.fiestaDetail!.timestamp //.data?[1].fiestaDetail!.timestamp
        //     .toString()
        //     .split(" ");
        scannedData.fiestaBookingDetail?.fiestaDetail!
            .timestamp //.data?[1].fiestaDetail!.timestamp
            .toString()
            .split(" ");
    forTime = timeStamp!.first!.toString();
    forDate = timeStamp[1].toString();
    print("$forDate DatAndTime $forTime");
    var timeStampCheck =
        // scannedData.fiestaDetail!.timestamp //.data?[1].fiestaDetail!.timestamp
        //     .toString();
        scannedData.fiestaBookingDetail?.fiestaDetail!
            .timestamp //.data?[1].fiestaDetail!.timestamp
            .toString();
    DateTime now = DateTime.parse(timeStampCheck.toString());
    String formattedTime = DateFormat('kk:mm a').format(now);
    print("sdfdsfdsf$formattedTime");
    //get Ratting
    final rattingGet =
        scannedData.fiestaBookingDetail?.fiestaDetail!.clubRating;
    final clubRatting = rattingGet == null ? 0 : rattingGet;

    //get Price
    final price = scannedData.fiestaBookingDetail?.totalPrice ?? 0;

    //  final date = DateFormat.jms().format(scannedData.data?.timestamp);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffFF5349),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffFF5349),
            centerTitle: true,
            title: Text(
              "E -Ticket",
              style: TextStyle(
                color: Color(0xffFFFFFF),
                fontFamily: FontsDisPlay.dmSantsRegular,
                fontSize: 18,
              ),
            ),
          ),
          body: CarouselSlider(
            options: CarouselOptions(
              height: screenSize.height * 0.7,
              viewportFraction: 1.0,
              reverse: false,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (value, carouselPageChangedReason) {
                setState(() {
                  caroselSliderIndex = value;
                });
              },
            ),
            items: scannedData.fiestaBookingDetail?.fiestaBookingItems
                ?.map((ticketType) {
              getTicketTypeScanned() {
                if (ticketType.ticketType.toString() == "ticket_price_normal") {
                  return "Basic Ticket";
                } else if (ticketType.ticketType.toString() ==
                    "ticket_price_vip") {
                  return "VIP Ticket";
                } else if (ticketType.ticketType.toString() ==
                    "ticket_price_standard") {
                  return "Standard Ticket";
                }
              }

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: EdgeInsets.only(top: 20, left: 30),
                          width: screenSize.width,
                          height: screenSize.height * 0.7,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
// Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     Image.asset("assets/images/expand.png"),
//     SizedBox(width: 10),
//   ],
// ),
                              SizedBox(height: screenSize.height * 0.0010),
                              Text(
                                AppTranslation.of(context)!.text("bookingName"),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: FontsDisPlay.dmSantsRegular,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                  "${scannedData.fiestaBookingDetail?.userDetail?.name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: FontsDisPlay.dmSantsBold,
                                      fontSize: 30,
                                      color: Color(0xff3E332B))),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/money.png",
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "\€ $price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3E332B),
                                      fontSize: 17,
                                      fontFamily: FontsDisPlay.dmSantsMedium,
                                    ),
                                  ),
                                  SizedBox(width: 8),
// Container(
//   width: 5,
//   height: 5,
//   decoration: BoxDecoration(
//     color: Color(0xff3E332B),
//     shape: BoxShape.circle,
//   ),
// ),
// SizedBox(width: 8),
// Text(
//   AppTranslation.of(context)!.text("2 person"),
//   style: TextStyle(
//     fontSize: 17,
//     color: Color(0xff3E332B),
//     fontFamily: FontsDisPlay.dmSantsMedium,
//   ),
// ),
                                ],
                              ),
                              SizedBox(height: 65),
                              Text(
                                  "${scannedData.fiestaBookingDetail?.fiestaDetail?.clubDetail?.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    fontFamily: FontsDisPlay.dmSantsBold,
                                    color: Color(0xff3E332B),
                                  )),
                              SizedBox(height: 8),
//Ratting Icons
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: clubRatting.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                unratedColor: Colors.grey,
                                onRatingUpdate: (ratting) {
                                  print(ratting);
                                },
                                updateOnDrag: true,
                              ),
                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildTicketTile(
                                          AppTranslation.of(context)!
                                              .text("orderId"),
                                          scannedData.id.toString()),
                                      SizedBox(height: 20),
                                      buildTicketTile(
                                          AppTranslation.of(context)!
                                              .text("time"),
                                          formattedTime),
                                    ],
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.18),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildTicketTile(
                                          AppTranslation.of(context)!
                                              .text("check In Type"),
                                          getTicketTypeScanned() ?? "null"),
                                      SizedBox(height: 20),
                                      buildTicketTile(
                                          AppTranslation.of(context)!
                                              .text("date"),
                                          forTime),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: screenSize.height * 0.030),
                              Expanded(
                                child:  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DotsIndicator(
                                            dotsCount: scannedData
                                                .fiestaBookingDetail!
                                                .fiestaBookingItems!
                                                .length,
                                            position:
                                                caroselSliderIndex.toDouble(),
                                            decorator: DotsDecorator(
                                              color:
                                                  Colors.grey, // Inactive color
                                              activeColor:
                                                  AppColors.orangeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
//circles for decoration
                        Padding(
                          padding: const EdgeInsets.only(top: 170),
                          child: Container(
                            width: screenSize.width,
                            height: 55,
                            child: Row(
                              children: [
//circle
                                Container(
                                  height: 39,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
//dotted Lines
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  child: Container(
                                    width: screenSize.width * 0.78,
                                    height: 2,
                                    decoration: DottedDecoration(
                                      color: Colors.grey,
                                      shape: Shape.line,
                                    ),
                                  ),
                                ),
//circle
                                Container(
                                  height: 39,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          )),
    );
  }
}
