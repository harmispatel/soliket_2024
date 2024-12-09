import 'package:solikat_2024/models/product_master.dart';

class OfferProductMaster {
  bool? _status;
  String? _message;
  int? _statusCode;
  String? _currentPage;
  int? _totalPage;
  int? _totalRecords;
  OfferProductData? _data;

  OfferProductMaster(
      {bool? status,
      String? message,
      int? statusCode,
      String? currentPage,
      int? totalPage,
      int? totalRecords,
      OfferProductData? data}) {
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
  OfferProductData? get data => _data;
  set data(OfferProductData? data) => _data = data;

  OfferProductMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _statusCode = json['status_code'];
    _currentPage = json['current_page'];
    _totalPage = json['total_page'];
    _totalRecords = json['total_records'];
    _data = json['data'] != null
        ? new OfferProductData.fromJson(json['data'])
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

class OfferProductData {
  List<Offer>? _offer;
  List<ProductData>? _product;

  OfferProductData({List<Offer>? offer, List<ProductData>? product}) {
    if (offer != null) {
      this._offer = offer;
    }
    if (product != null) {
      this._product = product;
    }
  }

  List<Offer>? get offer => _offer;
  set offer(List<Offer>? offer) => _offer = offer;
  List<ProductData>? get product => _product;
  set product(List<ProductData>? product) => _product = product;

  OfferProductData.fromJson(Map<String, dynamic> json) {
    if (json['offer'] != null) {
      _offer = <Offer>[];
      json['offer'].forEach((v) {
        _offer!.add(new Offer.fromJson(v));
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
    if (this._offer != null) {
      data['offer'] = this._offer!.map((v) => v.toJson()).toList();
    }
    if (this._product != null) {
      data['product'] = this._product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offer {
  String? _image;
  String? _title;
  int? _offerId;

  Offer({String? image, String? title, int? offerId}) {
    if (image != null) {
      this._image = image;
    }
    if (title != null) {
      this._title = title;
    }
    if (offerId != null) {
      this._offerId = offerId;
    }
  }

  String? get image => _image;
  set image(String? image) => _image = image;
  String? get title => _title;
  set title(String? title) => _title = title;
  int? get offerId => _offerId;
  set offerId(int? offerId) => _offerId = offerId;

  Offer.fromJson(Map<String, dynamic> json) {
    _image = json['image'];
    _title = json['title'];
    _offerId = json['offer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this._image;
    data['title'] = this._title;
    data['offer_id'] = this._offerId;
    return data;
  }
}
