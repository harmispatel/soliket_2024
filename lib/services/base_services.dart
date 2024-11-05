import 'package:solikat_2024/models/otp_master.dart';

import '../models/address_master.dart';
import '../models/category_product_master.dart';
import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/get_cart_master.dart';
import '../models/home_master.dart';
import '../models/login_master.dart';
import '../models/product_master.dart';

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

  Future<OtpMaster?> updateProfile({
    required Map<String, dynamic> params,
    required String picture,
    String? fileKey,
  });

  Future<HomeMaster?> getHomePageApi({
    required Map<String, dynamic> params,
  });

  Future<GetCategoryProductMaster?> getCategoryProductApi({
    required Map<String, dynamic> params,
  });

  Future<ProfileMaster?> getProfileApi();

  Future<AddressMaster?> getAddressApi();

  Future<CommonMaster?> deleteAddressApi({
    required Map<String, dynamic> params,
  });

  Future<CommonMaster?> addAddressApi({
    required Map<String, dynamic> params,
  });

  Future<CommonMaster?> updateAddressApi({
    required Map<String, dynamic> params,
  });

  Future<CommonMaster?> addToCartApi({
    required Map<String, dynamic> params,
  });

  Future<GetCartMaster?> getCartApi();
}
