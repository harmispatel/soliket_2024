class TransactionHistoryMaster {
  bool? status;
  int? statusCode;
  String? message;
  TransactionHistoryData? data;

  TransactionHistoryMaster(
      {this.status, this.statusCode, this.message, this.data});

  TransactionHistoryMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? TransactionHistoryData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? totalOrder;
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
