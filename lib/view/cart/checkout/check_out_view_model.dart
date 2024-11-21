import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../models/common_master.dart';
import '../../../models/update_bill_details_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class CheckOutViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  String discountAmount = '';
  String itemTotal = '';
  String deliveryCharge = '';
  String tax = '';
  String couponDiscount = '';
  String total = '';
  String savingAmount = '';
  String isFreeDelivery = '';
  bool isDeliveryAvailable = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> setDefaultAddressApi({
    required String addressId,
  }) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
    };

    CommonMaster? master =
        await services.api!.setDefaultAddress(params: params);

    notifyListeners();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

    if (master.status == true) {}
    notifyListeners();
  }

  Future<void> updateBillDetailsApi() async {
    CommonUtils.showProgressDialog();
    UpdateBillDetailsMaster? master = await services.api!.updateBillDetails();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      discountAmount = master.data?.discountAmount ?? '';
      itemTotal = master.data?.itemTotal ?? '';
      deliveryCharge = master.data?.deliveryCharge ?? '';
      tax = master.data?.tax ?? '';
      couponDiscount = master.data?.couponDiscount ?? '';
      total = master.data?.total ?? '';
      savingAmount = master.data?.savingAmount ?? '';
      isFreeDelivery = master.data?.isFreeDelivery ?? '';
    }
    notifyListeners();
  }

  Future<void> checkDeliveryAvailableApi({
    required String addressId,
  }) async {
    // CommonUtils.showProgressDialog();

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
    };

    CommonMaster? master =
        await services.api!.checkDeliveryAvailable(params: params);
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

    if (master.status == true) {
      if (master.message == "Delivery not available for this address.") {
        isDeliveryAvailable = false;
      }
    }
    notifyListeners();
  }
}
