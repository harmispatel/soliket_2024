class AboutUsMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<AboutUsData>? _data;

  AboutUsMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<AboutUsData>? data}) {
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
  List<AboutUsData>? get data => _data;
  set data(List<AboutUsData>? data) => _data = data;

  AboutUsMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <AboutUsData>[];
      json['data'].forEach((v) {
        _data!.add(new AboutUsData.fromJson(v));
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

class AboutUsData {
  String? _title;
  String? _description;
  String? _image;

  AboutUsData({String? title, String? description, String? image}) {
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

  AboutUsData.fromJson(Map<String, dynamic> json) {
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
