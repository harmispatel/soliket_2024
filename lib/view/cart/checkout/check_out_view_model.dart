import 'package:flutter/cupertino.dart';

import '../../../models/common_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class CheckOutViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();

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
}
