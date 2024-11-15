import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../../../../../models/privacy_policy_master.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';


class PrivacyPolicyViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<PrivacyPolicyData> privacyPolicyList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getPrivacyPolicyApi();
    notifyListeners();
  }

  Future<void> getPrivacyPolicyApi() async {
    PrivacyPolicyMaster? master = await services.api!.getPrivacyPolicyApi();
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
      privacyPolicyList = master.data ?? [];
    }
    notifyListeners();
  }
}
