class FaqMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<FaqData>? _data;

  FaqMaster(
      {bool? status, int? statusCode, String? message, List<FaqData>? data}) {
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
  List<FaqData>? get data => _data;
  set data(List<FaqData>? data) => _data = data;

  FaqMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <FaqData>[];
      json['data'].forEach((v) {
        _data!.add(new FaqData.fromJson(v));
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

class FaqData {
  int? _id;
  String? _qtn;
  String? _answer;

  FaqData({int? id, String? qtn, String? answer}) {
    if (id != null) {
      this._id = id;
    }
    if (qtn != null) {
      this._qtn = qtn;
    }
    if (answer != null) {
      this._answer = answer;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get qtn => _qtn;
  set qtn(String? qtn) => _qtn = qtn;
  String? get answer => _answer;
  set answer(String? answer) => _answer = answer;

  FaqData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _qtn = json['qtn'];
    _answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['qtn'] = this._qtn;
    data['answer'] = this._answer;
    return data;
  }
}
