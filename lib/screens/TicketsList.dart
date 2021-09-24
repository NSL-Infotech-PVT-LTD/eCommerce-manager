import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/GetScannedHistoryModal.dart';

// import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:get/get.dart';
import 'LoadingScreen.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({Key? key}) : super(key: key);

  @override
  _TicketsListState createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  bool _isLoading = false;
  bool _isSearch = false;
  GetScannedHistoryModal getScannedHistoryData = GetScannedHistoryModal();
  TextEditingController searchController = TextEditingController();
  static List<DataUser> dataUSer = [];
  static List<DataUser> newDataUSer = [];

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
      print("$userToken");
      ApiCaller().getScannedHistory(userToken, context).then((scannedHistory) {
        setState(() {
          getScannedHistoryData = scannedHistory;
          // print(
          //     "sxanned History modal ${getScannedHistoryData.data?.data?[0].fiestaBookingDetail?.totalTickets}");
          _isLoading = false;
          dataUSer = getScannedHistoryData.data!.data!;
          newDataUSer = dataUSer;
        });
      });
    });
  }

  searchFillter({required String searchKeyword}) {
    dynamic filter;
    print("FKfks ${newDataUSer.length}");
    newDataUSer = dataUSer;
    if (searchKeyword.isNotEmpty) {
      newDataUSer = newDataUSer.where((element) {
        return (element.fiestaBookingDetail?.userDetail?.name ?? "")
                .toLowerCase()
                .contains(searchController.text) ||
            (element.bookingId?.toString() ?? "")
                .contains(searchController.text);
      }).toList();
      print("FKfks ${newDataUSer.length}");
    } else {
      newDataUSer = dataUSer;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

    return _isLoading
        ? Center(child: LoadingScreen())
        : SafeArea(
            child: Scaffold(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: screeSize.width * 0.035),
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
                                            fontFamily: FontsDisPlay
                                                .productsSansRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _isSearch
                                    ? Expanded(
                                        child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextField(
                                            controller: searchController,
                                            cursorColor: AppColors.orangeColor,
                                            onChanged: (value) {
                                              print("----------+ $value");
                                              searchFillter(
                                                  searchKeyword: value);
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppTranslation.of(context)!.text("searchbyname"),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .orangeColor)),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isSearch = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color:
                                                        AppColors.orangeColor,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ))
                                    : Text(
                                        AppTranslation.of(context)!
                                            .text("ticketList"),
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 24,
                                          fontFamily:
                                              FontsDisPlay.productsSansRegular,
                                        ),
                                      ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearch = true;
                                        searchController.clear();
                                      });
                                    },
                                    icon: Icon(Icons.search)),
                                // SizedBox(width: screeSize.width * 0.035),
                              ],
                            ),
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
                              child: newDataUSer.isEmpty
                                  ? Center(
                                      child: Text(AppTranslation.of(context)!.text("nodataFound"),
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          )))
                                  : ListView.builder(
                                      itemCount: newDataUSer.length,
                                      padding: EdgeInsets.only(top: 10),
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final data = newDataUSer[index];
                                        final ticketPrice = data
                                            .fiestaBookingDetail
                                            ?.fiestaBookingItems![0]
                                            .ticketPrice;
                                        final ticketQuantity = data
                                            .fiestaBookingDetail?.totalTickets;
                                        final bookingID = data.bookingId;
                                        final ticketType = data
                                            .fiestaBookingDetail
                                            ?.fiestaBookingItems![0]
                                            .ticketType;
                                        getTicketType() {
                                          if (ticketType ==
                                              "ticket_price_normal") {
                                            return "Basic Ticket";
                                          } else if (ticketType ==
                                              "ticket_price_vip") {
                                            return "VIP Ticket";
                                          } else if (ticketType ==
                                              "ticket_price_standard") {
                                            return "Standard Ticket";
                                          }
                                        }

                                        // print(
                                        //     "asdscds${data.fiestaBookingDetail?.userDetail?.name}");
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.ticket1Screen,
                                              arguments: data,
                                            );
                                          },
                                          child: TicketsListTile(
                                            ticketPrice: ticketPrice.toString(),
                                            ticketQuantity:
                                                ticketQuantity.toString(),
                                            bookingID: bookingID.toString(),
                                            ticketType: getTicketType,
                                          ),
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
            ),
          );
  }
}

class TicketsListTile extends StatelessWidget {
  final String ticketPrice;
  final String ticketQuantity;
  final String bookingID;
  final Function ticketType;

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
              Text("Booking ID : $bookingID",
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
                  Text(ticketType()??"",
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
