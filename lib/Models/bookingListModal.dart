class BookingListModal {
  bool? status;
  int ?code;
  Data ?data;

  BookingListModal({this.status, this.code, this.data});

  BookingListModal.fromJson(Map<String, dynamic> json) {
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
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String? lastPageUrl;
  Null ?nextPageUrl;
  String ?path;
  int ?perPage;
  Null ?prevPageUrl;
  int ?to;
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
      data = List.filled(1, DataUser.fromJson(json), growable: true);
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
  int ?id;
  int ?userId;
  int ?fiestaId;
  String ?totalPrice;
  String ?bookingStatus;
  FiestaBookingItems? fiestaBookingItems;

  DataUser(
      {this.id,
        this.userId,
        this.fiestaId,
        this.totalPrice,
        this.bookingStatus,
        this.fiestaBookingItems});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fiestaId = json['fiesta_id'];
    totalPrice = json['total_price'];
    bookingStatus = json['booking_status'];
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
    if (this.fiestaBookingItems != null) {
      data['fiesta_booking_items'] = this.fiestaBookingItems!.toJson();
    }
    return data;
  }
}

class FiestaBookingItems {
  int ?id;
  int ?bookingId;
  String ?ticketType;
  String ?ticketPrice;
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
