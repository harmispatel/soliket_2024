class ProductData {
  int? _productId;
  int? _variantId;
  String? _productName;
  String? _variantName;
  String? _productPrice;
  String? _discountPrice;
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
      String? productPrice,
      String? discountPrice,
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
  String? get productPrice => _productPrice;
  set productPrice(String? productPrice) => _productPrice = productPrice;
  String? get discountPrice => _discountPrice;
  set discountPrice(String? discountPrice) => _discountPrice = discountPrice;
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
