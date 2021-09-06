import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/colors.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/ClubListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/GetBookingList.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:get/get.dart';

class PastTicketsList extends StatefulWidget {
  // final ClubListModal clubList;

  const PastTicketsList({
    Key? key,
    // required this.clubList,
  }) : super(key: key);

  @override
  _PastTicketsListState createState() => _PastTicketsListState();
}

class _PastTicketsListState extends State<PastTicketsList> {
  ClubListModal clubList = ClubListModal();
  bool _isLoading = false;

  // getting Club List
  Future getClubList() async {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then((userToken) async {
      ApiCaller().getClubList(userToken, context).then((getClubList) {
        // print(
        //     "Club Data ==>${(getClubList as ClubListModal).data!.data![0].name}");
        setState(() {
          clubList = getClubList;
          _isLoading = false;
        });
      });
    });
  }

  Future getClubs() async {
    print("dfgdfgdfg");
    await UserData.getUserToken("USERTOKEN").then((userToken) async {
      await ApiCaller().getClubList(userToken, context).then((getClubList) {
        // print(
        //     "Club Data ==>${(getClubList as ClubListModal).data!.data![0].name}");
        setState(() {
          clubList = getClubList;
        });
      });
    });
  }

  @override
  void initState() {
    getClubList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return _isLoading
        ? Center(child: LoadingScreen())
        : SafeArea(
            child: Scaffold(
              body: Container(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //AppBar
                        Container(
                          width: screenSize.width,
                          height: 96,
                          child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/BgImage.png"))),
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 3, sigmaX: 4),
                                      child: Container(
                                        color:
                                            Color(0xff242323).withOpacity(0.25),
                                      ))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/BgImage.png"))),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: Container(
                                        color: Color(0xff242323)
                                            .withOpacity(0.35)),
                                  )),
                              Container(
                                width: screenSize.width,
                                child: clubList.data!.data!.isEmpty
                                    ? Center(
                                        child: Text("Nothing to Show !",
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            )))
                                                                                                                                                                                                                                         : RefreshIndicator(
                                  onRefresh: getClubs,
                                  color: Colors.orange,
                                      child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15,
                                          ),
                                          physics: BouncingScrollPhysics(),
                                          itemCount: clubList.data?.data?.length,
                                          padding: EdgeInsets.only(
                                              right: 8, left: 10, top: 18),
                                          itemBuilder: (context, index) {
                                            final image =
                                                clubList.data?.data![index].image;
                                            final clubTitle =
                                                clubList.data?.data![index].name;
                                            final clubDesc = clubList
                                                .data?.data![index].description;
                                            final clubLocation = clubList
                                                .data?.data![index].location;
                                            final clubID =
                                                clubList.data?.data![index].id;
                                            return ClubTile(
                                              clubName: clubTitle,
                                              clubDesc: clubDesc,
                                              clubLocation: clubLocation,
                                              clubID: clubID,
                                            );
                                          },
                                        ),
                                    ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
//APP Bar text
                    Center(
                      child: RefreshIndicator(
                        onRefresh: getClubs,
                        color: Colors.orange,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenSize.width * 0.040),
                            //title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                              AppTranslation.of(context)!.text("clubsList"),
                                  style: TextStyle(
                                    fontFamily: FontsDisPlay.productsSansBold,
                                    fontSize: 27,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 2),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.010),
                            //subtitle
                            Text(
                              AppTranslation.of(context)!.text("checkYourClubsAndFiestaList"),
                              style: TextStyle(
                                fontFamily: FontsDisPlay.productsSansRegular,
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class ClubTile extends StatelessWidget {
  final String? clubName;
  final String? clubDesc;
  final String? clubLocation;
  final int? clubID;

  ClubTile(
      {Key? key,
      required this.clubName,
      required this.clubDesc,
      required this.clubLocation,
      required this.clubID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 200,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.015),
          Container(
            width: screenSize.width,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              clubName.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.white,
                fontFamily: FontsDisPlay.robotoBold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.015),
          Container(
            width: screenSize.width,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
              clubDesc.toString(),
              style: TextStyle(
                fontSize: 9,
                fontFamily: FontsDisPlay.robotoRegular,
                color: AppColors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(height: screenSize.height * 0.020),
          //location

          Container(
            width: 150,

            // color: Colors.red,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/location.png",
                  height: 10.79,
                  width: 9,
                ),
                SizedBox(width: screenSize.width * 0.020),
                Container(
                  width: 100,
                  // color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Text(clubLocation.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontsDisPlay.robotoMedium,
                        fontSize: 13,
                      )),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              print("club id in clubs screen is $clubID");
              Get.to(
                GetBookingList(
                  clubID: clubID,
                ),
              );
            },
            child: Container(
                width: screenSize.width,
                height: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("OPEN",
                    style: TextStyle(
                      fontFamily: FontsDisPlay.robotoBold,
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
          SizedBox(height: screenSize.height * 0.020),
        ],
      ),
    );
  }
}
