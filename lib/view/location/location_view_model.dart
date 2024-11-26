import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:solikat_2024/models/confirm_location_master.dart';

import '../../database/app_preferences.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_utils.dart';
import '../../utils/global_variables.dart';
import '../common_view/bottom_navbar/bottom_navbar_view.dart';
import '../home/soliket_not_available_view.dart';

class LocationViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) async {
    this.context = context;
    //await checkAppVersion();
    notifyListeners();
  }

  Future<void> confirmLocationApi({
    required String latitude,
    required String longitude,
    required String location,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
    };
    ConfirmLocationMaster? master =
        await _services.api!.confirmLocation(params: params);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status! &&
        master.message ==
            "SOLIKET is not available at this location, We will be soon there.") {
      AppPreferences.instance.setUserLocation(location);
      AppPreferences.instance.setUserLat(latitude);
      AppPreferences.instance.setUserLong(longitude);
      gUserLocation = await AppPreferences.instance.getUserLocation();
      pushAndRemoveUntil(SoliketNotAvailableView());
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      AppPreferences.instance.setUserLocation(location);
      AppPreferences.instance.setUserLat(latitude);
      AppPreferences.instance.setUserLong(longitude);
      gUserLocation = await AppPreferences.instance.getUserLocation();
      String userLat = await AppPreferences.instance.getUserLat();
      String userLong = await AppPreferences.instance.getUserLong();
      gUserLat = userLat;
      gUserLong = userLong;
      pushAndRemoveUntil(BottomNavBarView());
    }
    notifyListeners();
  }

  // Future<void> checkAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //
  //   String currentVersion = packageInfo.version;
  //
  //   String latestVersion = "1.0.1";
  //
  //   log('Current app version =========> : $currentVersion <=========');
  //
  //   log('Latest app version=========> : $latestVersion <=========');
  //
  //   if (isVersionOutdated(currentVersion, latestVersion)) {
  //     forceUpdateBottomSheet();
  //   }
  // }
  //
  // bool isVersionOutdated(String currentVersion, String latestVersion) {
  //   List<String> currentParts = currentVersion.split('.');
  //   List<String> latestParts = latestVersion.split('.');
  //   for (int i = 0; i < latestParts.length; i++) {
  //     int currentPart = int.parse(currentParts[i]);
  //     int latestPart = int.parse(latestParts[i]);
  //     if (currentPart < latestPart) {
  //       return true;
  //     } else if (currentPart > latestPart) {
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  // void forceUpdateBottomSheet() {
  //   showModalBottomSheet(
  //     context: mainNavKey.currentContext!,
  //     clipBehavior: Clip.antiAlias,
  //     isScrollControlled: true,
  //     useSafeArea: true,
  //     backgroundColor: CommonColors.mWhite,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.zero,
  //       ),
  //     ),
  //     builder: (_) {
  //       return IntrinsicHeight(
  //         child: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 20) +
  //                   const EdgeInsets.only(top: 22, bottom: 10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(14),
  //                     child: Image.asset(
  //                       LocalImages.img_splash_logo,
  //                       height: 70,
  //                       width: 70,
  //                       fit: BoxFit.fill,
  //                     ),
  //                   ),
  //                   kCommonSpaceV20,
  //                   Text(
  //                     "New Update Available",
  //                     style: getAppStyle(
  //                       color: CommonColors.blackColor,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 10, bottom: 26),
  //                     child: Text(
  //                       "Update your Soliket app for seamiess experience with new features. You can keep using the app while we update in background.",
  //                       overflow: TextOverflow.clip,
  //                       style: getAppStyle(
  //                         color: Colors.black.withOpacity(0.6),
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       PrimaryButton(
  //                         height: 55,
  //                         width: 100,
  //                         label: "Skip",
  //                         buttonColor: CommonColors.grayShade200,
  //                         labelColor: CommonColors.blackColor,
  //                         onPress: () {
  //                           Navigator.pop(context);
  //                         },
  //                       ),
  //                       kCommonSpaceH15,
  //                       Expanded(
  //                         child: PrimaryButton(
  //                           height: 55,
  //                           label: "Update App",
  //                           buttonColor: CommonColors.primaryColor,
  //                           labelColor: CommonColors.mWhite,
  //                           onPress: () {
  //                             openStoreListing();
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> openStoreListing() async {
  //   const url =
  //       "https://play.google.com/store/apps/details?id=com.ludo.king&pcampaignid=web_share";
  //   if (url.isNotEmpty) {
  //     await tryLaunch(url);
  //   } else {
  //     log("No URL provided for $url platform");
  //   }
  // }
  //
  // Future<bool> tryLaunch(
  //   String link, {
  //   Function()? onCannotLaunch,
  //   LaunchMode mode = LaunchMode.externalApplication,
  // }) async {
  //   final uri = Uri.parse(link);
  //   if (await canLaunchUrl(uri)) {
  //     try {
  //       return await launchUrl(
  //         uri,
  //         mode: mode,
  //         webViewConfiguration: const WebViewConfiguration(),
  //       );
  //     } catch (e) {
  //       log("Error launching $link: $e");
  //       onCannotLaunch?.call();
  //     }
  //   } else {
  //     log("Cannot launch $link");
  //     onCannotLaunch?.call();
  //   }
  //   return false;
  // }
}
