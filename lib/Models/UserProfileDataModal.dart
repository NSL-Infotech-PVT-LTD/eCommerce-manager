class GetUserProfileModal {
  bool ?status;
  int ?code;
  Data ?data;

  GetUserProfileModal({this.status, this.code, this.data});

  GetUserProfileModal.fromJson(Map<String, dynamic> json) {
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
  String ?name;
  String ?email;
  String ?mobile;
  String ?gender;
  String ?dob;
  String ?status;
  String ?image;
  String? isNotify;
  String ?stripeAccountId;
  String? isAvailable;
  Role ?role;

  Data(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.gender,
        this.dob,
        this.status,
        this.image,
        this.isNotify,
        this.stripeAccountId,
        this.isAvailable,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    dob = json['dob'];
    status = json['status'];
    image = json['image'];
    isNotify = json['is_notify'];
    stripeAccountId = json['stripe_account_id'];
    isAvailable = json['is_available'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['status'] = this.status;
    data['image'] = this.image;
    data['is_notify'] = this.isNotify;
    data['stripe_account_id'] = this.stripeAccountId;
    data['is_available'] = this.isAvailable;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  String? name;
  int ?id;
  List<Null>? permission;

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
