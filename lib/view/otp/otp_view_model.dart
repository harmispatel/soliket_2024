import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../database/app_preferences.dart';
import '../../models/otp_master.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_utils.dart';
import '../../utils/global_variables.dart';
import '../location/location_allow_view.dart';
import '../location/location_donNot_allow_view.dart';

class OtpViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  Timer? timer;
  int second = 60;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void startTimer() {
    second = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (second == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          second--;
          notifyListeners();
        }
      },
    );
  }

  Future<void> otpVerifyApi({
    required String user_id,
    required String otp,
    required String device_token,
    required String device_type,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.user_id: user_id,
      ApiParams.otp: otp,
      ApiParams.device_token: device_token,
      ApiParams.device_type: device_type,
    };
    OtpMaster? master = await _services.api!.verifyOtp(params: params);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      log("Access Token :: ${master.data?.token}");

      AppPreferences.instance.setAccessToken(master.data?.token ?? '');
      AppPreferences.instance.setUserDetails(jsonEncode(master.data));
      globalUserMaster = AppPreferences.instance.getUserDetails();

      // CommonUtils.showCustomToast(context, master.message);

      requestLocationPermission();
    }
    notifyListeners();
  }

  Future<void> reSendOtpApi({
    required String user_id,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.user_id: user_id,
    };
    OtpMaster? master = await _services.api!.resendOtp(params: params);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      // log("Access Token :: ${master.jwt}");
      CommonUtils.showCustomToast(context, master.message);
    }
    notifyListeners();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    print(status);

    if (status.isGranted) {
      print("Location permission already granted.");
      pushAndRemoveUntil(LocationAllowView());
    } else if (status.isPermanentlyDenied) {
      // Show a message and prompt the user to open settings
      // CommonUtils.showSnackBar(
      //   "Location permission is required to proceed. Please enable it in settings.",
      //   color: CommonColors.mRed,
      // );

      pushAndRemoveUntil(LocationDoNotAllowView());

      // Optionally, open the app settings
      await openAppSettings();
    } else {
      // Request permission
      var result = await Permission.location.request();

      if (result.isGranted) {
        print("Location permission granted.");
        pushAndRemoveUntil(LocationAllowView());
      } else {
        // CommonUtils.showSnackBar(
        //   "Location permission is required to proceed.",
        //   color: CommonColors.mRed,
        // );
        pushAndRemoveUntil(LocationDoNotAllowView());
      }
    }
  }
}
