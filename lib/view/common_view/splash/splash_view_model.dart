import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:solikat_2024/view/force_update/force_update_view.dart';
import '../../../database/app_preferences.dart';
import '../../../models/confirm_location_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../home/soliket_not_available_view.dart';
import '../../location/location_donNot_allow_view.dart';
import '../../login/login_view.dart';
import '../bottom_navbar/bottom_navbar_view.dart';

class SplashViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
    await checkAppVersion();
    startTimer();
  }

  Future<void> checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String currentVersion = packageInfo.version;

    String latestVersion = "1.0.0";

    log('Current app version =========> : $currentVersion <=========');

    log('Latest app version=========> : $latestVersion <=========');

    if (isVersionOutdated(currentVersion, latestVersion)) {
      pushAndRemove(ForceUpdateView(), context);
    }
  }

  bool isVersionOutdated(String currentVersion, String latestVersion) {
    List<String> currentParts = currentVersion.split('.');
    List<String> latestParts = latestVersion.split('.');
    for (int i = 0; i < latestParts.length; i++) {
      int currentPart = int.parse(currentParts[i]);
      int latestPart = int.parse(latestParts[i]);
      if (currentPart < latestPart) {
        return true;
      } else if (currentPart > latestPart) {
        return false;
      }
    }
    return false;
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
        pushAndRemove(LoginView(), context);
      } else if (userLat.isEmpty && userLong.isEmpty) {
        pushAndRemove(LocationDoNotAllowView(), context);
      } else if (accessToken.isNotEmpty &&
          userLat.isNotEmpty &&
          userLong.isNotEmpty) {
        await confirmLocationApi(latitude: userLat, longitude: userLong);
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
      pushAndRemove(SoliketNotAvailableView(), context);
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      pushAndRemove(BottomNavBarView(), context);
    }
    notifyListeners();
  }

  // void pushAndRemoveUntil(Widget view) {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => view),
  //     (Route<dynamic> route) => false,
  //   );
  // }
}

// class SplashViewModel with ChangeNotifier {
//   late BuildContext context;
//   final services = Services();
//
//   Future<void> attachedContext(BuildContext context) async {
//     this.context = context;
//     startTimer();
//   }
//
//   startTimer() async {
//     Future.delayed(const Duration(seconds: 2), () async {
//       String accessToken = await AppPreferences.instance.getAccessToken();
//       gUserLocation = await AppPreferences.instance.getUserLocation();
//       String userLat = await AppPreferences.instance.getUserLat();
//       String userLong = await AppPreferences.instance.getUserLong();
//       globalUserMaster = AppPreferences.instance.getUserDetails();
//       gUserLat = userLat;
//       gUserLong = userLong;
//       log("Stored User Details :: ${jsonEncode(AppPreferences.instance.getUserDetails())}");
//       log('access token :: $accessToken');
//       log('user location :: $gUserLocation');
//       log('user lat :: $gUserLat');
//       log('user long :: $gUserLong');
//       log('user profile done :: ${globalUserMaster?.isProfileComplete}');
//       if (accessToken.isEmpty) {
//         pushAndRemoveUntil(LoginView());
//       } else if (userLat.isEmpty && userLong.isEmpty) {
//         pushAndRemoveUntil(LocationDoNotAllowView());
//       } else if (accessToken.isNotEmpty & userLat.isNotEmpty &&
//           userLong.isNotEmpty) {
//         confirmLocationApi(latitude: userLat, longitude: userLong);
//       }
//     });
//   }
//
//   Future<void> confirmLocationApi({
//     required String latitude,
//     required String longitude,
//   }) async {
//     CommonUtils.showProgressDialog();
//     Map<String, dynamic> params = <String, dynamic>{
//       ApiParams.latitude: latitude,
//       ApiParams.longitude: longitude,
//     };
//     ConfirmLocationMaster? master =
//         await services.api!.confirmLocation(params: params);
//     print("..................$master");
//     CommonUtils.hideProgressDialog();
//     if (master == null) {
//       CommonUtils.oopsMSG();
//     } else if (!master.status! &&
//         master.message ==
//             "SOLIKET is not available at this location, We will be soon there.") {
//       pushAndRemoveUntil(SoliketNotAvailableView());
//     } else if (!master.status!) {
//       CommonUtils.showSnackBar(
//         master.message,
//         color: CommonColors.mRed,
//       );
//     } else if (master.status!) {
//       log("Success :: true");
//       pushAndRemoveUntil(BottomNavBarView());
//     }
//     notifyListeners();
//   }
// }
