import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../database/app_preferences.dart';
import '../../../../models/otp_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/global_variables.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view.dart';

class EditAccountViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
  }

  Future<void> updateProfileApi({
    required String name,
    required String email,
    required String birthday,
    required String profile,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.name: name,
      ApiParams.email: email,
      ApiParams.birthday: birthday,
    };
    OtpMaster? master = await _services.api!.updateProfile(
        params: params, picture: profile, fileKey: ApiParams.profile);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      AppPreferences.instance.setUserDetails(jsonEncode(master.data));
      globalUserMaster = AppPreferences.instance.getUserDetails();
      pushAndRemoveUntil(BottomNavBarView());
    }
    notifyListeners();
  }
}
