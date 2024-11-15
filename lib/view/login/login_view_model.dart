import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:solikat_2024/utils/global_variables.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../database/app_preferences.dart';
import '../../models/app_version_master.dart';
import '../../models/login_master.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';
import '../../widget/primary_button.dart';
import '../otp/otp_view.dart';

class LoginViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = false;
  String? latestAppVersion;

  void attachedContext(BuildContext context) {
    this.context = context;
    getAppVersionApi().then((_) {
      checkAppVersion(); // Now check version after API call completes
    });
    print("AAAAAAAAAAAAAAAAA");
    print(latestAppVersion.toString());
    print("AAAAAAAAAAAAAAAAA");
    notifyListeners();
  }

  // void attachedContext(BuildContext context) {
  //   this.context = context;
  //   checkAppVersion();
  //   getAppVersionApi();
  //   print("AAAAAAAAAAAAAAAAA");
  //   print(latestAppVersion.toString());
  //   print("AAAAAAAAAAAAAAAAA");
  //   notifyListeners();
  // }

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
      //AppPreferences.instance.setUserDetails(jsonEncode(master.data!.user));
      // gUserType = master.data!.user!.roleId!.toString();
      // globalUserMaster = AppPreferences.instance.getUserDetails();
      // SplashViewModel().checkGlobalUserData();
    }
    notifyListeners();
  }

  Future<void> getAppVersionApi() async {
    CommonUtils.showProgressDialog();
    AppVersionMaster? master = await _services.api!.getAppVersionApi();
    CommonUtils.hideProgressDialog();
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
      latestAppVersion = master.data?.appVersion;
      //latestAppVersion = "1.0.1";
    }
    notifyListeners();
  }

  Future<void> checkAppVersion() async {
    if (latestAppVersion == null) {
      log('Latest app version is not available');
      return; // Exit if latest app version is not fetched
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String latestVersion = latestAppVersion.toString();
    log('Current app version =========> : $currentVersion <=========');
    log('Latest app version =========> : $latestVersion <=========');
    if (isVersionOutdated(currentVersion, latestVersion)) {
      forceUpdateBottomSheet();
    }
  }

  bool isVersionOutdated(String currentVersion, String latestVersion) {
    List<String> currentParts = currentVersion.split('.');
    List<String> latestParts = latestVersion.split('.');
    for (int i = 0; i < latestParts.length; i++) {
      int currentPart = int.parse(currentParts[i]);
      int latestPart = int.parse(latestParts[i]);
      if (currentPart < latestPart) {
        return true; // Current version is outdated
      } else if (currentPart > latestPart) {
        return false; // Current version is newer or up to date
      }
    }
    return false; // Versions are equal
  }

  void forceUpdateBottomSheet() {
    showModalBottomSheet(
      context: mainNavKey.currentContext!,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      backgroundColor: CommonColors.mWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.zero,
        ),
      ),
      builder: (_) {
        return IntrinsicHeight(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(top: 22, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        LocalImages.img_splash_logo,
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                    kCommonSpaceV20,
                    Text(
                      "New Update Available",
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 26),
                      child: Text(
                        "Update your Soliket app for a seamless experience with new features. You can keep using the app while we update in the background.",
                        overflow: TextOverflow.clip,
                        style: getAppStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        height: 55,
                        label: "Update App",
                        buttonColor: CommonColors.primaryColor,
                        labelColor: CommonColors.mWhite,
                        onPress: () {
                          openStoreListing();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> openStoreListing() async {
    const url = playStoreUrl;
    if (url.isNotEmpty) {
      await tryLaunch(url);
    } else {
      log("No URL provided for $url platform");
    }
  }

  Future<bool> tryLaunch(
    String link, {
    Function()? onCannotLaunch,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      try {
        return await launchUrl(
          uri,
          mode: mode,
          webViewConfiguration: const WebViewConfiguration(),
        );
      } catch (e) {
        log("Error launching $link: $e");
        onCannotLaunch?.call();
      }
    } else {
      log("Cannot launch $link");
      onCannotLaunch?.call();
    }
    return false;
  }
}
