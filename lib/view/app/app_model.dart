import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../database/app_preferences.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';

class AppModel with ChangeNotifier {
  bool isLoading = true;
  bool darkTheme = false;
  String locale = AppConstants.LANGUAGE_ENGLISH;

  String displayCurrency = "";
  BuildContext? context;
  ConnectivityResult connectionStatus = ConnectivityResult.none;

  void changeLanguage() async {
    String locale = AppPreferences.instance.getLanguageCode();
    if (locale.isEmpty) {
      AppPreferences.instance.setLanguageCode(this.locale);
      locale = this.locale;
      CommonUtils.languageCode = locale;
    }
    this.locale = locale;
    CommonUtils.languageCode = locale;
    notifyListeners();
  }

  void updateTheme(bool theme) {
    darkTheme = theme;
    notifyListeners();
  }

  void attachContext(BuildContext context) {
    this.context = context;
  }
}
