import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return await UserData.getUserToken("USERTOKEN").then((userToken) async {
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

    return RefreshIndicator(
      color: Color(0xffFF5349),
      onRefresh: getClubs,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          elevation: 20,
          centerTitle: true,
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
        body: SafeArea(
          child: Container(
              height: screenSize.height,
              width: screenSize.width,
              child: _isLoading
                  ? Center(child: LoadingScreen())
                  : (clubList.data!.data == null || clubList.data!.data == [])
                      ? Center(
                          child: Text("Nothing to Show!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )))
                      : ListView.builder(
                          itemCount: clubList.data?.data?.length,
                          itemBuilder: (context, index) {
                            final image = clubList.data!.data![index].image;
                            final clubTitle = clubList.data?.data![index].name;
                            final clubDesc =
                                clubList.data?.data![index].description;
                            final clunLocation =
                                clubList.data?.data![index].location;
                            final clubID = clubList.data?.data![index].id;
                            print("PAsr Ticket is ${clunLocation}");
                            print(
                                "Ddecdsvxcvxc${clubList.data?.data?[index].name}");
                            return InkWell(
                              onTap: () {
                                print("aszckxZbc ${clubID}");
                                Get.to(GetBookingList(
                                  clubID: clubID,
                                ));
                              },
                              child: Card(
                                margin: EdgeInsets.only(
                                    top: 6, left: 10, right: 10),
                                elevation: 0.0,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: image == null
                                        ? AssetImage(
                                            "assets/images/defaultImage.png")
                                        : NetworkImage(image.toString())
                                            as ImageProvider,
                                  ),
                                  title: Text(
                                    clubTitle.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    clubDesc.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
        ),
      ),
    );
  }
}
