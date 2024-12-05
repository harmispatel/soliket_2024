import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/remote_config/remote_global_config.dart';
import '../../../database/app_preferences.dart';
import '../../../models/app_credensials_master.dart';
import '../../../models/confirm_location_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../home/soliket_not_available_view.dart';
import '../../location/location_donNot_allow_view.dart';
import '../../login/login_view.dart';
import '../../maintenance/maintenance_view.dart';
import '../../profile/edit_account/edit_account_view.dart';
import '../bottom_navbar/bottom_navbar_view.dart';

class SplashViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<AppCredensialsData>? appCredensialsData;
  bool isAppCredensials = true;

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
    appCheck();
    getAppCredensials();
    notifyListeners();
  }

  Future<void> appCheck() async {
    final appDownConfig = RemoteGlobalConfig.remoteGlobalModel.appDownMaster;
    if (appDownConfig?.appDown == true) {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => MaintenanceView(appDownMaster: appDownConfig),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      startTimer();
    }
  }

  startTimer() async {
    Future.delayed(const Duration(seconds: 2), () async {
      String accessToken = await AppPreferences.instance.getAccessToken();
      gUserLocation = await AppPreferences.instance.getUserLocation();
      String userLat = await AppPreferences.instance.getUserLat();
      String userLong = await AppPreferences.instance.getUserLong();
      globalUserMaster = AppPreferences.instance.getUserDetails();
      gUserLat = userLat;
      gUserLong = userLong;
      log("Stored User Details :: ${jsonEncode(AppPreferences.instance.getUserDetails())}");
      log('access token :: $accessToken');
      log('user location :: $gUserLocation');
      log('user lat :: $gUserLat');
      log('user long :: $gUserLong');
      log('user profile done :: ${globalUserMaster?.isProfileComplete}');
      if (accessToken.isEmpty) {
        pushAndRemoveUntil(LoginView());
      } else if (userLat.isEmpty && userLong.isEmpty) {
        pushAndRemoveUntil(LocationDoNotAllowView());
      } else if (accessToken.isNotEmpty & userLat.isNotEmpty &&
          userLong.isNotEmpty) {
        confirmLocationApi(latitude: userLat, longitude: userLong);
      }
    });
  }

  Future<void> confirmLocationApi({
    required String latitude,
    required String longitude,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
    };
    ConfirmLocationMaster? master =
        await services.api!.confirmLocation(params: params);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status! &&
        master.message ==
            "SOLIKET is not available at this location, We will be soon there.") {
      pushAndRemoveUntil(SoliketNotAvailableView());
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      if (globalUserMaster?.isProfileComplete == "n") {
        pushAndRemoveUntil(EditAccountView(
          name: globalUserMaster?.name,
          email: globalUserMaster?.email,
          phone: globalUserMaster?.mobile,
          birthDate: globalUserMaster?.birthday,
          profileImage: globalUserMaster?.profile,
        ));
      } else {
        pushAndRemoveUntil(BottomNavBarView());
      }
      //pushAndRemoveUntil(BottomNavBarView());
    }
    notifyListeners();
  }

  Future<void> getAppCredensials() async {
    AppCredensialsMaster? master = await services.api!.getAppCredensials();
    isAppCredensials = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      appCredensialsData = master.data;
      appName = master.data?.first.appName.toString() ?? '';
      mapKey = master.data?.first.mapKey.toString() ?? '';
      appColor = master.data?.first.appColor.toString() ?? '';
      razorpayKey = master.data?.first.razzorpayKey.toString() ?? '';
      print("AppCredensials App Name =====> $appName");
      print("AppCredensials App MapKey =====> $mapKey");
      print("AppCredensials App Color =====> $appColor");
      print("AppCredensials App RazorpayKey =====> $razorpayKey");
    }
    notifyListeners();
  }
}
