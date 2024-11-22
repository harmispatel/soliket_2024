class CheckDeliveryAvailableMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  CheckDeliveryData? _data;

  CheckDeliveryAvailableMaster(
      {bool? status,
      int? statusCode,
      String? message,
      CheckDeliveryData? data}) {
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
  CheckDeliveryData? get data => _data;
  set data(CheckDeliveryData? data) => _data = data;

  CheckDeliveryAvailableMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new CheckDeliveryData.fromJson(json['data'])
        : null;
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

class CheckDeliveryData {
  String? _discountAmount;
  String? _itemTotal;
  String? _deliveryCharge;
  String? _tax;
  String? _couponDiscount;
  String? _total;
  String? _savingAmount;
  String? _isFreeDelivery;

  CheckDeliveryData(
      {String? discountAmount,
      String? itemTotal,
      String? deliveryCharge,
      String? tax,
      String? couponDiscount,
      String? total,
      String? savingAmount,
      String? isFreeDelivery}) {
    if (discountAmount != null) {
      this._discountAmount = discountAmount;
    }
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
    if (isFreeDelivery != null) {
      this._isFreeDelivery = isFreeDelivery;
    }
  }

  String? get discountAmount => _discountAmount;
  set discountAmount(String? discountAmount) =>
      _discountAmount = discountAmount;
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
  String? get isFreeDelivery => _isFreeDelivery;
  set isFreeDelivery(String? isFreeDelivery) =>
      _isFreeDelivery = isFreeDelivery;

  CheckDeliveryData.fromJson(Map<String, dynamic> json) {
    _discountAmount = json['discount_amount'];
    _itemTotal = json['item_total'];
    _deliveryCharge = json['delivery_charge'];
    _tax = json['tax'];
    _couponDiscount = json['coupon_discount'];
    _total = json['total'];
    _savingAmount = json['saving_amount'];
    _isFreeDelivery = json['is_free_delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_amount'] = this._discountAmount;
    data['item_total'] = this._itemTotal;
    data['delivery_charge'] = this._deliveryCharge;
    data['tax'] = this._tax;
    data['coupon_discount'] = this._couponDiscount;
    data['total'] = this._total;
    data['saving_amount'] = this._savingAmount;
    data['is_free_delivery'] = this._isFreeDelivery;
    return data;
  }
}
