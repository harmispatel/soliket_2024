import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../models/return_policy_master.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_utils.dart';

class ReturnPolicyViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<ReturnPolicyData> returnPolicyList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getReturnPolicyApi();
    notifyListeners();
  }

  Future<void> getReturnPolicyApi() async {
    ReturnPolicyMaster? master = await services.api!.getReturnPolicyApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      returnPolicyList = master.data ?? [];
    }
    notifyListeners();
  }
}
