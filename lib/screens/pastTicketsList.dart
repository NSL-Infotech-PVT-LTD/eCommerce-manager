import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/widgets/widgets.dart';

class PastTicketsList extends StatelessWidget {
  const PastTicketsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          //Custom AppBar

          Container(
            height: screeSize.height * 0.18,
            width: screeSize.width,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screeSize.height * 0.05),
                  // Row(
                  //   children: [
                  //     // Icon(
                  //     //   Icons.arrow_back_ios,
                  //     //   color: Colors.white,
                  //     //   size: 18,
                  //     // ),
                  //     // SizedBox(width: 5),
                  //     Text(
                  //       "Back",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: screeSize.height * 0.03),
                  Text(
                    "Scanned List",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screeSize.height * 0.040),
// List Tile
          buildPastTicketsListTile(screeSize),
        ],
      ),
    );
  }
}
