import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/ClubListModal.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/GetBookingList.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:funfy_scanner/widgets/widgets.dart';
import 'package:get/get.dart';

class PastTicketsList extends StatefulWidget {
  final ClubListModal clubList;

  const PastTicketsList({
    Key? key,
    required this.clubList,
  }) : super(key: key);

  @override
  _PastTicketsListState createState() => _PastTicketsListState();
}

class _PastTicketsListState extends State<PastTicketsList> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          AppTranslation.of(context)!.text("clubsList"),
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
      body: SafeArea(
        child: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: widget.clubList.data?.data == null
                ? Center(child: LoadingScreen())
                : ListView.builder(
                    itemCount: widget.clubList.data?.data?.length,
                    itemBuilder: (context, index) {
                      final image = widget.clubList.data!.data![index].image;
                      final clubTitle = widget.clubList.data?.data![index].name;
                      final clubDesc =
                          widget.clubList.data?.data![index].description;
                      final clubID = widget.clubList.data?.data![index].id;
                      print("PAsr Ticket is ${clubID}");
                      return InkWell(
                        onTap: () {
                          // Get.toNamed(
                          //   Routes.qrCodeScannerScreen,
                          //   arguments: clubID,
                          // );
                          print("aszckxZbc ${clubID}");
                          Get.to(GetBookingList(
                            clubID: clubID,
                          ));
                        },
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(image.toString()),
                            ),
                            title: Text(clubTitle.toString()),
                            subtitle: Text(
                              clubDesc.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
