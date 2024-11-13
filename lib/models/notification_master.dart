class NotificationMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<NotificationData>? data;

  NotificationMaster({this.status, this.statusCode, this.message, this.data});

  NotificationMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? title;
  String? description;
  String? time;

  NotificationData({this.title, this.description, this.time});

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['time'] = this.time;
    return data;
  }
}
