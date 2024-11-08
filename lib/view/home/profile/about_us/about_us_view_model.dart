import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../models/about_us_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AboutUsViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<AboutUsData> aboutUsList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAboutUsApi() async {
    AboutUsMaster? master = await services.api!.getAboutUsApi();
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
      aboutUsList = master.data ?? [];
    }
    notifyListeners();
  }
}
