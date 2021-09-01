import 'package:flutter/material.dart';
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
    // print("========>>${getBookingData.data?.data![0].userDetail!.name}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            AppTranslation.of(context)!.text("scanned List"),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.black87,
        body: _isLoading
            ? Center(child: LoadingScreen())
            : getBookingData.data!.data!.isEmpty
                ? Center(child: Text("Nothing to show! "))
                : ListView.builder(
                    itemCount: getBookingData.data?.data?.length,
                    itemBuilder: (context, index) {
                      final data = getBookingData.data?.data![index];
                      var userName = data?.userDetail?.name;
                      timeStamp =
                          data?.fiestaDetail!.timestamp!.toString().split(" ");
                      print("Date And Time is ====>${timeStamp.toString()}");
                      forDate = timeStamp!.first.toString();
                      forTime = timeStamp![1].toString();
                      var bookingId=getBookingData.data?.data![index].id;
                      print(" Booking Id{$bookingId}");
                      print("$forDate DatAndTime Is $forTime");

                      print(
                          "UserName =====:>>>>$index +${getBookingData.data!.data!.length}");
                      print("2nd data${getBookingData.data}");
                      return buildPastTicketsListTile(
                        screeSize,
                        userName.toString(),
                        forDate.toString(),
                        forTime.toString(),
                        data,
                        widget.clubID.toString(),

                      );
                      return Container(
                        height: 20,
                      );
                    }),
      ),
    );
  }
}
