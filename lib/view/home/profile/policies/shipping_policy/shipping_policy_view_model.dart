import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../../models/shipping_policy_master.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class ShippingPolicyViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<ShippingPolicyData> shippingPolicyList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getShippingPolicyApi();
    notifyListeners();
  }

  Future<void> getShippingPolicyApi() async {
    ShippingPolicyMaster? master = await services.api!.getShippingPolicyApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      shippingPolicyList = master.data ?? [];
    }
    notifyListeners();
  }
}
