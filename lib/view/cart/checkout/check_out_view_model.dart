import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/order_master.dart';

import '../../../models/check_delivery_available_master.dart';
import '../../../models/common_master.dart';
import '../../../models/update_bill_details_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
import '../../my_orders/order_success/order_success_view.dart';

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
  String orderId = '';
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
      CommonUtils.showCustomToast(context, master.message);
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
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
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

  Future<void> placeOrderApi({
    required String addressId,
    required String paymentMethod,
    required String transactionId,
  }) async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
      ApiParams.payment_method: paymentMethod,
      ApiParams.transaction_id: transactionId,
    };

    OrderMaster? master = await services.api!.placeOrder(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      if (paymentMethod == "cod") {
        Navigator.pop(context);

        push(OrderSuccessView());
      } else if (paymentMethod == "online") {
        orderId = master.data?.orderId ?? '';
        print("........... Order id stored ....... $orderId");
      }
    }
    notifyListeners();
  }

  Future<void> confirmOrderApi({
    required String orderId,
    required String transactionId,
  }) async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.order_id: orderId,
      ApiParams.transaction_id: transactionId,
    };

    CommonMaster? master = await services.api!.confirmOrder(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      push(OrderSuccessView());
    }
    notifyListeners();
  }

  Future<void> checkDeliveryAvailableApi({
    required String addressId,
  }) async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
    };

    CheckDeliveryAvailableMaster? master =
        await services.api!.checkDeliveryAvailable(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      if (master.message == "Delivery not available for this address.") {
        isDeliveryAvailable = false;
      }
      return;
    }

    if (master.status == true) {
      isDeliveryAvailable = true;
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
}
