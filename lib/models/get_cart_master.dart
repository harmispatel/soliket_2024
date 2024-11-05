class GetCartMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<CartData>? data;

  GetCartMaster({this.status, this.statusCode, this.message, this.data});

  GetCartMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? productId;
  int? variantId;
  String? productName;
  String? variantName;
  int? productPrice;
  int? discountPrice;
  int? discountPer;
  String? image;
  String? isDeal;
  int? stock;
  int? cartCount;

  CartData(
      {this.productId,
      this.variantId,
      this.productName,
      this.variantName,
      this.productPrice,
      this.discountPrice,
      this.discountPer,
      this.image,
      this.isDeal,
      this.stock,
      this.cartCount,
      });


  CartData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantId = json['variant_id'];
    productName = json['product_name'];
    variantName = json['variant_name'];
    productPrice = json['product_price'];
    discountPrice = json['discount_price'];
    discountPer = json['discount_per'];
    image = json['image'];
    isDeal = json['is_deal'];
    stock = json['stock'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['variant_id'] = variantId;
    data['product_name'] = productName;
    data['variant_name'] = variantName;
    data['product_price'] = productPrice;
    data['discount_price'] = discountPrice;
    data['discount_per'] = discountPer;
    data['image'] = image;
    data['is_deal'] = isDeal;
    data['stock'] = stock;
    data['cart_count'] = cartCount;
    return data;
  }
}
