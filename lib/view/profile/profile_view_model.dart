import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/models/common_master.dart';
import 'package:solikat_2024/utils/global_variables.dart';
import 'package:solikat_2024/view/login/login_view.dart';

import '../../../database/app_preferences.dart';
import '../../../models/product_master.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../common_view/bottom_navbar/bottom_navbar_view_model.dart';

class ProfileViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  ProfileData? profileData;
  bool isInitialLoading = true;

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
      globalUserMaster = null;

      mainNavKey.currentContext!.read<BottomNavbarViewModel>().selectedIndex =
          0;

      pushAndRemoveUntil(const LoginView());
    }
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    CommonUtils.showProgressDialog();
    CommonMaster? master = await _services.api!.deleteAccount();
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
      globalUserMaster = null;
      mainNavKey.currentContext!.read<BottomNavbarViewModel>().selectedIndex =
          0;
      pushAndRemoveUntil(const LoginView());
    }
    notifyListeners();
  }

  Future<void> getProfileApi() async {
    ProfileMaster? master = await _services.api!.getProfileApi();
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
      profileData = master.data;
    }
    notifyListeners();
  }
}
