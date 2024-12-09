class AppCredentialsMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<AppCredentialsData>? data;

  AppCredentialsMaster({this.status, this.statusCode, this.message, this.data});

  AppCredentialsMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AppCredentialsData>[];
      json['data'].forEach((v) {
        data!.add(AppCredentialsData.fromJson(v));
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

class AppCredentialsData {
  String? razorPayKey;
  String? razorPaySecret;
  String? mapKey;
  String? appName;
  String? appColor;

  AppCredentialsData(
      {this.razorPayKey,
      this.razorPaySecret,
      this.mapKey,
      this.appName,
      this.appColor});

  AppCredentialsData.fromJson(Map<String, dynamic> json) {
    razorPayKey = json['razzorpay_key'];
    razorPaySecret = json['razzorpay_secret'];
    mapKey = json['map_key'];
    appName = json['app_name'];
    appColor = json['app_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['razzorpay_key'] = razorPayKey;
    data['razzorpay_secret'] = razorPaySecret;
    data['map_key'] = mapKey;
    data['app_name'] = appName;
    data['app_color'] = appColor;
    return data;
  }
}
