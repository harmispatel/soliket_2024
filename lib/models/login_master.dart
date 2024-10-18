class LoginMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  LoginData? _data;

  LoginMaster(
      {bool? status, int? statusCode, String? message, LoginData? data}) {
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
  LoginData? get data => _data;
  set data(LoginData? data) => _data = data;

  LoginMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['status_code'] = this._statusCode;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class LoginData {
  int? _userId;
  String? _mobileNo;

  LoginData({int? userId, String? mobileNo}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (mobileNo != null) {
      this._mobileNo = mobileNo;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get mobileNo => _mobileNo;
  set mobileNo(String? mobileNo) => _mobileNo = mobileNo;

  LoginData.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['mobile_no'] = this._mobileNo;
    return data;
  }
}
