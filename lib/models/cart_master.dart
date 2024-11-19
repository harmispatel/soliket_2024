import 'package:solikat_2024/models/search_master.dart';

class GetCartMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  Data? _data;

  GetCartMaster({bool? status, int? statusCode, String? message, Data? data}) {
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
  Data? get data => _data;
  set data(Data? data) => _data = data;

  GetCartMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<ProductData>? _cartItem;
  List<CartCouponData>? _coupon;
  CartTotal? _cartTotal;

  Data(
      {List<ProductData>? cartItem,
      List<CartCouponData>? coupon,
      CartTotal? cartTotal}) {
    if (cartItem != null) {
      this._cartItem = cartItem;
    }
    if (coupon != null) {
      this._coupon = coupon;
    }
    if (cartTotal != null) {
      this._cartTotal = cartTotal;
    }
  }

  List<ProductData>? get cartItem => _cartItem;
  set cartItem(List<ProductData>? cartItem) => _cartItem = cartItem;
  List<CartCouponData>? get coupon => _coupon;
  set coupon(List<CartCouponData>? coupon) => _coupon = coupon;
  CartTotal? get cartTotal => _cartTotal;
  set cartTotal(CartTotal? cartTotal) => _cartTotal = cartTotal;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_item'] != null) {
      _cartItem = <ProductData>[];
      json['cart_item'].forEach((v) {
        _cartItem!.add(new ProductData.fromJson(v));
      });
    }
    if (json['coupon'] != null) {
      _coupon = <CartCouponData>[];
      json['coupon'].forEach((v) {
        _coupon!.add(new CartCouponData.fromJson(v));
      });
    }
    _cartTotal = json['cart_total'] != null
        ? new CartTotal.fromJson(json['cart_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cartItem != null) {
      data['cart_item'] = this._cartItem!.map((v) => v.toJson()).toList();
    }
    if (this._coupon != null) {
      data['coupon'] = this._coupon!.map((v) => v.toJson()).toList();
    }
    if (this._cartTotal != null) {
      data['cart_total'] = this._cartTotal!.toJson();
    }
    return data;
  }
}

class CartCouponData {
  int? _couponId;
  String? _couponCode;
  String? _message;

  CartCouponData({int? couponId, String? couponCode, String? message}) {
    if (couponId != null) {
      this._couponId = couponId;
    }
    if (couponCode != null) {
      this._couponCode = couponCode;
    }
    if (message != null) {
      this._message = message;
    }
  }

  int? get couponId => _couponId;
  set couponId(int? couponId) => _couponId = couponId;
  String? get couponCode => _couponCode;
  set couponCode(String? couponCode) => _couponCode = couponCode;
  String? get message => _message;
  set message(String? message) => _message = message;

  CartCouponData.fromJson(Map<String, dynamic> json) {
    _couponId = json['coupon_id'];
    _couponCode = json['coupon_code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this._couponId;
    data['coupon_code'] = this._couponCode;
    data['message'] = this._message;
    return data;
  }
}

class CartTotal {
  String? _itemTotal;
  String? _deliveryCharge;
  String? _tax;
  String? _couponDiscount;
  String? _total;
  String? _savingAmount;

  CartTotal(
      {String? itemTotal,
      String? deliveryCharge,
      String? tax,
      String? couponDiscount,
      String? total,
      String? savingAmount}) {
    if (itemTotal != null) {
      this._itemTotal = itemTotal;
    }
    if (deliveryCharge != null) {
      this._deliveryCharge = deliveryCharge;
    }
    if (tax != null) {
      this._tax = tax;
    }
    if (couponDiscount != null) {
      this._couponDiscount = couponDiscount;
    }
    if (total != null) {
      this._total = total;
    }
    if (savingAmount != null) {
      this._savingAmount = savingAmount;
    }
  }

  String? get itemTotal => _itemTotal;
  set itemTotal(String? itemTotal) => _itemTotal = itemTotal;
  String? get deliveryCharge => _deliveryCharge;
  set deliveryCharge(String? deliveryCharge) =>
      _deliveryCharge = deliveryCharge;
  String? get tax => _tax;
  set tax(String? tax) => _tax = tax;
  String? get couponDiscount => _couponDiscount;
  set couponDiscount(String? couponDiscount) =>
      _couponDiscount = couponDiscount;
  String? get total => _total;
  set total(String? total) => _total = total;
  String? get savingAmount => _savingAmount;
  set savingAmount(String? savingAmount) => _savingAmount = savingAmount;

  CartTotal.fromJson(Map<String, dynamic> json) {
    _itemTotal = json['item_total'];
    _deliveryCharge = json['delivery_charge'];
    _tax = json['tax'];
    _couponDiscount = json['coupon_discount'];
    _total = json['total'];
    _savingAmount = json['saving_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_total'] = this._itemTotal;
    data['delivery_charge'] = this._deliveryCharge;
    data['tax'] = this._tax;
    data['coupon_discount'] = this._couponDiscount;
    data['total'] = this._total;
    data['saving_amount'] = this._savingAmount;
    return data;
  }
}
