class ReturnPolicyMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<ReturnPolicyData>? data;

  ReturnPolicyMaster({this.status, this.statusCode, this.message, this.data});

  ReturnPolicyMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReturnPolicyData>[];
      json['data'].forEach(
        (v) {
          data!.add(ReturnPolicyData.fromJson(v));
        },
      );
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

class ReturnPolicyData {
  String? title;
  String? description;

  ReturnPolicyData({this.title, this.description});

  ReturnPolicyData.fromJson(Map<String, dynamic> json) {
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
