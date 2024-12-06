// import 'package:solikat_2024/models/search_master.dart';
//
// class GetCartMaster {
//   bool? _status;
//   int? _statusCode;
//   String? _message;
//   CartData? _data;
//
//   GetCartMaster(
//       {bool? status, int? statusCode, String? message, CartData? data}) {
//     if (status != null) {
//       this._status = status;
//     }
//     if (statusCode != null) {
//       this._statusCode = statusCode;
//     }
//     if (message != null) {
//       this._message = message;
//     }
//     if (data != null) {
//       this._data = data;
//     }
//   }
//
//   bool? get status => _status;
//
//   set status(bool? status) => _status = status;
//
//   int? get statusCode => _statusCode;
//
//   set statusCode(int? statusCode) => _statusCode = statusCode;
//
//   String? get message => _message;
//
//   set message(String? message) => _message = message;
//
//   CartData? get data => _data;
//
//   set data(CartData? data) => _data = data;
//
//   GetCartMaster.fromJson(Map<String, dynamic> json) {
//     _status = json['status'];
//     _statusCode = json['status_code'];
//     _message = json['message'];
//     _data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this._status;
//     data['status_code'] = this._statusCode;
//     data['message'] = this._message;
//     if (this._data != null) {
//       data['data'] = this._data!.toJson();
//     }
//     return data;
//   }
// }
//
// class CartData {
//   List<ProductData>? _cartItem;
//   List<CartCouponData>? _coupon;
//   CartTotal? _cartTotal;
//
//   CartData(
//       {List<ProductData>? cartItem,
//       List<CartCouponData>? coupon,
//       CartTotal? cartTotal}) {
//     if (cartItem != null) {
//       this._cartItem = cartItem;
//     }
//     if (coupon != null) {
//       this._coupon = coupon;
//     }
//     if (cartTotal != null) {
//       this._cartTotal = cartTotal;
//     }
//   }
//
//   List<ProductData>? get cartItem => _cartItem;
//
//   set cartItem(List<ProductData>? cartItem) => _cartItem = cartItem;
//
//   List<CartCouponData>? get coupon => _coupon;
//
//   set coupon(List<CartCouponData>? coupon) => _coupon = coupon;
//
//   CartTotal? get cartTotal => _cartTotal;
//
//   set cartTotal(CartTotal? cartTotal) => _cartTotal = cartTotal;
//
//   CartData.fromJson(Map<String, dynamic> json) {
//     if (json['cart_item'] != null) {
//       _cartItem = <ProductData>[];
//       json['cart_item'].forEach((v) {
//         _cartItem!.add(new ProductData.fromJson(v));
//       });
//     }
//     if (json['coupon'] != null) {
//       _coupon = <CartCouponData>[];
//       json['coupon'].forEach((v) {
//         _coupon!.add(new CartCouponData.fromJson(v));
//       });
//     }
//     _cartTotal = json['cart_total'] != null
//         ? new CartTotal.fromJson(json['cart_total'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this._cartItem != null) {
//       data['cart_item'] = this._cartItem!.map((v) => v.toJson()).toList();
//     }
//     if (this._coupon != null) {
//       data['coupon'] = this._coupon!.map((v) => v.toJson()).toList();
//     }
//     if (this._cartTotal != null) {
//       data['cart_total'] = this._cartTotal!.toJson();
//     }
//     return data;
//   }
// }
//
// class CartCouponData {
//   int? _couponId;
//   String? _couponCode;
//   String? _message;
//
//   CartCouponData({int? couponId, String? couponCode, String? message}) {
//     if (couponId != null) {
//       this._couponId = couponId;
//     }
//     if (couponCode != null) {
//       this._couponCode = couponCode;
//     }
//     if (message != null) {
//       this._message = message;
//     }
//   }
//
//   int? get couponId => _couponId;
//
//   set couponId(int? couponId) => _couponId = couponId;
//
//   String? get couponCode => _couponCode;
//
//   set couponCode(String? couponCode) => _couponCode = couponCode;
//
//   String? get message => _message;
//
//   set message(String? message) => _message = message;
//
//   CartCouponData.fromJson(Map<String, dynamic> json) {
//     _couponId = json['coupon_id'];
//     _couponCode = json['coupon_code'];
//     _message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['coupon_id'] = this._couponId;
//     data['coupon_code'] = this._couponCode;
//     data['message'] = this._message;
//     return data;
//   }
// }
//
// class CartTotal {
//   String? _discountAmount;
//   String? _itemTotal;
//   String? _deliveryCharge;
//   String? _tax;
//   String? _couponDiscount;
//   String? _total;
//   String? _savingAmount;
//   String? _isFreeDelivery;
//
//   CartTotal(
//       {String? discountAmount,
//       String? itemTotal,
//       String? deliveryCharge,
//       String? tax,
//       String? couponDiscount,
//       String? total,
//       String? savingAmount,
//       String? isFreeDelivery}) {
//     if (discountAmount != null) {
//       this._discountAmount = discountAmount;
//     }
//     if (itemTotal != null) {
//       this._itemTotal = itemTotal;
//     }
//     if (deliveryCharge != null) {
//       this._deliveryCharge = deliveryCharge;
//     }
//     if (tax != null) {
//       this._tax = tax;
//     }
//     if (couponDiscount != null) {
//       this._couponDiscount = couponDiscount;
//     }
//     if (total != null) {
//       this._total = total;
//     }
//     if (savingAmount != null) {
//       this._savingAmount = savingAmount;
//     }
//     if (isFreeDelivery != null) {
//       this._isFreeDelivery = isFreeDelivery;
//     }
//   }
//
//   String? get discountAmount => _discountAmount;
//
//   set discountAmount(String? discountAmount) =>
//       _discountAmount = discountAmount;
//
//   String? get itemTotal => _itemTotal;
//
//   set itemTotal(String? itemTotal) => _itemTotal = itemTotal;
//
//   String? get deliveryCharge => _deliveryCharge;
//
//   set deliveryCharge(String? deliveryCharge) =>
//       _deliveryCharge = deliveryCharge;
//
//   String? get tax => _tax;
//
//   set tax(String? tax) => _tax = tax;
//
//   String? get couponDiscount => _couponDiscount;
//
//   set couponDiscount(String? couponDiscount) =>
//       _couponDiscount = couponDiscount;
//
//   String? get total => _total;
//
//   set total(String? total) => _total = total;
//
//   String? get savingAmount => _savingAmount;
//
//   set savingAmount(String? savingAmount) => _savingAmount = savingAmount;
//
//   String? get isFreeDelivery => _isFreeDelivery;
//
//   set isFreeDelivery(String? isFreeDelivery) =>
//       _isFreeDelivery = isFreeDelivery;
//
//   CartTotal.fromJson(Map<String, dynamic> json) {
//     _discountAmount = json['discount_amount'];
//     _itemTotal = json['item_total'];
//     _deliveryCharge = json['delivery_charge'];
//     _tax = json['tax'];
//     _couponDiscount = json['coupon_discount'];
//     _total = json['total'];
//     _savingAmount = json['saving_amount'];
//     _isFreeDelivery = json['is_free_delivery'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['discount_amount'] = this._discountAmount;
//     data['item_total'] = this._itemTotal;
//     data['delivery_charge'] = this._deliveryCharge;
//     data['tax'] = this._tax;
//     data['coupon_discount'] = this._couponDiscount;
//     data['total'] = this._total;
//     data['saving_amount'] = this._savingAmount;
//     data['is_free_delivery'] = this._isFreeDelivery;
//     return data;
//   }
// }

