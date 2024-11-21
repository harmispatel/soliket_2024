import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/view/cart/checkout/check_out_view.dart';

import '../../../../models/common_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../save_address/saved_address_view.dart';
import '../save_address/saved_address_view_model.dart';

class AddAddressViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isFromCart = false;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> addAddressApi({
    required String latitude,
    required String longitude,
    required String name,
    required String mobileNo,
    required String area,
    required String address,
    required String houseName,
    required String type,
    required String isDefault,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.name: name,
      ApiParams.mobile_no: mobileNo,
      ApiParams.area: area,
      ApiParams.address: address,
      ApiParams.house_name: houseName,
      ApiParams.type: type,
      ApiParams.is_default: isDefault,
    };

    log("Parameter : ${params}");

    CommonMaster? master = await _services.api!.addAddressApi(params: params);
    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

    if (master.status == true) {
      log("Success :: true");
      if (isFromCart) {
        push(CheckOutView());
      } else {
        push(SaveAddressView());
      }
      SavedAddressViewModel().getAddressApi();
    }
    notifyListeners();
  }
}
