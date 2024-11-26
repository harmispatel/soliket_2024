import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/common_master.dart';

import '../../../../models/address_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_utils.dart';

class SavedAddressViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = true;
  List<AddressData> addressList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAddressApi() async {
    AddressMaster? master = await _services.api!.getAddressApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      addressList = master.data ?? [];
    }
    notifyListeners();
  }

  Future<void> deleteAddressApi({
    required String addressId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.address_id: addressId,
    };

    CommonMaster? master =
        await _services.api!.deleteAddressApi(params: params);
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

      getAddressApi();
    }
    notifyListeners();
  }
}
