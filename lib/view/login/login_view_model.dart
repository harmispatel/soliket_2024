import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/utils/global_variables.dart';

import '../../models/login_master.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../otp/otp_view.dart';

class LoginViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> loginApi({
    required String country_code,
    required String mobile_no,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.country_code: country_code,
      ApiParams.mobile_no: mobile_no,
    };
    LoginMaster? master = await _services.api!.login(params: params);
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
      // log("Access Token :: ${master.jwt}");
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
      // AppPreferences.instance.setAccessToken(master.sessionId ?? '');
      gUserId = master.data?.userId.toString() ?? '';
      push(const OtpView());
      // AppPreferences.instance.setUserDetails(jsonEncode(master.data!.user));
      // gUserType = master.data!.user!.roleId!.toString();
      // globalUserMaster = AppPreferences.instance.getUserDetails();
      // SplashViewModel().checkGlobalUserData();
    }
    notifyListeners();
  }
}
