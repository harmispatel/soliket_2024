class OrderDetailsMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  OrderDetailsData? _data;

  OrderDetailsMaster(
      {bool? status,
      int? statusCode,
      String? message,
      OrderDetailsData? data}) {
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
  OrderDetailsData? get data => _data;
  set data(OrderDetailsData? data) => _data = data;

  OrderDetailsMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new OrderDetailsData.fromJson(json['data'])
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

class OrderDetailsData {
  List<OrderDetails>? _orderDetails;
  List<OrderItem>? _orderItem;
  List<BillDetails>? _billDetails;

  OrderDetailsData(
      {List<OrderDetails>? orderDetails,
      List<OrderItem>? orderItem,
      List<BillDetails>? billDetails}) {
    if (orderDetails != null) {
      this._orderDetails = orderDetails;
    }
    if (orderItem != null) {
      this._orderItem = orderItem;
    }
    if (billDetails != null) {
      this._billDetails = billDetails;
    }
  }

  List<OrderDetails>? get orderDetails => _orderDetails;
  set orderDetails(List<OrderDetails>? orderDetails) =>
      _orderDetails = orderDetails;
  List<OrderItem>? get orderItem => _orderItem;
  set orderItem(List<OrderItem>? orderItem) => _orderItem = orderItem;
  List<BillDetails>? get billDetails => _billDetails;
  set billDetails(List<BillDetails>? billDetails) => _billDetails = billDetails;

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      _orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        _orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    if (json['order_item'] != null) {
      _orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        _orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    if (json['bill_details'] != null) {
      _billDetails = <BillDetails>[];
      json['bill_details'].forEach((v) {
        _billDetails!.add(new BillDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._orderDetails != null) {
      data['order_details'] =
          this._orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this._orderItem != null) {
      data['order_item'] = this._orderItem!.map((v) => v.toJson()).toList();
    }
    if (this._billDetails != null) {
      data['bill_details'] = this._billDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? _orderId;
  String? _riderName;
  String? _deliveryLocation;
  String? _orderNo;
  String? _orderDate;
  String? _orderStatus;
  String? _estimateTime;
  String? _paymentMethod;

  OrderDetails(
      {int? orderId,
      String? riderName,
      String? deliveryLocation,
      String? orderNo,
      String? orderDate,
      String? orderStatus,
      String? estimateTime,
      String? paymentMethod}) {
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (riderName != null) {
      this._riderName = riderName;
    }
    if (deliveryLocation != null) {
      this._deliveryLocation = deliveryLocation;
    }
    if (orderNo != null) {
      this._orderNo = orderNo;
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
    if (paymentMethod != null) {
      this._paymentMethod = paymentMethod;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  String? get riderName => _riderName;
  set riderName(String? riderName) => _riderName = riderName;
  String? get deliveryLocation => _deliveryLocation;
  set deliveryLocation(String? deliveryLocation) =>
      _deliveryLocation = deliveryLocation;
  String? get orderNo => _orderNo;
  set orderNo(String? orderNo) => _orderNo = orderNo;
  String? get orderDate => _orderDate;
  set orderDate(String? orderDate) => _orderDate = orderDate;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get estimateTime => _estimateTime;
  set estimateTime(String? estimateTime) => _estimateTime = estimateTime;
  String? get paymentMethod => _paymentMethod;
  set paymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _riderName = json['rider_name'];
    _deliveryLocation = json['delivery_location'];
    _orderNo = json['order_no'];
    _orderDate = json['order_date'];
    _orderStatus = json['order_status'];
    _estimateTime = json['estimate_time'];
    _paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    data['rider_name'] = this._riderName;
    data['delivery_location'] = this._deliveryLocation;
    data['order_no'] = this._orderNo;
    data['order_date'] = this._orderDate;
    data['order_status'] = this._orderStatus;
    data['estimate_time'] = this._estimateTime;
    data['payment_method'] = this._paymentMethod;
    return data;
  }
}

class OrderItem {
  String? _productName;
  int? _qty;
  int? _price;
  int? _discountedPrice;
  String? _image;

  OrderItem(
      {String? productName,
      int? qty,
      int? price,
      int? discountedPrice,
      String? image}) {
    if (productName != null) {
      this._productName = productName;
    }
    if (qty != null) {
      this._qty = qty;
    }
    if (price != null) {
      this._price = price;
    }
    if (discountedPrice != null) {
      this._discountedPrice = discountedPrice;
    }
    if (image != null) {
      this._image = image;
    }
  }

  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get qty => _qty;
  set qty(int? qty) => _qty = qty;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get discountedPrice => _discountedPrice;
  set discountedPrice(int? discountedPrice) =>
      _discountedPrice = discountedPrice;
  String? get image => _image;
  set image(String? image) => _image = image;

  OrderItem.fromJson(Map<String, dynamic> json) {
    _productName = json['product_name'];
    _qty = json['qty'];
    _price = json['price'];
    _discountedPrice = json['discounted_price'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this._productName;
    data['qty'] = this._qty;
    data['price'] = this._price;
    data['discounted_price'] = this._discountedPrice;
    data['image'] = this._image;
    return data;
  }
}

class BillDetails {
  int? _itemTotal;
  int? _deliveryCharge;
  int? _tax;
  int? _offerDiscount;
  String? _savingAmount;
  int? _toPaid;

  BillDetails(
      {int? itemTotal,
      int? deliveryCharge,
      int? tax,
      int? offerDiscount,
      String? savingAmount,
      int? toPaid}) {
    if (itemTotal != null) {
      this._itemTotal = itemTotal;
    }
    if (deliveryCharge != null) {
      this._deliveryCharge = deliveryCharge;
    }
    if (tax != null) {
      this._tax = tax;
    }
    if (offerDiscount != null) {
      this._offerDiscount = offerDiscount;
    }
    if (savingAmount != null) {
      this._savingAmount = savingAmount;
    }
    if (toPaid != null) {
      this._toPaid = toPaid;
    }
  }

  int? get itemTotal => _itemTotal;
  set itemTotal(int? itemTotal) => _itemTotal = itemTotal;
  int? get deliveryCharge => _deliveryCharge;
  set deliveryCharge(int? deliveryCharge) => _deliveryCharge = deliveryCharge;
  int? get tax => _tax;
  set tax(int? tax) => _tax = tax;
  int? get offerDiscount => _offerDiscount;
  set offerDiscount(int? offerDiscount) => _offerDiscount = offerDiscount;
  String? get savingAmount => _savingAmount;
  set savingAmount(String? savingAmount) => _savingAmount = savingAmount;
  int? get toPaid => _toPaid;
  set toPaid(int? toPaid) => _toPaid = toPaid;

  BillDetails.fromJson(Map<String, dynamic> json) {
    _itemTotal = json['item_total'];
    _deliveryCharge = json['delivery_charge'];
    _tax = json['tax'];
    _offerDiscount = json['offer_discount'];
    _savingAmount = json['saving_amount'];
    _toPaid = json['to_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_total'] = this._itemTotal;
    data['delivery_charge'] = this._deliveryCharge;
    data['tax'] = this._tax;
    data['offer_discount'] = this._offerDiscount;
    data['saving_amount'] = this._savingAmount;
    data['to_paid'] = this._toPaid;
    return data;
  }
}
