import 'dart:developer';

import 'package:solikat_2024/models/otp_master.dart';
import 'package:solikat_2024/services/api_url.dart';

import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/login_master.dart';
import 'base_client.dart';
import 'base_services.dart';

class ApiServices extends BaseServices {
  AppBaseClient appBaseClient = AppBaseClient();

  @override
  Future<LoginMaster?> login({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.LOGIN,
      postParams: params,
    );
    if (response != null) {
      try {
        return LoginMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<OtpMaster?> verifyOtp({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.VERIFY_OTP,
      postParams: params,
    );
    if (response != null) {
      try {
        return OtpMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<OtpMaster?> resendOtp({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.RESEND_OTP,
      postParams: params,
    );
    if (response != null) {
      try {
        return OtpMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ConfirmLocationMaster?> confirmLocation({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.CONFIRM_LOCATION,
      postParams: params,
    );
    if (response != null) {
      try {
        return ConfirmLocationMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> logOut() async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.LOGOUT,
    );
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
