class GetOrderMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  List<GetOrderData>? _data;

  GetOrderMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      List<GetOrderData>? data}) {
    if (status != null) {
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
    if (currentPage != null) {
      this._currentPage = currentPage;
    }
    if (totalPage != null) {
      this._totalPage = totalPage;
    }
    if (totalRecords != null) {
      this._totalRecords = totalRecords;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  String? get currentPage => _currentPage;
  set currentPage(String? currentPage) => _currentPage = currentPage;
  int? get totalPage => _totalPage;
  set totalPage(int? totalPage) => _totalPage = totalPage;
  int? get totalRecords => _totalRecords;
  set totalRecords(int? totalRecords) => _totalRecords = totalRecords;
  List<GetOrderData>? get data => _data;
  set data(List<GetOrderData>? data) => _data = data;

  GetOrderMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    if (json['data'] != null) {
      _data = <GetOrderData>[];
      json['data'].forEach((v) {
        _data!.add(new GetOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    data['status_code'] = this._statusCode;
    data['current_page'] = this._currentPage;
    data['total_page'] = this._totalPage;
    data['total_records'] = this._totalRecords;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOrderData {
  int? _orderId;
  String? _paymentMethod;
  String? _orderNumber;
  int? _total;
  String? _orderStatus;
  String? _created;

  GetOrderData(
      {int? orderId,
      String? paymentMethod,
      String? orderNumber,
      int? total,
      String? orderStatus,
      String? created}) {
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (paymentMethod != null) {
      this._paymentMethod = paymentMethod;
    }
    if (orderNumber != null) {
      this._orderNumber = orderNumber;
    }
    if (total != null) {
      this._total = total;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (created != null) {
      this._created = created;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  String? get paymentMethod => _paymentMethod;
  set paymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;
  String? get orderNumber => _orderNumber;
  set orderNumber(String? orderNumber) => _orderNumber = orderNumber;
  int? get total => _total;
  set total(int? total) => _total = total;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get created => _created;
  set created(String? created) => _created = created;

  GetOrderData.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _paymentMethod = json['payment_method'];
    _orderNumber = json['order_number'];
    _total = json['total'];
    _orderStatus = json['order_status'];
    _created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    data['payment_method'] = this._paymentMethod;
    data['order_number'] = this._orderNumber;
    data['total'] = this._total;
    data['order_status'] = this._orderStatus;
    data['created'] = this._created;
    return data;
  }
}
