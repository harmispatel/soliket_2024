class AppCredensialsMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<AppCredensialsData>? data;

  AppCredensialsMaster({this.status, this.statusCode, this.message, this.data});

  AppCredensialsMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AppCredensialsData>[];
      json['data'].forEach((v) {
        data!.add(AppCredensialsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppCredensialsData {
  String? razzorpayKey;
  String? razzorpaySecret;
  String? mapKey;
  String? appName;
  String? appColor;

  AppCredensialsData(
      {this.razzorpayKey,
      this.razzorpaySecret,
      this.mapKey,
      this.appName,
      this.appColor});

  AppCredensialsData.fromJson(Map<String, dynamic> json) {
    razzorpayKey = json['razzorpay_key'];
    razzorpaySecret = json['razzorpay_secret'];
    mapKey = json['map_key'];
    appName = json['app_name'];
    appColor = json['app_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['razzorpay_key'] = razzorpayKey;
    data['razzorpay_secret'] = razzorpaySecret;
    data['map_key'] = mapKey;
    data['app_name'] = appName;
    data['app_color'] = appColor;
    return data;
  }
}
