class GetStripeDataModal {
  bool? status;
  int? code;
  Data? data;

  GetStripeDataModal({this.status, this.code, this.data});

  GetStripeDataModal.fromJson(Map<String, dynamic> json) {
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
  String? publicKey;
  String? currency;
  String? currencySymbol;
  String? seceretKey;
  String? clientId;
  String? stripeConnect;

  Data(
      {this.publicKey,
      this.currency,
      this.currencySymbol,
      this.seceretKey,
      this.clientId,
      this.stripeConnect});

  Data.fromJson(Map<String, dynamic> json) {
    publicKey = json['public_key'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    seceretKey = json['seceret_key'];
    clientId = json['client_id'];
    stripeConnect = json['stripe_connect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_key'] = this.publicKey;
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currencySymbol;
    data['seceret_key'] = this.seceretKey;
    data['client_id'] = this.clientId;
    data['stripe_connect'] = this.stripeConnect;
    return data;
  }
}
