class AppVersionMaster {
  bool? status;
  int? statusCode;
  String? message;
  AppVersionData? data;

  AppVersionMaster({this.status, this.statusCode, this.message, this.data});

  AppVersionMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? AppVersionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AppVersionData {
  String? appVersion;

  AppVersionData({this.appVersion});

  AppVersionData.fromJson(Map<String, dynamic> json) {
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_version'] = appVersion;
    return data;
  }
}
