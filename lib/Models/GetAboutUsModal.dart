class GetAboutUsModal {
  bool ?status;
  int ?code;
  Data ?data;

  GetAboutUsModal({this.status, this.code, this.data});

  GetAboutUsModal.fromJson(Map<String, dynamic> json) {
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
  String ?config;

  Data({this.config});

  Data.fromJson(Map<String, dynamic> json) {
    config = json['config'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config;
    return data;
  }
}
