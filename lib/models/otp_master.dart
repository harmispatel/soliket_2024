class OtpMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  OtpData? _data;

  OtpMaster({bool? status, int? statusCode, String? message, OtpData? data}) {
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
  OtpData? get data => _data;
  set data(OtpData? data) => _data = data;

  OtpMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? new OtpData.fromJson(json['data']) : null;
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

class OtpData {
  String? _userId;
  String? _name;
  String? _email;
  String? _mobile;
  String? _birthday;
  String? _profile;
  String? _isProfileComplete;
  String? _token;

  OtpData(
      {String? userId,
      String? name,
      String? email,
      String? mobile,
      String? birthday,
      String? profile,
      String? isProfileComplete,
      String? token}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (mobile != null) {
      this._mobile = mobile;
    }
    if (birthday != null) {
      this._birthday = birthday;
    }
    if (profile != null) {
      this._profile = profile;
    }
    if (isProfileComplete != null) {
      this._isProfileComplete = isProfileComplete;
    }
    if (token != null) {
      this._token = token;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;
  String? get birthday => _birthday;
  set birthday(String? birthday) => _birthday = birthday;
  String? get profile => _profile;
  set profile(String? profile) => _profile = profile;
  String? get isProfileComplete => _isProfileComplete;
  set isProfileComplete(String? isProfileComplete) =>
      _isProfileComplete = isProfileComplete;
  String? get token => _token;
  set token(String? token) => _token = token;

  OtpData.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _birthday = json['birthday'];
    _profile = json['profile'];
    _isProfileComplete = json['is_profile_complete'];
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['email'] = this._email;
    data['mobile'] = this._mobile;
    data['birthday'] = this._birthday;
    data['profile'] = this._profile;
    data['is_profile_complete'] = this._isProfileComplete;
    data['token'] = this._token;
    return data;
  }
}
