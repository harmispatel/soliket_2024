class SearchMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  List<ProductData>? _data;

  SearchMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      List<ProductData>? data}) {
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
  List<ProductData>? get data => _data;
  set data(List<ProductData>? data) => _data = data;

  SearchMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    if (json['data'] != null) {
      _data = <ProductData>[];
      json['data'].forEach((v) {
        _data!.add(new ProductData.fromJson(v));
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

class ProductData {
  int? _productId;
  int? _variantId;
  String? _productName;
  String? _variantName;
  int? _productPrice;
  int? _discountPrice;
  int? _discountPer;
  String? _image;
  String? _isDeal;
  int? _stock;
  int? _cartCount;

  ProductData(
      {int? productId,
      int? variantId,
      String? productName,
      String? variantName,
      int? productPrice,
      int? discountPrice,
      int? discountPer,
      String? image,
      String? isDeal,
      int? stock,
      int? cartCount}) {
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
    if (discountPer != null) {
      this._discountPer = discountPer;
    }
    if (image != null) {
      this._image = image;
    }
    if (isDeal != null) {
      this._isDeal = isDeal;
    }
    if (stock != null) {
      this._stock = stock;
    }
    if (cartCount != null) {
      this._cartCount = cartCount;
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
  int? get discountPer => _discountPer;
  set discountPer(int? discountPer) => _discountPer = discountPer;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get isDeal => _isDeal;
  set isDeal(String? isDeal) => _isDeal = isDeal;
  int? get stock => _stock;
  set stock(int? stock) => _stock = stock;
  int? get cartCount => _cartCount;
  set cartCount(int? cartCount) => _cartCount = cartCount;

  ProductData.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _variantId = json['variant_id'];
    _productName = json['product_name'];
    _variantName = json['variant_name'];
    _productPrice = json['product_price'];
    _discountPrice = json['discount_price'];
    _discountPer = json['discount_per'];
    _image = json['image'];
    _isDeal = json['is_deal'];
    _stock = json['stock'];
    _cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this._productId;
    data['variant_id'] = this._variantId;
    data['product_name'] = this._productName;
    data['variant_name'] = this._variantName;
    data['product_price'] = this._productPrice;
    data['discount_price'] = this._discountPrice;
    data['discount_per'] = this._discountPer;
    data['image'] = this._image;
    data['is_deal'] = this._isDeal;
    data['stock'] = this._stock;
    data['cart_count'] = this._cartCount;
    return data;
  }
}
