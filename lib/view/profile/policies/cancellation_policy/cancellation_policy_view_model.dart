import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../../models/cancellation_policy_master.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class CancellationPolicyViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<CancellationPolicyData> cancellationPolicyList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getCancellationPolicyApi();
    notifyListeners();
  }

  Future<void> getCancellationPolicyApi() async {
    CancellationPolicyMaster? master =
        await services.api!.getCancellationPolicyApi();
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
      cancellationPolicyList = master.data ?? [];
    }
    notifyListeners();
  }
}
