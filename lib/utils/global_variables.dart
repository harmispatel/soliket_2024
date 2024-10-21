import 'package:flutter/material.dart';

import '../models/otp_master.dart';

bool connectivity = true, isNotifyConnectivity = false;
String languageCode = "en";
GlobalKey<NavigatorState> mainNavKey = GlobalKey();
String gUserId = "";
String gUserLocation = "";
String? deviceToken = "";
String deviceType = "";
UserData? globalUserMaster;
// DUserDetails? globalDUserMaster;
