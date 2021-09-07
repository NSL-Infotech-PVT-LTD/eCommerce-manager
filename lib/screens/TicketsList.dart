import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';

import 'LoadingScreen.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({Key? key}) : super(key: key);

  @override
  _TicketsListState createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  bool _isLoading = false;

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
                                        AppTranslation.of(context)!.text("back"),
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
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: screeSize.width * 0.60,
                            height: 27,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xff3E332B),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                                "Booking on  24 July, Thursday,08:30 PM",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: FontsDisPlay.productsSansRegular,
                                  color: AppColors.white,
                                )),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                padding: EdgeInsets.only(top: 10),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TicketsListTile();
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
  const TicketsListTile({
    Key? key,
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
              Text("Gary F.Adams",
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
              ),
              SizedBox(width: screenSize.width * 0.035),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Basic Tickets",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: FontsDisPlay.productsSansRegular,
                      )),
                  SizedBox(height: screenSize.height * 0.015),
                  Text(
                    "Qty:2",
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
                "€ 200.99",
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
