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
  @override
  Widget build(BuildContext context) {
    print(
        "${widget.showBookingList.data?.data![1].fiestaBookingItems!.quantity}");

    final screeSize = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(),
      // ),
      backgroundColor: Colors.black87,
      // body:buildBookingList(screeSize),
      body: ListView.builder(
          // itemCount:,
          itemBuilder: (context, i) {
        return buildBookingList(screeSize);
      }),
    );
  }
}
