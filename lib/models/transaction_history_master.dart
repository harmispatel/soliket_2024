class TransactionHistoryMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  TransactionHistoryData? _data;

  TransactionHistoryMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      TransactionHistoryData? data}) {
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
  TransactionHistoryData? get data => _data;
  set data(TransactionHistoryData? data) => _data = data;

  TransactionHistoryMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    _data = json['data'] != null
        ? new TransactionHistoryData.fromJson(json['data'])
        : null;
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
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class TransactionHistoryData {
  List<Total>? total;
  List<TransactionList>? list;

  TransactionHistoryData({this.total, this.list});

  TransactionHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['total'] != null) {
      total = <Total>[];
      json['total'].forEach((v) {
        total!.add(Total.fromJson(v));
      });
    }
    if (json['list'] != null) {
      list = <TransactionList>[];
      json['list'].forEach((v) {
        list!.add(TransactionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (total != null) {
      data['total'] = total!.map((v) => v.toJson()).toList();
    }
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Total {
  int? totalOrder;
  String? totalAmount;

  Total({this.totalOrder, this.totalAmount});

  Total.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_order'] = totalOrder;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class TransactionList {
  String? date;
  String? paymentMethod;
  String? amount;
  String? orderId;

  TransactionList({this.date, this.paymentMethod, this.amount, this.orderId});

  TransactionList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['order_id'] = orderId;
    return data;
  }
}
