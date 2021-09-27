class LoginModel {
  bool? status;
  int? code;
  Data? data;

  LoginModel({this.status, this.code, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? token;
  User? user;

  Data({this.message, this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? isClubAdmin;
  String? mobile;
  String? email;
  String? gender;
  String? image;
  String? dob;
  String? radius;
  String? isAvailable;
  String? appleId;
  String? fbId;
  String? googleId;
  String? isNotify;
  String? stripeAccountId;
  String? params;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? stripeId;
  String? cardBrand;
  String? cardLastFour;
  String? trialEndsAt;
  Role? role;

  User(
      {this.id,
      this.name,
      this.isClubAdmin,
      this.mobile,
      this.email,
      this.gender,
      this.image,
      this.dob,
      this.radius,
      this.isAvailable,
      this.appleId,
      this.fbId,
      this.googleId,
      this.isNotify,
      this.stripeAccountId,
      this.params,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isClubAdmin = json['is_clubAdmin'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    dob = json['dob'];
    radius = json['radius'];
    isAvailable = json['is_available'];
    appleId = json['apple_id'];
    fbId = json['fb_id'];
    googleId = json['google_id'];
    isNotify = json['is_notify'];
    stripeAccountId = json['stripe_account_id'];
    params = json['params'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_clubAdmin'] = this.isClubAdmin;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['dob'] = this.dob;
    data['radius'] = this.radius;
    data['is_available'] = this.isAvailable;
    data['apple_id'] = this.appleId;
    data['fb_id'] = this.fbId;
    data['google_id'] = this.googleId;
    data['is_notify'] = this.isNotify;
    data['stripe_account_id'] = this.stripeAccountId;
    data['params'] = this.params;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  String? name;
  int? id;
  // List<Null>? permission;

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
    //   data['permission'] = this.permission.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
