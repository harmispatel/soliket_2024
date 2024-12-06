import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/cart_master.dart';
import 'package:solikat_2024/models/search_master.dart';

import '../../../../services/index.dart';
import '../../../../utils/common_utils.dart';
import '../../models/update_bill_details_master.dart';
import '../../utils/common_colors.dart';

class CartViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = true;
  List<ProductData> cartList = [];
  List<CartCouponData> appliedCouponList = [];
  List<DealProductData> dealProductList = [];
  String discountAmount = '';
  String itemTotal = '';
  String deliveryCharge = '';
  String tax = '';
  String couponDiscount = '';
  String total = '';
  String savingAmount = '';
  String isFreeDelivery = '';

  void attachedContext(BuildContext context) {
    this.context = context;
    getCartApi();
    notifyListeners();
  }

  Future<void> getCartApi() async {
    GetCartMaster? master = await _services.api!.getCartApi();
    isInitialLoading = false;
    if (master == null && master?.statusCode != 401) {
      CommonUtils.oopsMSG();
    } else if (master?.statusCode == 401) {
      CommonUtils.showSnackBar("Invalid Token",
          color: CommonColors.primaryColor);
    } else if (!master!.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      cartList = master.data?.cartItem ?? [];
      appliedCouponList = master.data?.coupon ?? [];
      dealProductList = master.data?.dealProduct ?? [];
      discountAmount = master.data?.cartTotal?.discountAmount ?? '';
      itemTotal = master.data?.cartTotal?.itemTotal ?? '';
      deliveryCharge = master.data?.cartTotal?.deliveryCharge ?? '';
      tax = master.data?.cartTotal?.tax ?? '';
      couponDiscount = master.data?.cartTotal?.couponDiscount ?? '';
      total = master.data?.cartTotal?.total ?? '';
      savingAmount = master.data?.cartTotal?.savingAmount ?? '';
      isFreeDelivery = master.data?.cartTotal?.isFreeDelivery ?? '';
    }
    notifyListeners();
  }

  Future<void> updateBillDetailsApi() async {
    CommonUtils.showProgressDialog();
    UpdateBillDetailsMaster? master = await _services.api!.updateBillDetails();
    CommonUtils.hideProgressDialog();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      dealProductList = master.data?.dealProduct ?? [];
      discountAmount = master.data?.billDetails?.discountAmount ?? '';
      itemTotal = master.data?.billDetails?.itemTotal ?? '';
      deliveryCharge = master.data?.billDetails?.deliveryCharge ?? '';
      tax = master.data?.billDetails?.tax ?? '';
      couponDiscount = master.data?.billDetails?.couponDiscount ?? '';
      total = master.data?.billDetails?.total ?? '';
      savingAmount = master.data?.billDetails?.savingAmount ?? '';
      isFreeDelivery = master.data?.billDetails?.isFreeDelivery ?? '';
    }
    notifyListeners();
  }
}
