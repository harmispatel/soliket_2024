class GetCouponMaster {
  bool? status;
  int? statusCode;
  String? message;
  List<CouponData>? data;

  GetCouponMaster({this.status, this.statusCode, this.message, this.data});

  GetCouponMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CouponData>[];
      json['data'].forEach((v) {
        data!.add(CouponData.fromJson(v));
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

class CouponData {
  int? couponId;
  String? couponCode;
  String? message;
  String? discountAmount;
  String? isEnabled;
  String? isApplied;
  String? icon;

  CouponData(
      {this.couponId,
      this.couponCode,
      this.message,
      this.discountAmount,
      this.isEnabled,
      this.isApplied,
      this.icon});

  CouponData.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    message = json['message'];
    discountAmount = json['discount_amount'];
    isEnabled = json['is_enabled'];
    isApplied = json['is_applied'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['message'] = message;
    data['discount_amount'] = discountAmount;
    data['is_enabled'] = isEnabled;
    data['is_applied'] = isApplied;
    data['icon'] = icon;
    return data;
  }
}
