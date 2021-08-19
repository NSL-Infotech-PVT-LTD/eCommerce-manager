class PastTicketListModal {
  bool? status;
  int? code;
  Data? data;

  PastTicketListModal({this.status, this.code, this.data});

  PastTicketListModal.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? type;
  int? clubId;
  String? description;
  String? timestamp;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;

  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? totalNormalTickets;
  String? totalStandardTickets;
  String? totalVipTickets;
  String? distanceKm;

  String? distanceMiles;
  bool ?isFavourite;
  int ?leftStandardTicket;
  int ?leftVipTicket;
  int ?leftNormalTicket;
  Null? clubRating;
  ClubDetail ?clubDetail;
  List<FiestaImages> ?fiestaImages;

  Data(
      {this.id,
      this.name,
      this.type,
      this.clubId,
      this.description,
      this.timestamp,
      this.ticketPrice,
      this.ticketPriceStandard,
      this.ticketPriceVip,
      this.totalMembers,
      this.dressCode,
      this.partyMusic,
      this.totalNormalTickets,
      this.totalStandardTickets,
      this.totalVipTickets,
      this.distanceKm,
      this.distanceMiles,
      this.isFavourite,
      this.leftStandardTicket,
      this.leftVipTicket,
      this.leftNormalTicket,
      this.clubRating,
      this.clubDetail,
      this.fiestaImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    clubId = json['club_id'];
    description = json['description'];
    timestamp = json['timestamp'];
    ticketPrice = json['ticket_price'];
    ticketPriceStandard = json['ticket_price_standard'];
    ticketPriceVip = json['ticket_price_vip'];
    totalMembers = json['total_members'];
    dressCode = json['dress_code'];
    partyMusic = json['party_music'];
    totalNormalTickets = json['total_normal_tickets'];
    totalStandardTickets = json['total_standard_tickets'];
    totalVipTickets = json['total_vip_tickets'];
    distanceKm = json['distance_km'];
    distanceMiles = json['distance_miles'];
    isFavourite = json['is_favourite'];
    leftStandardTicket = json['left_standard_ticket'];
    leftVipTicket = json['left_vip_ticket'];
    leftNormalTicket = json['left_normal_ticket'];
    clubRating = json['club_rating'];
    clubDetail = json['club_detail'] != null
        ? new ClubDetail.fromJson(json['club_detail'])
        : null;
    if (json['fiesta_images'] != null) {
      fiestaImages = List.filled(1, FiestaImages.fromJson(json), growable: true); // [;
      json['fiesta_images'].forEach((v) {
        fiestaImages?.add(new FiestaImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['club_id'] = this.clubId;
    data['description'] = this.description;
    data['timestamp'] = this.timestamp;
    data['ticket_price'] = this.ticketPrice;
    data['ticket_price_standard'] = this.ticketPriceStandard;
    data['ticket_price_vip'] = this.ticketPriceVip;
    data['total_members'] = this.totalMembers;
    data['dress_code'] = this.dressCode;
    data['party_music'] = this.partyMusic;
    data['total_normal_tickets'] = this.totalNormalTickets;
    data['total_standard_tickets'] = this.totalStandardTickets;
    data['total_vip_tickets'] = this.totalVipTickets;
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
    if (this.fiestaImages != null) {
      data['fiesta_images'] = this.fiestaImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClubDetail {
  int ?id;
  String? name;
  String? image;
  String ?capacity;
  String ?description;
  String ?location;
  Null latitude;
  Null longitude;

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

class FiestaImages {
  int? id;
  String? image;
  int? fiestaId;

  FiestaImages({this.id, this.image, this.fiestaId});

  FiestaImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    fiestaId = json['fiesta_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['fiesta_id'] = this.fiestaId;
    return data;
  }
}
