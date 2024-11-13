import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../../models/terms_and_conditions_master.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class TermsAndConditionsViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<TermsAndConditionsData> termsAndConditionsList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getTermsAndConditionsApi();
    notifyListeners();
  }

  Future<void> getTermsAndConditionsApi() async {
    TermsAndConditionsMaster? master =
        await services.api!.getTermsAndConditionsApi();
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
      termsAndConditionsList = master.data ?? [];
    }
    notifyListeners();
  }
}
