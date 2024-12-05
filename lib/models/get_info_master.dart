class getInfoMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<GetInfoData>? _data;

  getInfoMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<GetInfoData>? data}) {
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
  List<GetInfoData>? get data => _data;
  set data(List<GetInfoData>? data) => _data = data;

  getInfoMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <GetInfoData>[];
      json['data'].forEach((v) {
        _data!.add(new GetInfoData.fromJson(v));
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

class GetInfoData {
  String? _title;
  String? _isContent;
  String? _description;
  String? _image;
  String? _isEnabled;

  GetInfoData({
    String? title,
    String? isContent,
    String? description,
    String? image,
    String? isEnabled,
  }) {
    if (title != null) {
      this._title = title;
    }
    if (isContent != null) {
      this._isContent = isContent;
    }
    if (description != null) {
      this._description = description;
    }
    if (image != null) {
      this._image = image;
    }
    if (isEnabled != null) {
      this._isEnabled = isEnabled;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get isContent => _isContent;
  set isContent(String? isContent) => _isContent = isContent;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get isEnabled => _isEnabled;
  set isEnabled(String? image) => _isEnabled = image;

  GetInfoData.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _isContent = json['is_content'];
    _description = json['description'];
    _image = json['image'];
    isEnabled = json['is_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['is_content'] = this._isContent;
    data['description'] = this._description;
    data['image'] = this._image;
    return data;
  }
}
