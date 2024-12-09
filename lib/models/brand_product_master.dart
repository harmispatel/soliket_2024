import 'package:solikat_2024/models/product_master.dart';

class BrandProductMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  BrandProductData? _data;

  BrandProductMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      BrandProductData? data}) {
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
  BrandProductData? get data => _data;
  set data(BrandProductData? data) => _data = data;

  BrandProductMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    _data = json['data'] != null
        ? new BrandProductData.fromJson(json['data'])
        : null;
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
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class BrandProductData {
  List<Brand>? _brand;
  List<ProductData>? _product;

  BrandProductData({List<Brand>? brand, List<ProductData>? product}) {
    if (brand != null) {
      this._brand = brand;
    }
    if (product != null) {
      this._product = product;
    }
  }

  List<Brand>? get brand => _brand;
  set brand(List<Brand>? brand) => _brand = brand;
  List<ProductData>? get product => _product;
  set product(List<ProductData>? product) => _product = product;

  BrandProductData.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      _brand = <Brand>[];
      json['brand'].forEach((v) {
        _brand!.add(new Brand.fromJson(v));
      });
    }
    if (json['product'] != null) {
      _product = <ProductData>[];
      json['product'].forEach((v) {
        _product!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._brand != null) {
      data['brand'] = this._brand!.map((v) => v.toJson()).toList();
    }
    if (this._product != null) {
      data['product'] = this._product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  int? _brandId;
  String? _name;
  String? _image;

  Brand({int? brandId, String? name, String? image}) {
    if (brandId != null) {
      this._brandId = brandId;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
  }

  int? get brandId => _brandId;
  set brandId(int? brandId) => _brandId = brandId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;

  Brand.fromJson(Map<String, dynamic> json) {
    _brandId = json['brand_id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this._brandId;
    data['name'] = this._name;
    data['image'] = this._image;
    return data;
  }
}
