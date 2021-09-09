class GetScannedHistoryModal {
  bool? status;
  int? code;
  Data? data;

  GetScannedHistoryModal({this.status, this.code, this.data});

  GetScannedHistoryModal.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<DataUser>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

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

class DataUser {
  int? id;
  int? bookingId;
  int? clubadminId;
  int? userId;
  FiestaBookingDetail? fiestaBookingDetail;
  UserDetail? clubAdminDetail;

  DataUser(
      {this.id,
      this.bookingId,
      this.clubadminId,
      this.userId,
      this.fiestaBookingDetail,
      this.clubAdminDetail});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    clubadminId = json['clubadmin_id'];
    userId = json['user_id'];
    fiestaBookingDetail = json['fiesta_booking_detail'] != null
        ? new FiestaBookingDetail.fromJson(json['fiesta_booking_detail'])
        : null;
    clubAdminDetail = json['club_admin_detail'] != null
        ? new UserDetail.fromJson(json['club_admin_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['clubadmin_id'] = this.clubadminId;
    data['user_id'] = this.userId;
    if (this.fiestaBookingDetail != null) {
      data['fiesta_booking_detail'] = this.fiestaBookingDetail!.toJson();
    }
    if (this.clubAdminDetail != null) {
      data['club_admin_detail'] = this.clubAdminDetail!.toJson();
    }
    return data;
  }
}

class FiestaBookingDetail {
  int? id;
  int? userId;
  int? fiestaId;
  String? totalPrice;
  String? bookingStatus;
  int? totalTickets;
  int? grandTotal;
  bool? readyForReview;
  FiestaDetail? fiestaDetail;
  UserDetail? userDetail;
  FiestaBookingItems? fiestaBookingItems;

  FiestaBookingDetail(
      {this.id,
      this.userId,
      this.fiestaId,
      this.totalPrice,
      this.bookingStatus,
      this.totalTickets,
      this.grandTotal,
      this.readyForReview,
      this.fiestaDetail,
      this.userDetail,
      this.fiestaBookingItems});

  FiestaBookingDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fiestaId = json['fiesta_id'];
    totalPrice = json['total_price'];
    bookingStatus = json['booking_status'];
    totalTickets = json['total_tickets'];
    grandTotal = json['grand_total'];
    readyForReview = json['ready_for_review'];
    fiestaDetail = json['fiesta_detail'] != null
        ? new FiestaDetail.fromJson(json['fiesta_detail'])
        : null;
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    fiestaBookingItems = json['fiesta_booking_items'] != null
        ? new FiestaBookingItems.fromJson(json['fiesta_booking_items'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fiesta_id'] = this.fiestaId;
    data['total_price'] = this.totalPrice;
    data['booking_status'] = this.bookingStatus;
    data['total_tickets'] = this.totalTickets;
    data['grand_total'] = this.grandTotal;
    data['ready_for_review'] = this.readyForReview;
    if (this.fiestaDetail != null) {
      data['fiesta_detail'] = this.fiestaDetail!.toJson();
    }
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.fiestaBookingItems != null) {
      data['fiesta_booking_items'] = this.fiestaBookingItems!.toJson();
    }
    return data;
  }
}

class FiestaDetail {
  int? id;
  String? name;
  int? clubId;
  String? timestamp;
  String? ticketPriceNormal;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  int? filterLocalId;
  Null? clubRating;
  int? leftNormalTicket;
  String? leftStandardTicket;
  String? leftVipTicket;
  bool? isFavourite;
  String? distanceMiles;
  FilterLocal? filterLocal;
  FilterLocal? filterEnvironment;
  FilterLocal? filterMusic;
  FilterLocal? filterClothing;
  FilterLocal? filterSchedule;
  ClubDetail? clubDetail;

  FiestaDetail(
      {this.id,
      this.name,
      this.clubId,
      this.timestamp,
      this.ticketPriceNormal,
      this.ticketPriceStandard,
      this.ticketPriceVip,
      this.totalMembers,
      this.filterLocalId,
      this.clubRating,
      this.leftNormalTicket,
      this.leftStandardTicket,
      this.leftVipTicket,
      this.isFavourite,
      this.distanceMiles,
      this.filterLocal,
      this.filterEnvironment,
      this.filterMusic,
      this.filterClothing,
      this.filterSchedule,
      this.clubDetail});

  FiestaDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clubId = json['club_id'];
    timestamp = json['timestamp'];
    ticketPriceNormal = json['ticket_price_normal'];
    ticketPriceStandard = json['ticket_price_standard'];
    ticketPriceVip = json['ticket_price_vip'];
    totalMembers = json['total_members'];
    filterLocalId = json['filter_local_id'];
    clubRating = json['club_rating'];
    leftNormalTicket = json['left_normal_ticket'];
    leftStandardTicket = json['left_standard_ticket'];
    leftVipTicket = json['left_vip_ticket'];
    isFavourite = json['is_favourite'];
    distanceMiles = json['distance_miles'];
    filterLocal = json['filter_local'] != null
        ? new FilterLocal.fromJson(json['filter_local'])
        : null;
    filterEnvironment = json['filter_environment'] != null
        ? new FilterLocal.fromJson(json['filter_environment'])
        : null;
    filterMusic = json['filter_music'] != null
        ? new FilterLocal.fromJson(json['filter_music'])
        : null;
    filterClothing = json['filter_clothing'] != null
        ? new FilterLocal.fromJson(json['filter_clothing'])
        : null;
    filterSchedule = json['filter_schedule'] != null
        ? new FilterLocal.fromJson(json['filter_schedule'])
        : null;
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
    data['ticket_price_normal'] = this.ticketPriceNormal;
    data['ticket_price_standard'] = this.ticketPriceStandard;
    data['ticket_price_vip'] = this.ticketPriceVip;
    data['total_members'] = this.totalMembers;
    data['filter_local_id'] = this.filterLocalId;
    data['club_rating'] = this.clubRating;
    data['left_normal_ticket'] = this.leftNormalTicket;
    data['left_standard_ticket'] = this.leftStandardTicket;
    data['left_vip_ticket'] = this.leftVipTicket;
    data['is_favourite'] = this.isFavourite;
    data['distance_miles'] = this.distanceMiles;
    if (this.filterLocal != null) {
      data['filter_local'] = this.filterLocal!.toJson();
    }
    if (this.filterEnvironment != null) {
      data['filter_environment'] = this.filterEnvironment!.toJson();
    }
    if (this.filterMusic != null) {
      data['filter_music'] = this.filterMusic!.toJson();
    }
    if (this.filterClothing != null) {
      data['filter_clothing'] = this.filterClothing!.toJson();
    }
    if (this.filterSchedule != null) {
      data['filter_schedule'] = this.filterSchedule!.toJson();
    }
    if (this.clubDetail != null) {
      data['club_detail'] = this.clubDetail!.toJson();
    }
    return data;
  }
}

class FilterLocal {
  String? name;
  String? nameEs;

  FilterLocal({this.name, this.nameEs});

  FilterLocal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEs = json['name_es'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_es'] = this.nameEs;
    return data;
  }
}

class ClubDetail {
  int? id;
  String? name;
  String? image;
  String? capacity;
  String? description;
  String? location;
  String? latitude;
  String? longitude;

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

class UserDetail {
  int? id;
  String? name;
  Role? role;

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

  // List<Null> ?permission;

  Role({
    this.name,
    this.id,
    // this.permission,
  });

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
    //   data['permission'] = this.permission!.map((v) => v!.toJson()).toList();
    // }
    return data;
  }
}

class FiestaBookingItems {
  int? id;
  int? bookingId;
  String? ticketType;
  String? ticketPrice;
  int? quantity;

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