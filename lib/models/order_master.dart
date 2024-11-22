class OrderMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  OrderData? _data;

  OrderMaster(
      {bool? status, int? statusCode, String? message, OrderData? data}) {
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
  OrderData? get data => _data;
  set data(OrderData? data) => _data = data;

  OrderMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
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

class OrderData {
  String? _orderId;

  OrderData({String? orderId}) {
    if (orderId != null) {
      this._orderId = orderId;
    }
  }

  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;

  OrderData.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    return data;
  }
}
