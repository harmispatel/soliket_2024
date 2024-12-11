class HomeMaster {
  bool status;
  String? message;
  int? statusCode;
  String? currentPage;
  int? totalPage;
  int? totalRecords;
  List<Section> data;

  HomeMaster({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.currentPage,
    required this.totalPage,
    required this.totalRecords,
    required this.data,
  });

  factory HomeMaster.fromJson(Map<String, dynamic> json) {
    var sectionList = json['data'] as List? ?? [];
    List<Section> dataList =
        sectionList.map((i) => Section.fromJson(i)).toList();

    return HomeMaster(
      status: json['status'],
      message: json['message'],
      statusCode: json['status_code'],
      currentPage: json['current_page'],
      totalPage: json['total_page'],
      totalRecords: json['total_records'],
      data: dataList,
    );
  }
}

class Section {
  String type;
  String sectionTitle;
  dynamic data;

  Section({
    required this.type,
    required this.sectionTitle,
    required this.data,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    dynamic dataContent;

    switch (json['type']) {
      case 'section_1':
        dataContent = (json['data'] as List)
            .map((item) => Section1Data.fromJson(item))
            .toList();
        break;
      case 'section_2':
        dataContent = (json['data'] as List)
            .map((item) => Section2Data.fromJson(item))
            .toList();
        break;
      case 'section_3':
        dataContent = (json['data'] as List)
            .map((item) => Section3Data.fromJson(item))
            .toList();
        break;
      case 'section_4':
        dataContent = (json['data'] as List)
            .map((item) => Section4Data.fromJson(item))
            .toList();
        break;
      case 'section_5':
        dataContent = (json['data'] as List)
            .map((item) => Section5Data.fromJson(item))
            .toList();
        break;
      case 'section_6':
        dataContent = Section6Data.fromJson(json['data']);
        break;
      case 'section_7':
        dataContent = (json['data'] as List)
            .map((item) => Section7Data.fromJson(item))
            .toList();
        break;
      case 'section_8':
        dataContent = (json['data'] as List)
            .map((item) => Section8Data.fromJson(item))
            .toList();
        break;
      case 'section_9':
        dataContent = Section9Data.fromJson(json['data']);
        break;
      case 'section_10':
        dataContent = Section10Data.fromJson(json['data']);
        break;
      default:
        dataContent = null;
    }

    return Section(
      type: json['type'],
      sectionTitle: json['section_title'],
      data: dataContent,
    );
  }
}

class Section1Data {
  String image;
  String categoryId;

  Section1Data({
    required this.image,
    required this.categoryId,
  });

