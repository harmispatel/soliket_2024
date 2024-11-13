class PrivacyPolicyMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<PrivacyPolicyData>? data;

  PrivacyPolicyMaster({this.status, this.statusCode, this.message, this.data});

  PrivacyPolicyMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PrivacyPolicyData>[];
      json['data'].forEach((v) {
        data!.add(new PrivacyPolicyData.fromJson(v));
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

class PrivacyPolicyData {
  String? title;
  String? description;

  PrivacyPolicyData({this.title, this.description});

  PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
