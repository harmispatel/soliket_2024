import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/common_master.dart';
import 'package:solikat_2024/utils/global_variables.dart';
import 'package:solikat_2024/view/login/login_view.dart';

import '../../../database/app_preferences.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class ProfileViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> logOutApi() async {
    CommonUtils.showProgressDialog();
    CommonMaster? master = await _services.api!.logOut();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      await AppPreferences.instance.clear();
      gUserId = '';
      gUserLocation = '';
      pushAndRemoveUntil(const LoginView());
    }
    notifyListeners();
  }
}
