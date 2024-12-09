import 'package:solikat_2024/models/product_master.dart';

class AddToCartMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  CartData? _data;

  AddToCartMaster(
      {bool? status, int? statusCode, String? message, CartData? data}) {
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
  CartData? get data => _data;
  set data(CartData? data) => _data = data;

  AddToCartMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
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

class CartData {
  CartTotalData? _total;
  List<ProductData>? _product;

  CartData({CartTotalData? total, List<ProductData>? product}) {
    if (total != null) {
      this._total = total;
    }
    if (product != null) {
      this._product = product;
    }
  }

  CartTotalData? get total => _total;
  set total(CartTotalData? total) => _total = total;
  List<ProductData>? get product => _product;
  set product(List<ProductData>? product) => _product = product;

  CartData.fromJson(Map<String, dynamic> json) {
    _total = json['total'] != null
        ? new CartTotalData.fromJson(json['total'])
        : null;
    if (json['product'] != null) {
      _product = <ProductData>[];
      json['product'].forEach((v) {
        _product!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._total != null) {
      data['total'] = this._total!.toJson();
    }
    if (this._product != null) {
      data['product'] = this._product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartTotalData {
  int? _totalItem;
  String? _totalAmount;

  CartTotalData({int? totalItem, String? totalAmount}) {
    if (totalItem != null) {
      this._totalItem = totalItem;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
  }

  int? get totalItem => _totalItem;
  set totalItem(int? totalItem) => _totalItem = totalItem;
  String? get totalAmount => _totalAmount;
  set totalAmount(String? totalAmount) => _totalAmount = totalAmount;

  CartTotalData.fromJson(Map<String, dynamic> json) {
    _totalItem = json['total_item'];
    _totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_item'] = this._totalItem;
    data['total_amount'] = this._totalAmount;
    return data;
  }
}
