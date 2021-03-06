import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          QRData(),
          Center(
            child: Image.asset(
              "assets/images/camera.png",
              color: Colors.black,
              height: 100,
            ),
          ),
          Center(child: Text("show Tickets")),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        alignment: Alignment.bottomCenter,
        color: Color(0xff3E332B),
        child: TabBar(
            indicatorColor: Colors.transparent,
            onTap: (value) {
              setState(() {
                index = value;
              });
              print(index);
            },
            controller: _tabController,
            tabs: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/camera.png",
                    color: index == 0 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Qr Code",
                    style: TextStyle(
                      color: index == 0 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 0
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ticket.png",
                    color: index == 1 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Past Tickets",
                    style: TextStyle(
                      color: index == 1 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 1
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/setting.png",
                    color: index == 2 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: index == 2 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 2
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
