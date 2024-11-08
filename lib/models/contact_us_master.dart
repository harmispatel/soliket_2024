class ContactMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<ContactUsData>? _data;

  ContactMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<ContactUsData>? data}) {
    if (status != null) {
      this._status = status;
    }
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get status => _status;
  set status(bool? status) => _status = status;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  String? get message => _message;
  set message(String? message) => _message = message;
  List<ContactUsData>? get data => _data;
  set data(List<ContactUsData>? data) => _data = data;

  ContactMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <ContactUsData>[];
      json['data'].forEach((v) {
        _data!.add(new ContactUsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['status_code'] = this._statusCode;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactUsData {
  String? _title;
  String? _description;
  String? _image;

  ContactUsData({String? title, String? description, String? image}) {
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (image != null) {
      this._image = image;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get image => _image;
  set image(String? image) => _image = image;

  ContactUsData.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['description'] = this._description;
    data['image'] = this._image;
    return data;
  }
}
