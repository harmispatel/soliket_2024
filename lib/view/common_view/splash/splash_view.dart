import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/common_view/splash/splash_view_model.dart';

import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      getDeviceDetails();
    });
  }

  Future<void> getDeviceDetails() async {
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
      if (Platform.isAndroid) {
        deviceType = 'android';
      } else if (Platform.isIOS) {
        deviceType = 'iOS';
      } else {
        deviceType = 'Unknown';
        deviceToken = 'Unknown';
      }
      print("..............Device Type :: $deviceType");
      print("..............Device Token ::  $deviceToken");
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent, // Status bar color
    //       statusBarIconBrightness: Brightness.light,
    //       systemNavigationBarColor: CommonColors.primaryColor),
    // );
    mViewModel = Provider.of<SplashViewModel>(context);
    return Scaffold(
      // backgroundColor: CommonColors.primaryColor,
      body: Image.asset(
        height: kDeviceHeight,
        width: kDeviceWidth,
        LocalImages.img_splash_logo,
        fit: BoxFit.fill,
      ),
    );
  }
}