  factory Section1Data.fromJson(Map<String, dynamic> json) {
    return Section1Data(
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class Section2Data {
  final String title;
  final String image;
  final String categoryId;

  Section2Data(
      {required this.title, required this.image, required this.categoryId});

  factory Section2Data.fromJson(Map<String, dynamic> json) {
    return Section2Data(
      title: json['title'],
      image: json['image'],
      categoryId: json['category_id'].toString(),
    );
  }
}

class Section3Data {
  String title;
  String image;
  int categoryId;

  Section3Data({
    required this.title,
    required this.image,
    required this.categoryId,
  });

  factory Section3Data.fromJson(Map<String, dynamic> json) {
    return Section3Data(
      title: json['title'],
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class Section4Data {
  int productId;
  int variantId;
  String productName;
  String variantName;
  dynamic productPrice;
  dynamic discountPrice;
  int discountPer;
  String image;
  String isDeal;
  int stock;
  int cartCount;

  Section4Data({
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.productPrice,
    required this.discountPrice,
    required this.discountPer,
    required this.image,
    required this.isDeal,
    required this.stock,
    required this.cartCount,
  });

  factory Section4Data.fromJson(Map<String, dynamic> json) {
    return Section4Data(
      productId: json['product_id'],
      variantId: json['variant_id'],
      productName: json['product_name'],
      variantName: json['variant_name'],
      productPrice: json['product_price'],
      discountPrice: json['discount_price'],
      discountPer: json['discount_per'],
      image: json['image'],
      isDeal: json['is_deal'],
      stock: json['stock'],
      cartCount: json['cart_count'],
    );
  }
}

class Section5Data {
  String image;
  String categoryId;

  Section5Data({
    required this.image,
    required this.categoryId,
  });

  factory Section5Data.fromJson(Map<String, dynamic> json) {
    return Section5Data(
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class Section6Data {
  final Section6Setting setting;
  final List<Section6Category> categories;

  Section6Data({required this.setting, required this.categories});

  factory Section6Data.fromJson(Map<String, dynamic> json) {
    var categoryList = json['category'] as List;
    List<Section6Category> categories = categoryList
        .map((category) => Section6Category.fromJson(category))
        .toList();

    return Section6Data(
      setting: Section6Setting.fromJson(json['setting']),
      categories: categories,
    );
  }
}

class Section6Setting {
  final String backgroundImage;
  final String textColor;

  Section6Setting({required this.backgroundImage, required this.textColor});

  factory Section6Setting.fromJson(Map<String, dynamic> json) {
    return Section6Setting(
      backgroundImage: json['background_image'],
      textColor: json['text_color'],
    );
  }
}

class Section6Category {
  final String title;
  final String image;
  final int categoryId;

  Section6Category(
      {required this.title, required this.image, required this.categoryId});

  factory Section6Category.fromJson(Map<String, dynamic> json) {
    return Section6Category(
      title: json['title'],
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class Section7Data {
  String title;
  String image;
  int brandId;

  Section7Data({
    required this.title,
    required this.image,
    required this.brandId,
  });

  factory Section7Data.fromJson(Map<String, dynamic> json) {
    return Section7Data(
      title: json['title'],
      image: json['image'],
      brandId: json['brand_id'],
    );
  }
}

class Section8Data {
  String image;
  int offerId;

  Section8Data({
    required this.image,
    required this.offerId,
  });

  factory Section8Data.fromJson(Map<String, dynamic> json) {
    return Section8Data(
      image: json['image'],
      offerId: json['offer_id'],
    );
  }
}

class Section9Data {
  List<Section9Product> products;
  Section9Setting setting;

  Section9Data({
    required this.products,
    required this.setting,
  });

  factory Section9Data.fromJson(Map<String, dynamic> json) {
    return Section9Data(
      products: json['product'] != null
          ? (json['product'] as List<dynamic>)
              .map((item) => Section9Product.fromJson(item))
              .toList()
          : [],
      setting: json['setting'] != null
          ? Section9Setting.fromJson(json['setting'])
          : Section9Setting(
              backgroundImage: '', buttonColor: '', categoryId: ''),
    );
  }
}

class Section9Product {
  int productId;
  int variantId;
  String productName;
  String variantName;
  String productPrice;
  String discountPrice;
  int discountPer;
  String image;
  String isDeal;
  int stock;
  int cartCount;

  Section9Product({
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.productPrice,
    required this.discountPrice,
    required this.discountPer,
    required this.image,
    required this.isDeal,
    required this.stock,
    required this.cartCount,
  });

  factory Section9Product.fromJson(Map<String, dynamic> json) {
    return Section9Product(
      productId: json['product_id'] ?? 0,
      variantId: json['variant_id'],
      productName: json['product_name'] ?? '',
      variantName: json['variant_name'] ?? '',
      productPrice: (json['product_price'] ?? 0),
      discountPrice: (json['discount_price'] ?? 0),
      discountPer: json['discount_per'] ?? 0,
      image: json['image'] ?? '',
      isDeal: json['is_deal'] ?? '',
      stock: json['stock'] ?? 0,
      cartCount: json['cart_count'] ?? 0,
    );
  }
}

class Section9Setting {
  String backgroundImage;
  String buttonColor;
  String categoryId;

  Section9Setting({
    required this.backgroundImage,
    required this.buttonColor,
    required this.categoryId,
  });

  factory Section9Setting.fromJson(Map<String, dynamic> json) {
    return Section9Setting(
      backgroundImage: json['background_image'] ?? '',
      buttonColor: json['button_color'] ?? '',
      categoryId: json['category_id'] ?? '',
    );
  }
}

class Section10Data {
  String text;

  Section10Data({
    required this.text,
  });

  factory Section10Data.fromJson(Map<String, dynamic> json) {
    return Section10Data(
      text: json['text'],
    );
  }
}
