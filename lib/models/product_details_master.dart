class ProductDetailsMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<ProductDetailsData>? data;

  ProductDetailsMaster({this.status, this.statusCode, this.message, this.data});

  ProductDetailsMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductDetailsData>[];
      json['data'].forEach((v) {
        data!.add(ProductDetailsData.fromJson(v));
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

class ProductDetailsData {
  int? productId;
  int? variantId;
  String? productName;
  String? description;
  String? variantName;
  String? productPrice;
  String? discountPrice;
  int? discountPer;
  String? isDeal;
  int? stock;
  int? cartCount;
  List<Image>? image;

  ProductDetailsData(
      {this.productId,
      this.variantId,
      this.productName,
      this.description,
      this.variantName,
      this.productPrice,
      this.discountPrice,
      this.discountPer,
      this.isDeal,
      this.stock,
      this.cartCount,
      this.image});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantId = json['variant_id'];
    productName = json['product_name'];
    description = json['description'];
    variantName = json['variant_name'];
    productPrice = json['product_price'];
    discountPrice = json['discount_price'];
    discountPer = json['discount_per'];
    isDeal = json['is_deal'];
    stock = json['stock'];
    cartCount = json['cart_count'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['variant_id'] = variantId;
    data['product_name'] = productName;
    data['description'] = description;
    data['variant_name'] = variantName;
    data['product_price'] = productPrice;
    data['discount_price'] = discountPrice;
    data['discount_per'] = discountPer;
    data['is_deal'] = isDeal;
    data['stock'] = stock;
    data['cart_count'] = cartCount;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  int? id;
  String? image;

  Image({this.id, this.image});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
