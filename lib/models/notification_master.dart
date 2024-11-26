class NotificationMaster {
  bool? status;
  String? message;
  int? statusCode;
  String? currentPage;
  int? totalPage;
  int? totalRecords;
  List<NotificationData>? data;

  NotificationMaster(
      {this.status,
      this.message,
      this.statusCode,
      this.currentPage,
      this.totalPage,
      this.totalRecords,
      this.data});

  NotificationMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
    totalRecords = json['total_records'];
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
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    data['total_records'] = this.totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? description;
  String? time;
  String? isRead;

  NotificationData(
      {this.id, this.title, this.description, this.time, this.isRead});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['time'] = this.time;
    data['is_read'] = this.isRead;
    return data;
  }
}
