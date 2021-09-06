import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/ClubListModal.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/ClubList.dart';
import 'package:funfy_scanner/screens/TicketsList.dart';
import 'package:funfy_scanner/screens/pastTicketsList.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';
import 'package:funfy_scanner/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int index = 0;
  bool _isLoading = false;
  late GetUserProfileModal userAddData = GetUserProfileModal();
  late ClubListModal clubList = ClubListModal();
  BookingListModal getBookingData = BookingListModal();
  PanelController? _panelController = PanelController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // for User Profile Data
    getUserData();
    //    //for Booking List

    // //for Club List
    getClubList();
    super.initState();
  }

// getting Club List
  getClubList() {
    UserData.getUserToken("USERTOKEN").then((userToken) {
      ApiCaller().getClubList(userToken, context).then((getClubList) {
        setState(() {
          clubList = getClubList;
        });
        // print("Ddecdsvxcvxc${clubList.data!.data![0].location}");
      });
    });
  }

//for Profile Screen
  getUserData() {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then((userToken) {
      ApiCaller().getUserProfile(userToken, context).then((userData) {
        // print((userData as GetUserProfileModal).data!.email);
        setState(() {
          userAddData = (userData);
          _isLoading = false;
        });
      });
    });
  }

// logout User
  logoutmethod() {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then(
      (token) => ApiCaller().logout(token).then(
        (value) {
          setState(() {
            _isLoading = false;
          });
          return Get.offNamed(Routes.signInScreen);
        },
      ),
    );
  }

// pop Up when you  tap on  logout Button
  showpopUpForLOgout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                logoutmethod();
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              //showing Ticket List
              // TicketsList(),
              //shown Past Tickets List
              PastTicketsList(
                  // clubList: clubList,
                  ),
              //Profile Screen
              buildProfileScreen(_isLoading, userAddData, size, context,
                  showpopUpForLOgout, _panelController!),
            ],
          )),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 65,
            alignment: Alignment.bottomCenter,
            color: Color(0xff3E332B),
            child: Stack(
              children: [
                TabBar(
                    indicatorColor: Colors.transparent,
                    onTap: (value) {
                      setState(() {
                        index = value;
                      });
                      print("index is $index");
                    },
                    controller: _tabController,
                    tabs: [
                      //1st tab
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          index == 0
                              ? Image.asset(
                                  "assets/images/selectedticket.png",
                                  height: 32,
                                  width: 32,
                                )
                              : Image.asset(
                                  "assets/images/ticket.png",
                                  height: 32,
                                  width: 32,
                                ),
                          Text(
                            AppTranslation.of(context)!.text("bookings"),
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: index == 0
                                  ? FontsDisPlay.robotoMedium
                                  : FontsDisPlay.robotoRegular,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),

                      //3rd tab
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/setting.png",
                            height: 32,
                            width: 32,
                            color: index == 1
                                ? Color(0xffFF0000)
                                : Color(0xffFFFFFF),
                          ),
                          Text(
                            AppTranslation.of(context)!.text("profile"),
                            style: TextStyle(
                              color: index == 1
                                  ? Color(0xffFF0000)
                                  : Color(0xffFFFFFF),
                              fontFamily: index == 1
                                  ? FontsDisPlay.robotoMedium
                                  : FontsDisPlay.robotoRegular,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:index==0? GestureDetector(
          onTap:index==0? () {
            Get.toNamed(Routes.globalScannerScreen);
          }:null,
          child: Image.asset(
            "assets/images/scanner.png",
            height: 150,
            width: 150,
          )):Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
