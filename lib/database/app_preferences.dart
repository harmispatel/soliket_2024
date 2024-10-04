import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
/* -------------------------------------------- Preference Constants -------------------------------------------- */

  // Constants for Preference-Name
  final String keyLoginDetails = "KEY_LOGIN_DETAILS";
  final String keyLanguageCode = "KEY_LANGUAGE_CODE";
  final String keyDeviceToken = "KEY_DEVICE_TOKEN";
  final String keyAccessToken = "keyAccessToken";
  final String keyLoginOption = "keyLoginOption";
  final String keyFCMToken = "keyFCMToken";
  final String keyUserDetails = "KEY_USER_DETAILS";
  final String keyDUserDetails = "KEY_D_USER_DETAILS";
  final String keyCurrencyDate = "keyCurrencyDate";
  final String keyCurrencyList = "keyCurrencyList";
  final String keyUserCurrency = "keyUserCurrency";

  static final AppPreferences instance = AppPreferences.internal();

  factory AppPreferences() => instance;

  static SharedPreferences? _pref;

  AppPreferences.internal();

  static Future<SharedPreferences> initPref() async {
    _pref = await SharedPreferences.getInstance();
    log("initAppPreferences called");
    return _pref!;
  }

  // Method to set auth token
  Future<bool> setAccessToken(String value) async {
    return _pref!.setString(keyAccessToken, value);
  }

  // Method to get auth token
  String getAccessToken() {
    return _pref!.getString(keyAccessToken) ?? "";
  }

  // Method to set login option
  Future<bool> setLoginOption(String value) async {
    return _pref!.setString(keyLoginOption, value);
  }

  // Method to get login option
  String getLoginOption() {
    return _pref!.getString(keyLoginOption) ?? "";
  }

  // Method to set user details
  Future<bool> setUserDetails(String value) {
    return _pref!.setString(keyUserDetails, value);
  }

  // Method to set domain user details
  Future<bool> setDomainUserDetails(String value) {
    return _pref!.setString(keyDUserDetails, value);
  }

  // Method to get user details
  // UserDetail? getUserDetails() {
  //   String? userDetails = _pref!.getString(keyUserDetails);
  //   if (userDetails != null && userDetails.isNotEmpty) {
  //     return UserDetail.fromJson(jsonDecode(userDetails));
  //   } else {
  //     return null;
  //   }
  // }
  //
  // // Method to get domain user details
  // DUserDetails? getDomainUserDetails() {
  //   String? dUserDetails = _pref!.getString(keyDUserDetails);
  //   if (dUserDetails != null && dUserDetails.isNotEmpty) {
  //     return DUserDetails.fromJson(jsonDecode(dUserDetails));
  //   } else {
  //     return null;
  //   }
  // }

  // Method to set last currency update date
  Future<bool> setCurrencyUpdateDate() async {
    return _pref!
        .setString(keyCurrencyDate, DateTime.now().toString().split(" ").first);
  }

  // Method to get last currency update date
  String getCurrencyUpdateDate() {
    return _pref!.getString(keyCurrencyDate) ?? "";
  }

  // Method to set user currency
  Future<bool> setUserCurrency(String value) async {
    return _pref!.setString(keyUserCurrency, value);
  }

  // Method to get user currency
  String getUserCurrency() {
    return _pref!.getString(keyUserCurrency) ?? "";
  }

  // Method to set currency list
  Future<bool> setCurrencyList(String value) {
    return _pref!.setString(keyCurrencyList, value);
  }

  // Method to set FCM token
  Future<bool> setFCMToken(String value) async {
    return _pref!.setString(keyFCMToken, value);
  }

  // Method to get FCM token
  String getFCMToken() {
    return _pref!.getString(keyFCMToken) ?? "";
  }

  // Method to set language code
  Future<bool> setLanguageCode(String value) {
    return _pref!.setString(keyLanguageCode, value);
  }

  // Method to get Language code
  String getLanguageCode() {
    return _pref!.getString(keyLanguageCode) ?? "";
  }

  Future<bool> clear() {
    return _pref!.clear();
  }
}
