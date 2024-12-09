import 'package:solikat_2024/models/search_master.dart';

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

// class Product {
//   int? _productId;
//   int? _variantId;
//   String? _productName;
//   String? _variantName;
//   int? _productPrice;
//   int? _discountPrice;
//   int? _discountPer;
//   String? _image;
//   String? _isDeal;
//   int? _stock;
//   int? _cartCount;
//
//   Product(
//       {int? productId,
//       int? variantId,
//       String? productName,
//       String? variantName,
//       int? productPrice,
//       int? discountPrice,
//       int? discountPer,
//       String? image,
//       String? isDeal,
//       int? stock,
//       int? cartCount}) {
//     if (productId != null) {
//       this._productId = productId;
//     }
//     if (variantId != null) {
//       this._variantId = variantId;
//     }
//     if (productName != null) {
//       this._productName = productName;
//     }
//     if (variantName != null) {
//       this._variantName = variantName;
//     }
//     if (productPrice != null) {
//       this._productPrice = productPrice;
//     }
//     if (discountPrice != null) {
//       this._discountPrice = discountPrice;
//     }
//     if (discountPer != null) {
//       this._discountPer = discountPer;
//     }
//     if (image != null) {
//       this._image = image;
//     }
//     if (isDeal != null) {
//       this._isDeal = isDeal;
//     }
//     if (stock != null) {
//       this._stock = stock;
//     }
//     if (cartCount != null) {
//       this._cartCount = cartCount;
//     }
//   }
//
//   int? get productId => _productId;
//   set productId(int? productId) => _productId = productId;
//   int? get variantId => _variantId;
//   set variantId(int? variantId) => _variantId = variantId;
//   String? get productName => _productName;
//   set productName(String? productName) => _productName = productName;
//   String? get variantName => _variantName;
//   set variantName(String? variantName) => _variantName = variantName;
//   int? get productPrice => _productPrice;
//   set productPrice(int? productPrice) => _productPrice = productPrice;
//   int? get discountPrice => _discountPrice;
//   set discountPrice(int? discountPrice) => _discountPrice = discountPrice;
//   int? get discountPer => _discountPer;
//   set discountPer(int? discountPer) => _discountPer = discountPer;
//   String? get image => _image;
//   set image(String? image) => _image = image;
//   String? get isDeal => _isDeal;
//   set isDeal(String? isDeal) => _isDeal = isDeal;
//   int? get stock => _stock;
//   set stock(int? stock) => _stock = stock;
//   int? get cartCount => _cartCount;
//   set cartCount(int? cartCount) => _cartCount = cartCount;
//
//   Product.fromJson(Map<String, dynamic> json) {
//     _productId = json['product_id'];
//     _variantId = json['variant_id'];
//     _productName = json['product_name'];
//     _variantName = json['variant_name'];
//     _productPrice = json['product_price'];
//     _discountPrice = json['discount_price'];
//     _discountPer = json['discount_per'];
//     _image = json['image'];
//     _isDeal = json['is_deal'];
//     _stock = json['stock'];
//     _cartCount = json['cart_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this._productId;
//     data['variant_id'] = this._variantId;
//     data['product_name'] = this._productName;
//     data['variant_name'] = this._variantName;
//     data['product_price'] = this._productPrice;
//     data['discount_price'] = this._discountPrice;
//     data['discount_per'] = this._discountPer;
//     data['image'] = this._image;
//     data['is_deal'] = this._isDeal;
//     data['stock'] = this._stock;
//     data['cart_count'] = this._cartCount;
//     return data;
//   }
// }
