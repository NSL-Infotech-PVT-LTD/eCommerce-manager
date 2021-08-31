import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Models/ClubListModal.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:get/get.dart';

class ClubList extends StatefulWidget {
  final ClubListModal? clubList;

  const ClubList({
    Key? key,
    required this.clubList,
  }) : super(key: key);

  @override
  _ClubListState createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(AppTranslation.of(context)!.text("clubsList"))
      ),
      body: Container(
          height: screenSize.height,
          width: screenSize.width,
          child: widget.clubList?.data?.data == null
              ? Center(child: LoadingScreen())
              : ListView.builder(
                  itemCount: widget.clubList?.data?.data!.length,
                  itemBuilder: (context, index) {
                    final image = widget.clubList!.data?.data![index].image;
                    final clubTitle = widget.clubList?.data?.data![index].name;
                    final clubDesc =
                        widget.clubList?.data?.data![index].description;
                    final clubID = widget.clubList?.data?.data![index].id;
                    print("Club ID is ${clubID}");
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.qrCodeScannerScreen,
                          arguments: clubID,
                        );
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
    );
  }
}
