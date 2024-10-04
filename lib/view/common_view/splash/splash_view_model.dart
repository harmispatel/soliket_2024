import 'dart:async';

import 'package:flutter/material.dart';

import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
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
      // if (globalUserMaster == null) {
      //   pushReplacement(const WelcomeView());
      // } else {
      //   gUserType = globalUserMaster!.userType!;
      //   getUserDetails();
      //   LoginViewModel().login(userType: gUserType);
      // }
      // await pushAndRemoveUntil(const HomeView());
      await pushAndRemoveUntil(const LoginView());
    });
  }
}
