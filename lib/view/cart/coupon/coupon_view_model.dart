import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../services/index.dart';
import '../../../../utils/common_utils.dart';
import '../../../models/common_master.dart';
import '../../../models/coupon_master.dart';
import '../../../services/api_para.dart';

class CouponViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = true;
  List<CouponData> couponList = [];
  List<bool> appliedCoupons = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    getCouponApi();
    notifyListeners();
  }

  Future<void> getCouponApi() async {
    GetCouponMaster? master = await _services.api!.getCouponApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      couponList = master.data ?? [];
      appliedCoupons = List.generate(couponList.length, (_) => false);
    }
    notifyListeners();
  }

  Future<void> applyCouponApi({
    required String couponId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.coupon_id: couponId,
    };

    CommonMaster? master = await _services.api!.applyCoupon(params: params);
    CommonUtils.hideProgressDialog();

    notifyListeners();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      getCouponApi();
    }
    notifyListeners();
  }

  Future<void> removeCouponApi({
    required String couponId,
  }) async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.coupon_id: couponId,
    };

    CommonMaster? master = await _services.api!.removeCoupon(params: params);
    CommonUtils.hideProgressDialog();

    notifyListeners();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      getCouponApi();
    }
    notifyListeners();
  }
}
