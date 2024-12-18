class GetCheckOutDetailsMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  GetCheckOutDetailsData? _data;

  GetCheckOutDetailsMaster(
      {bool? status,
      int? statusCode,
      String? message,
      GetCheckOutDetailsData? data}) {
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
  GetCheckOutDetailsData? get data => _data;
  set data(GetCheckOutDetailsData? data) => _data = data;

  GetCheckOutDetailsMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new GetCheckOutDetailsData.fromJson(json['data'])
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

class GetCheckOutDetailsData {
  String? _isErrorMsg;
  CustomerAddress? _customerAddress;
  PaymentMethod? _paymentMethod;
  CartTotal? _cartTotal;

  GetCheckOutDetailsData(
      {String? isErrorMsg,
      CustomerAddress? customerAddress,
      PaymentMethod? paymentMethod,
      CartTotal? cartTotal}) {
    if (isErrorMsg != null) {
      this._isErrorMsg = isErrorMsg;
    }
    if (customerAddress != null) {
      this._customerAddress = customerAddress;
    }
    if (paymentMethod != null) {
      this._paymentMethod = paymentMethod;
    }
    if (cartTotal != null) {
      this._cartTotal = cartTotal;
    }
  }

  String? get isErrorMsg => _isErrorMsg;
  set isErrorMsg(String? isErrorMsg) => _isErrorMsg = isErrorMsg;
  CustomerAddress? get customerAddress => _customerAddress;
  set customerAddress(CustomerAddress? customerAddress) =>
      _customerAddress = customerAddress;
  PaymentMethod? get paymentMethod => _paymentMethod;
  set paymentMethod(PaymentMethod? paymentMethod) =>
      _paymentMethod = paymentMethod;
  CartTotal? get cartTotal => _cartTotal;
  set cartTotal(CartTotal? cartTotal) => _cartTotal = cartTotal;

  GetCheckOutDetailsData.fromJson(Map<String, dynamic> json) {
    _isErrorMsg = json['is_error_msg'];
    _customerAddress = json['customer_address'] != null
        ? new CustomerAddress.fromJson(json['customer_address'])
        : null;
    _paymentMethod = json['payment_method'] != null
        ? new PaymentMethod.fromJson(json['payment_method'])
        : null;
    _cartTotal = json['cart_total'] != null
        ? new CartTotal.fromJson(json['cart_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error_msg'] = this._isErrorMsg;
    if (this._customerAddress != null) {
      data['customer_address'] = this._customerAddress!.toJson();
    }
    if (this._paymentMethod != null) {
      data['payment_method'] = this._paymentMethod!.toJson();
    }
    if (this._cartTotal != null) {
      data['cart_total'] = this._cartTotal!.toJson();
    }
    return data;
  }
}

class CustomerAddress {
  int? _addressId;
  String? _type;
  String? _address;
  String? _mobile;

  CustomerAddress(
      {int? addressId, String? type, String? address, String? mobile}) {
    if (addressId != null) {
      this._addressId = addressId;
    }
    if (type != null) {
      this._type = type;
    }
    if (address != null) {
      this._address = address;
    }
    if (mobile != null) {
      this._mobile = mobile;
    }
  }

  int? get addressId => _addressId;
  set addressId(int? addressId) => _addressId = addressId;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    _addressId = json['address_id'];
    _type = json['type'];
    _address = json['address'];
    _mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this._addressId;
    data['type'] = this._type;
    data['address'] = this._address;
    data['mobile'] = this._mobile;
    return data;
  }
}

class PaymentMethod {
  String? _cod;
  String? _razorpay;

  PaymentMethod({String? cod, String? razorpay}) {
    if (cod != null) {
      this._cod = cod;
    }
    if (razorpay != null) {
      this._razorpay = razorpay;
    }
  }

  String? get cod => _cod;
  set cod(String? cod) => _cod = cod;
  String? get razorpay => _razorpay;
  set razorpay(String? razorpay) => _razorpay = razorpay;

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    _cod = json['cod'];
    _razorpay = json['razorpay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this._cod;
    data['razorpay'] = this._razorpay;
    return data;
  }
}

class CartTotal {
  String? _discountAmount;
  String? _itemTotal;
  String? _deliveryCharge;
  String? _tax;
  String? _couponDiscount;
  String? _total;
  String? _savingAmount;
  String? _isFreeDelivery;

  CartTotal(
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

  CartTotal.fromJson(Map<String, dynamic> json) {
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
