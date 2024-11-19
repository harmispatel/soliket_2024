class CategoryMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<CategoryData>? _data;

  CategoryMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<CategoryData>? data}) {
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
  List<CategoryData>? get data => _data;
  set data(List<CategoryData>? data) => _data = data;

  CategoryMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <CategoryData>[];
      json['data'].forEach((v) {
        _data!.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['status_code'] = this._statusCode;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  int? _categoryId;
  String? _categoryName;
  String? _categoryImage;

  CategoryData({int? categoryId, String? categoryName, String? categoryImage}) {
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (categoryName != null) {
      this._categoryName = categoryName;
    }
    if (categoryImage != null) {
      this._categoryImage = categoryImage;
    }
  }

  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get categoryName => _categoryName;
  set categoryName(String? categoryName) => _categoryName = categoryName;
  String? get categoryImage => _categoryImage;
  set categoryImage(String? categoryImage) => _categoryImage = categoryImage;

  CategoryData.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this._categoryId;
    data['category_name'] = this._categoryName;
    data['category_image'] = this._categoryImage;
    return data;
  }
}
