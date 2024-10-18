import 'package:solikat_2024/models/otp_master.dart';

import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/login_master.dart';

abstract class BaseServices {
  Future<LoginMaster?> login({
    required Map<String, dynamic> params,
  });
  Future<OtpMaster?> verifyOtp({
    required Map<String, dynamic> params,
  });
  Future<OtpMaster?> resendOtp({
    required Map<String, dynamic> params,
  });
  Future<ConfirmLocationMaster?> confirmLocation({
    required Map<String, dynamic> params,
  });
  Future<CommonMaster?> logOut();
}
