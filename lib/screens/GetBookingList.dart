import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:intl/intl.dart';

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
  bool _listIsLoading = false;
  bool hasmore = true;
  int documentLimit = 10;
  int page = 1;
  int totalPage = 1;

  String? orderChange = "desc";

  ScrollController controller = ScrollController();

  final _scafKey = GlobalKey<ScaffoldState>();
  List<DataUser> bookingList = [];

  @override
  void dispose() {
    controller.dispose();
    page = 1;
    totalPage = 1;
    super.dispose();
  }

  @override
  void initState() {
    //for Booking List
    getBookingList();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (page <= totalPage) {
          getBookingList();
        }
      }
    });
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
          .getBookingList(userToken, widget.clubID.toString(),
              orderChange.toString(), page, context)
          .then((getBookingListData) {
        totalPage = getBookingListData?.data?.lastPage ?? 1;
        var list = <DataUser>[];
        list.addAll(getBookingListData?.data?.data ?? []);

        setState(() {
          page++;
          bookingList.addAll(list);
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
            key: _scafKey,
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
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppTranslation.of(context)!
                                          .text("fiestaList"),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 24,
                                        fontFamily:
                                            FontsDisPlay.productsSansRegular,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _scafKey.currentState?.showBottomSheet(
                                        (context) => Container(
                                          height: 140,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: AppColors.orangeColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              )),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height:
                                                      screeSize.height * 0.010),
                                              Container(
                                                height: 5,
                                                width: screeSize.width * 0.1,
                                                decoration: BoxDecoration(
                                                  color: AppColors.brown,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      screeSize.height * 0.002),
                                              Text(
                                                  AppTranslation.of(context)!
                                                      .text("setordering"),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                  )),
                                              SizedBox(
                                                  height:
                                                      screeSize.height * 0.030),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        orderChange = "asc";
                                                        getBookingList();
                                                        print(
                                                            "order Change is $orderChange");
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: screeSize.width *
                                                          0.30,
                                                      height: screeSize.height *
                                                          0.080,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.brown,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "ASC",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: screeSize
                                                                      .width *
                                                                  0.020),
                                                          Image.asset(
                                                            "assets/images/assending.png",
                                                            color:
                                                                AppColors.white,
                                                            width: screeSize
                                                                    .width *
                                                                0.050,
                                                            height: screeSize
                                                                    .height *
                                                                0.050,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        orderChange = "desc";
                                                        getBookingList();
                                                        print(
                                                            "order Change is $orderChange");
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: screeSize.width *
                                                          0.30,
                                                      height: screeSize.height *
                                                          0.080,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.brown,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "DESC",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: screeSize
                                                                      .width *
                                                                  0.020),
                                                          Image.asset(
                                                            "assets/images/dessending.png",
                                                            color:
                                                                AppColors.white,
                                                            width: screeSize
                                                                    .width *
                                                                0.050,
                                                            height: screeSize
                                                                    .height *
                                                                0.050,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.sort,
                                      color: AppColors.white,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: screeSize.height * 0.010),
                        ],
                      ),
                    ),
                    Expanded(
                      child: bookingList.isEmpty
                          ? Center(child: Text("Nothing to show! "))
                          : ListView.builder(
                              controller: controller,
                              itemCount: totalPage > 1
                                  ? bookingList.length + 1
                                  : bookingList.length,
                              padding: EdgeInsets.only(top: 10),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index == bookingList.length) {
                                  return buildProgressIndicatorCenter(true);
                                } else {
                                  final data = bookingList[index];

                                  timeStamp = data.fiestaDetail!.timestamp!
                                      .toString()
                                      .split(" ");
                                  // print(
                                  // "Date And Time is ====>${timeStamp.toString()}");
                                  forDate = timeStamp!.first.toString();
                                  forTime = timeStamp![1].toString();
                                  DateTime now = DateTime.parse(
                                      data.fiestaDetail!.timestamp!.toString());
                                  String formattedTime =
                                      DateFormat('kk:mm a').format(now);
                                  // print("dfgdfg$formattedTime");
                                  var bookingId = bookingList[index].id;

                                  final fiestaImage =
                                      data.fiestaDetail?.clubDetail?.image;
                                  final fiestaName =
                                      data.fiestaDetail?.clubDetail?.name;
                                  final fiestaAttendes =
                                      data.fiestaDetail?.totalMembers;
                                  final bookingID = data.id;
                                  // print(" Booking Id{$bookingId}");
                                  // print("$forDate DatAndTime Is $forTime");
                                  // print("fiesta image is $fiestaImage ");
                                  return FiestaTile(
                                    fiestaImage: fiestaImage.toString(),
                                    fiestaName: fiestaName.toString(),
                                    fiestatiming: formattedTime,
                                    fiestaDate: forDate,
                                    totalAttendenes: fiestaAttendes.toString(),
                                    clubid: widget.clubID.toString(),
                                    bookingid: bookingID.toString(),
                                  );
                                }
                              }),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget buildProgressIndicatorCenter(bool isLoading) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Align(
        alignment: Alignment.center,
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(
            // backgroundColor: AppColors.orangeColor,
            color: AppColors.orangeColor,
          ),
        ),
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
          // Container(
          //   height: 125.21,
          //   width: screenSize.width * 0.35,
          //   decoration: BoxDecoration(
          //       color: Colors.white12,
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: fiestaImage!.isEmpty ||
          //                 fiestaImage == null ||
          //                 fiestaImage == "null"
          //             ? AssetImage("assets/images/Appicon.png")
          //             : NetworkImage(fiestaImage!) as ImageProvider,
          //       )),
          // ),

          Container(
            height: 125.21,
            width: screenSize.width * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: fiestaImage!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: AppColors.orangeColor,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppTranslation.of(context)!.text("totalAttendes"),
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: FontsDisPlay.robotoRegular,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "$totalAttendenes",
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: FontsDisPlay.robotoRegular,
                      fontSize: 12,
                    ),
                  ),
                ],
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
                  child: Text(AppTranslation.of(context)!.text("scanTicket"),
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
