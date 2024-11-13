class TermsAndConditionsMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<TermsAndConditionsData>? data;

  TermsAndConditionsMaster(
      {this.status, this.statusCode, this.message, this.data});

  TermsAndConditionsMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TermsAndConditionsData>[];
      json['data'].forEach((v) {
        data!.add(TermsAndConditionsData.fromJson(v));
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

class TermsAndConditionsData {
  String? title;
  String? description;

  TermsAndConditionsData({this.title, this.description});

  TermsAndConditionsData.fromJson(Map<String, dynamic> json) {
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
