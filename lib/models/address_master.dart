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

  AddressData(
      {int? addressId,
      String? type,
      String? address,
      String? name,
      String? mobile}) {
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

  AddressData.fromJson(Map<String, dynamic> json) {
    _addressId = json['address_id'];
    _type = json['type'];
    _address = json['address'];
    _name = json['name'];
    _mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this._addressId;
    data['type'] = this._type;
    data['address'] = this._address;
    data['name'] = this._name;
    data['mobile'] = this._mobile;
    return data;
  }
}
