import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../models/contact_us_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class ContactUsViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<ContactUsData> contactUsList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getContactUsApi() async {
    ContactMaster? master = await services.api!.getContactUsApi();
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
      contactUsList = master.data ?? [];
    }
    notifyListeners();
  }
}
