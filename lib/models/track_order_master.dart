class TrackOrderMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<TrackOrderData>? _data;

  TrackOrderMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<TrackOrderData>? data}) {
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
  List<TrackOrderData>? get data => _data;
  set data(List<TrackOrderData>? data) => _data = data;

  TrackOrderMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <TrackOrderData>[];
      json['data'].forEach((v) {
        _data!.add(new TrackOrderData.fromJson(v));
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

class TrackOrderData {
  int? _orderId;
  String? _title;
  String? _subTitle;
  String? _orderNo;
  String? _riderName;
  String? _riderMobile;
  String? _orderDate;
  String? _orderStatus;
  String? _estimateTime;
  String? _fromLatitude;
  String? _fromLongitude;
  String? _toLatitude;
  String? _toLongitude;

  TrackOrderData(
      {int? orderId,
      String? title,
      String? subTitle,
      String? orderNo,
      String? riderName,
      String? riderMobile,
      String? orderDate,
      String? orderStatus,
      String? estimateTime,
      String? fromLatitude,
      String? fromLongitude,
      String? toLatitude,
      String? toLongitude}) {
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (title != null) {
      this._title = title;
    }
    if (subTitle != null) {
      this._subTitle = subTitle;
    }
    if (orderNo != null) {
      this._orderNo = orderNo;
    }
    if (riderName != null) {
      this._riderName = riderName;
    }
    if (riderMobile != null) {
      this._riderMobile = riderMobile;
    }
    if (orderDate != null) {
      this._orderDate = orderDate;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (estimateTime != null) {
      this._estimateTime = estimateTime;
    }
    if (fromLatitude != null) {
      this._fromLatitude = fromLatitude;
    }
    if (fromLongitude != null) {
      this._fromLongitude = fromLongitude;
    }
    if (toLatitude != null) {
      this._toLatitude = toLatitude;
    }
    if (toLongitude != null) {
      this._toLongitude = toLongitude;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get subTitle => _subTitle;
  set subTitle(String? subTitle) => _subTitle = subTitle;
  String? get orderNo => _orderNo;
  set orderNo(String? orderNo) => _orderNo = orderNo;
  String? get riderName => _riderName;
  set riderName(String? riderName) => _riderName = riderName;
  String? get riderMobile => _riderMobile;
  set riderMobile(String? riderMobile) => _riderMobile = riderMobile;
  String? get orderDate => _orderDate;
  set orderDate(String? orderDate) => _orderDate = orderDate;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get estimateTime => _estimateTime;
  set estimateTime(String? estimateTime) => _estimateTime = estimateTime;
  String? get fromLatitude => _fromLatitude;
  set fromLatitude(String? fromLatitude) => _fromLatitude = fromLatitude;
  String? get fromLongitude => _fromLongitude;
  set fromLongitude(String? fromLongitude) => _fromLongitude = fromLongitude;
  String? get toLatitude => _toLatitude;
  set toLatitude(String? toLatitude) => _toLatitude = toLatitude;
  String? get toLongitude => _toLongitude;
  set toLongitude(String? toLongitude) => _toLongitude = toLongitude;

  TrackOrderData.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _title = json['title'];
    _subTitle = json['sub_title'];
    _orderNo = json['order_no'];
    _riderName = json['rider_name'];
    _riderMobile = json['rider_mobile'];
    _orderDate = json['order_date'];
    _orderStatus = json['order_status'];
    _estimateTime = json['estimate_time'];
    _fromLatitude = json['from_latitude'];
    _fromLongitude = json['from_longitude'];
    _toLatitude = json['to_latitude'];
    _toLongitude = json['to_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    data['title'] = this._title;
    data['sub_title'] = this._subTitle;
    data['order_no'] = this._orderNo;
    data['rider_name'] = this._riderName;
    data['rider_mobile'] = this._riderMobile;
    data['order_date'] = this._orderDate;
    data['order_status'] = this._orderStatus;
    data['estimate_time'] = this._estimateTime;
    data['from_latitude'] = this._fromLatitude;
    data['from_longitude'] = this._fromLongitude;
    data['to_latitude'] = this._toLatitude;
    data['to_longitude'] = this._toLongitude;
    return data;
  }
}
