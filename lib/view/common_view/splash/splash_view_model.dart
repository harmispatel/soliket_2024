import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../database/app_preferences.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
import '../../location/location_donNot_allow_view.dart';
import '../../login/login_view.dart';

class SplashViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
    startTimer();
  }

  startTimer() async {
    // globalUserMaster = AppPreferences.instance.getUserDetails();
    //log("Stored User Details :: ${jsonEncode(AppPreferences.instance.getAccessToken())}");
    Future.delayed(const Duration(seconds: 2), () async {
      String accessToken = await AppPreferences.instance.getAccessToken();
      log('access token :: $accessToken');
      if (accessToken.isNotEmpty) {
        pushAndRemoveUntil(LocationDonNotAllowView());
      } else {
        pushAndRemoveUntil(LoginView());
      }
    });
  }
}
