import 'package:flutter/material.dart';

import '../models/otp_master.dart';

bool connectivity = true, isNotifyConnectivity = false;
String languageCode = "en";
GlobalKey<NavigatorState> mainNavKey = GlobalKey();
String gUserId = "";
String mapKey = "";
String razorpayKey = "";
String appColor = "";
String appName = "";
String gUserLocation = "";
String? deviceToken = "";
String deviceType = "";
String gUserLat = "";
String gUserLong = "";
UserData? globalUserMaster;
// DUserDetails? globalDUserMaster;