import 'package:solikat_2024/models/search_master.dart';

///

class GetCartMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  CartData? _data;

  GetCartMaster(
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

  GetCartMaster.fromJson(Map<String, dynamic> json) {
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
  List<ProductData>? _cartItem;
  List<CartCouponData>? _coupon;
  CartTotal? _cartTotal;
  List<DealProductData>? _dealProduct;

  CartData(
      {List<ProductData>? cartItem,
      List<CartCouponData>? coupon,
      CartTotal? cartTotal,
      List<DealProductData>? dealProduct}) {
    if (cartItem != null) {
      this._cartItem = cartItem;
    }
    if (coupon != null) {
      this._coupon = coupon;
    }
    if (cartTotal != null) {
      this._cartTotal = cartTotal;
    }
    if (dealProduct != null) {
      this._dealProduct = dealProduct;
    }
  }

  List<ProductData>? get cartItem => _cartItem;
  set cartItem(List<ProductData>? cartItem) => _cartItem = cartItem;
  List<CartCouponData>? get coupon => _coupon;
  set coupon(List<CartCouponData>? coupon) => _coupon = coupon;
  CartTotal? get cartTotal => _cartTotal;
  set cartTotal(CartTotal? cartTotal) => _cartTotal = cartTotal;
  List<DealProductData>? get dealProduct => _dealProduct;
  set dealProduct(List<DealProductData>? dealProduct) =>
      _dealProduct = dealProduct;

  CartData.fromJson(Map<String, dynamic> json) {
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
    if (json['deal_product'] != null) {
      _dealProduct = <DealProductData>[];
      json['deal_product'].forEach((v) {
        _dealProduct!.add(new DealProductData.fromJson(v));
      });
    }
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
    if (this._dealProduct != null) {
      data['deal_product'] = this._dealProduct!.map((v) => v.toJson()).toList();
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

class DealProductData {
  int? _productId;
  int? _variantId;
  String? _productName;
  String? _variantName;
  int? _productPrice;
  int? _discountPrice;
  String? _image;
  String? _isAdd;
  String? _dealText;

  DealProductData(
      {int? productId,
      int? variantId,
      String? productName,
      String? variantName,
      int? productPrice,
      int? discountPrice,
      String? image,
      String? isAdd,
      String? dealText}) {
    if (productId != null) {
      this._productId = productId;
    }
    if (variantId != null) {
      this._variantId = variantId;
    }
    if (productName != null) {
      this._productName = productName;
    }
    if (variantName != null) {
      this._variantName = variantName;
    }
    if (productPrice != null) {
      this._productPrice = productPrice;
    }
    if (discountPrice != null) {
      this._discountPrice = discountPrice;
    }
    if (image != null) {
      this._image = image;
    }
    if (isAdd != null) {
      this._isAdd = isAdd;
    }
    if (dealText != null) {
      this._dealText = dealText;
    }
  }

  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  int? get variantId => _variantId;
  set variantId(int? variantId) => _variantId = variantId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get variantName => _variantName;
  set variantName(String? variantName) => _variantName = variantName;
  int? get productPrice => _productPrice;
  set productPrice(int? productPrice) => _productPrice = productPrice;
  int? get discountPrice => _discountPrice;
  set discountPrice(int? discountPrice) => _discountPrice = discountPrice;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get isAdd => _isAdd;
  set isAdd(String? isAdd) => _isAdd = isAdd;
  String? get dealText => _dealText;
  set dealText(String? dealText) => _dealText = dealText;

  DealProductData.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _variantId = json['variant_id'];
    _productName = json['product_name'];
    _variantName = json['variant_name'];
    _productPrice = json['product_price'];
    _discountPrice = json['discount_price'];
    _image = json['image'];
    _isAdd = json['is_add'];
    _dealText = json['deal_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this._productId;
    data['variant_id'] = this._variantId;
    data['product_name'] = this._productName;
    data['variant_name'] = this._variantName;
    data['product_price'] = this._productPrice;
    data['discount_price'] = this._discountPrice;
    data['image'] = this._image;
    data['is_add'] = this._isAdd;
    data['deal_text'] = this._dealText;
    return data;
  }
}
