import 'bookingListModal.dart';

class GetScanData {
  bool? status;
  int? code;
  Data? data;

  GetScanData({this.status, this.code, this.data});

  GetScanData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int ?currentPage;
  List<DataUser>? data;
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String? lastPageUrl;
  Null ?nextPageUrl;
  String? path;
  int ?perPage;
  Null ?prevPageUrl;
  int? to;
  int ?total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    if (json['data'] != null) {

      data = <DataUser>[];
      // json['data'].forEach()
      // data = List.filled(1, DataUser.fromJson(json), growable: true);
      json['data'].forEach((v) {
        data!.add(new DataUser.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
//
// class DataUser {
//   int? id;
//   int ?userId;
//   int ?fiestaId;
//   String? totalPrice;
//   String ?bookingStatus;
//   FiestaBookingItems ?fiestaBookingItems;
//   UserDetail ?userDetail;
//   FiestaDetail? fiestaDetail;
//
//   DataUser(
//       {this.id,
//         this.userId,
//         this.fiestaId,
//         this.totalPrice,
//         this.bookingStatus,
//         this.fiestaBookingItems,
//         this.userDetail,
//         this.fiestaDetail});
//
//   DataUser.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     fiestaId = json['fiesta_id'];
//     totalPrice = json['total_price'];
//     bookingStatus = json['booking_status'];
//     fiestaBookingItems = json['fiesta_booking_items'] != null
//         ? new FiestaBookingItems.fromJson(json['fiesta_booking_items'])
//         : null;
//     userDetail = json['user_detail'] != null
//         ? new UserDetail.fromJson(json['user_detail'])
//         : null;
//     fiestaDetail = json['fiesta_detail'] != null
//         ? new FiestaDetail.fromJson(json['fiesta_detail'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['fiesta_id'] = this.fiestaId;
//     data['total_price'] = this.totalPrice;
//     data['booking_status'] = this.bookingStatus;
//     if (this.fiestaBookingItems != null) {
//       data['fiesta_booking_items'] = this.fiestaBookingItems!.toJson();
//     }
//     if (this.userDetail != null) {
//       data['user_detail'] = this.userDetail!.toJson();
//     }
//     if (this.fiestaDetail != null) {
//       data['fiesta_detail'] = this.fiestaDetail!.toJson();
//     }
//     return data;
//   }
// }

class FiestaBookingItems {
  int? id;
  int? bookingId;
  String? ticketType;
  String ?ticketPrice;
  int ?quantity;

  FiestaBookingItems(
      {this.id,
        this.bookingId,
        this.ticketType,
        this.ticketPrice,
        this.quantity});

  FiestaBookingItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    ticketType = json['ticket_type'];
    ticketPrice = json['ticket_price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['ticket_type'] = this.ticketType;
    data['ticket_price'] = this.ticketPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}

class UserDetail {
  int ?id;
  String ?name;
  Role ?role;

  UserDetail({this.id, this.name, this.role});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  String? name;
  int? id;
  List<Null> ?permission;

  Role({this.name, this.id, this.permission});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    // if (json['permission'] != null) {
    //   permission = new List<Null>();
    //   json['permission'].forEach((v) {
    //     permission.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    // if (this.permission != null) {
    //   data['permission'] = this.permission.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class FiestaDetail {
  int ?id;
  String? name;
  int ?clubId;
  String ?timestamp;
  String ?ticketPrice;
  String ?ticketPriceStandard;
  String ?ticketPriceVip;
  String ?totalMembers;
  String ?dressCode;
  String ?partyMusic;
  String ?distanceKm;
  String ?distanceMiles;
  bool ?isFavourite;
  int ?leftStandardTicket;
  String ?leftVipTicket;
  int ?leftNormalTicket;
  Null ?clubRating;
  ClubDetail ?clubDetail;

  FiestaDetail(
      {this.id,
        this.name,
        this.clubId,
        this.timestamp,
        this.ticketPrice,
        this.ticketPriceStandard,
        this.ticketPriceVip,
        this.totalMembers,
        this.dressCode,
        this.partyMusic,
        this.distanceKm,
        this.distanceMiles,
        this.isFavourite,
        this.leftStandardTicket,
        this.leftVipTicket,
        this.leftNormalTicket,
        this.clubRating,
        this.clubDetail});

  FiestaDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clubId = json['club_id'];
    timestamp = json['timestamp'];
    ticketPrice = json['ticket_price'];
    ticketPriceStandard = json['ticket_price_standard'];
    ticketPriceVip = json['ticket_price_vip'];
    totalMembers = json['total_members'];
    dressCode = json['dress_code'];
    partyMusic = json['party_music'];
    distanceKm = json['distance_km'];
    distanceMiles = json['distance_miles'];
    isFavourite = json['is_favourite'];
 //   leftStandardTicket = json['left_standard_ticket'];
    // leftVipTicket = json['left_vip_ticket'];
    // leftNormalTicket = json['left_normal_ticket'];
    clubRating = json['club_rating'];
    clubDetail = json['club_detail'] != null
        ? new ClubDetail.fromJson(json['club_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['club_id'] = this.clubId;
    data['timestamp'] = this.timestamp;
    data['ticket_price'] = this.ticketPrice;
    data['ticket_price_standard'] = this.ticketPriceStandard;
    data['ticket_price_vip'] = this.ticketPriceVip;
    data['total_members'] = this.totalMembers;
    data['dress_code'] = this.dressCode;
    data['party_music'] = this.partyMusic;
    data['distance_km'] = this.distanceKm;
    data['distance_miles'] = this.distanceMiles;
    data['is_favourite'] = this.isFavourite;
    data['left_standard_ticket'] = this.leftStandardTicket;
    data['left_vip_ticket'] = this.leftVipTicket;
    data['left_normal_ticket'] = this.leftNormalTicket;
    data['club_rating'] = this.clubRating;
    if (this.clubDetail != null) {
      data['club_detail'] = this.clubDetail!.toJson();
    }
    return data;
  }
}

class ClubDetail {
  int? id;
  String? name;
  String ?image;
  String ?capacity;
  String ?description;
  String ?location;
  Null ?latitude;
  Null ?longitude;

  ClubDetail(
      {this.id,
        this.name,
        this.image,
        this.capacity,
        this.description,
        this.location,
        this.latitude,
        this.longitude});

  ClubDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    capacity = json['capacity'];
    description = json['description'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['description'] = this.description;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
