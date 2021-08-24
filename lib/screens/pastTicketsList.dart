import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/widgets/widgets.dart';

class PastTicketsList extends StatefulWidget {
  final BookingListModal showBookingList;

  const PastTicketsList({
    Key? key,
    required this.showBookingList,
  }) : super(key: key);

  @override
  _PastTicketsListState createState() => _PastTicketsListState();
}

class _PastTicketsListState extends State<PastTicketsList> {
  List? timeStamp = [];
  String? forTime;
  String? forDate;

  @override
  Widget build(BuildContext context) {
    print("=============?${widget.showBookingList.data?.data?[1].fiestaBookingItems!.quantity}");
    final screeSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Scanned List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      // body:buildBookingList(screeSize),
      // body: widget.showBookingList.data?.data != null
      // ? Center(
      //     child: Text("Nothing to Show !",
      //         style: TextStyle(
      //           color: Colors.white,
      //         )))
      // :
      body: ListView.builder(
          itemCount: widget.showBookingList.data?.data!.length,
          itemBuilder: (context, index) {
            final data = widget.showBookingList.data?.data?[index = index == 0 ? 1 : index];
            var userName = data!.userDetail?.name;
            timeStamp = data.fiestaDetail!.timestamp!.toString().split(" ");
            print("Date And Time is ====>${timeStamp.toString()}");
            forDate = timeStamp!.first.toString();
            forTime = timeStamp![1].toString();
            print("$forDate DatAndTime Is $forTime");

            print(
                "UserName =====:>>>>$index +${widget.showBookingList.data!.data!.length}");
            print("2nd data${widget.showBookingList.data}");
            return buildPastTicketsListTile(
              screeSize,
              userName.toString(),
              forDate.toString(),
              forTime.toString(),
              data,
            );
          }),
    );
  }
}
