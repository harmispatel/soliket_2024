import 'package:solikat_2024/models/product_master.dart';

class GetCategoryProductMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  CategoryData? _data;

  GetCategoryProductMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      CategoryData? data}) {
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
  CategoryData? get data => _data;
  set data(CategoryData? data) => _data = data;

  GetCategoryProductMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    _data =
        json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
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

class CategoryData {
  List<SubCategory>? _subCategory;
  List<ProductData>? _product;

  CategoryData({List<SubCategory>? subCategory, List<ProductData>? product}) {
    if (subCategory != null) {
      this._subCategory = subCategory;
    }
    if (product != null) {
      this._product = product;
    }
  }

  List<SubCategory>? get subCategory => _subCategory;
  set subCategory(List<SubCategory>? subCategory) => _subCategory = subCategory;
  List<ProductData>? get product => _product;
  set product(List<ProductData>? product) => _product = product;

  CategoryData.fromJson(Map<String, dynamic> json) {
    if (json['sub_category'] != null) {
      _subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        _subCategory!.add(new SubCategory.fromJson(v));
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
    if (this._subCategory != null) {
      data['sub_category'] = this._subCategory!.map((v) => v.toJson()).toList();
    }
    if (this._product != null) {
      data['product'] = this._product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int? _subCategoryId;
  String? _name;
  String? _image;

  SubCategory({int? subCategoryId, String? name, String? image}) {
    if (subCategoryId != null) {
      this._subCategoryId = subCategoryId;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
  }

  int? get subCategoryId => _subCategoryId;
  set subCategoryId(int? subCategoryId) => _subCategoryId = subCategoryId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;

  SubCategory.fromJson(Map<String, dynamic> json) {
    _subCategoryId = json['sub_category_id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this._subCategoryId;
    data['name'] = this._name;
    data['image'] = this._image;
    return data;
  }
}
