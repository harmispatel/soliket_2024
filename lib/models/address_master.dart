class AddressMaster {
  bool? _status;
  int? _statusCode;
  String? _message;
  List<AddressData>? _data;

  AddressMaster(
      {bool? status,
      int? statusCode,
      String? message,
      List<AddressData>? data}) {
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
  List<AddressData>? get data => _data;
  set data(List<AddressData>? data) => _data = data;

  AddressMaster.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <AddressData>[];
      json['data'].forEach((v) {
        _data!.add(new AddressData.fromJson(v));
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

class AddressData {
  int? _addressId;
  String? _type;
  String? _address;
  String? _name;
  String? _mobile;
  String? _latitude;
  String? _longitude;
  String? _area;
  String? _houseName;
  String? _isDefault;

  AddressData({
    int? addressId,
    String? type,
    String? address,
    String? name,
    String? mobile,
    String? latitude,
    String? longitude,
    String? area,
    String? houseName,
    String? isDefault,
  }) {
    if (addressId != null) {
      this._addressId = addressId;
    }
    if (type != null) {
      this._type = type;
    }
    if (address != null) {
      this._address = address;
    }
    if (name != null) {
      this._name = name;
    }
    if (mobile != null) {
      this._mobile = mobile;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (area != null) {
      this._area = area;
    }
    if (houseName != null) {
      this._houseName = houseName;
    }
    if (isDefault != null) {
      this._isDefault = isDefault;
    }
  }

  int? get addressId => _addressId;
  set addressId(int? addressId) => _addressId = addressId;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;
  String? get latitude => _latitude;
  set latitude(String? latitude) => _latitude = latitude;
  String? get longitude => _longitude;
  set longitude(String? longitude) => _longitude = longitude;
  String? get area => _area;
  set area(String? area) => _area = area;
  String? get houseName => _houseName;
  set houseName(String? houseName) => _houseName = houseName;
  String? get isDefault => _isDefault;
  set isDefault(String? isDefault) => _isDefault = isDefault;

  AddressData.fromJson(Map<String, dynamic> json) {
    _addressId = json['address_id'];
    _type = json['type'];
    _address = json['address'];
    _name = json['name'];
    _mobile = json['mobile'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _area = json['area'];
    _houseName = json['house_name'];
    _isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this._addressId;
    data['type'] = this._type;
    data['address'] = this._address;
    data['name'] = this._name;
    data['mobile'] = this._mobile;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['area'] = this._area;
    data['house_name'] = this._houseName;
    data['is_default'] = this._isDefault;
    return data;
  }
}
