import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../models/common_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_utils.dart';
import '../../save_address/saved_address_view.dart';
import '../../save_address/saved_address_view_model.dart';

class EditAddressViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> updateAddressApi({
    required String addressId,
    required String latitude,
    required String longitude,
    required String name,
    required String mobileNo,
    required String area,
    required String address,
    required String houseName,
    required String type,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.name: name,
      ApiParams.mobile_no: mobileNo,
      ApiParams.area: area,
      ApiParams.address: address,
      ApiParams.house_name: houseName,
      ApiParams.type: type,
    };

    log("Parameter : ${params}");

    CommonMaster? master =
        await _services.api!.updateAddressApi(params: params);
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
      log("Success :: true");
      push(const SaveAddressView());
      SavedAddressViewModel().getAddressApi();
    }
    notifyListeners();
  }
}
