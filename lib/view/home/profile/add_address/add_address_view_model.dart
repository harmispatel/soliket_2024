import 'dart:developer';

import 'package:flutter/cupertino.dart';

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

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> addAddressApi({
    required String latitude,
    required String longitude,
    required String name,
    required String mobileNo,
    required String landmark,
    required String address,
    required String houseNo,
    required String type,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.name: name,
      ApiParams.mobile_no: mobileNo,
      ApiParams.landmark: landmark,
      ApiParams.address: address,
      ApiParams.house_no: houseNo,
      ApiParams.type: type,
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
      push(SaveAddressView());
      SavedAddressViewModel().getAddressApi();
    }
    notifyListeners();
  }
}
