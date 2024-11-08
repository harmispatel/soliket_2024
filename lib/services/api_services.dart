import 'dart:developer';
import 'dart:io';

import 'package:solikat_2024/models/brand_product_master.dart';
import 'package:solikat_2024/models/coupon_master.dart';
import 'package:solikat_2024/models/otp_master.dart';
import 'package:solikat_2024/services/api_url.dart';

import '../models/about_us_master.dart';
import '../models/address_master.dart';
import '../models/button_product_master.dart';
import '../models/cart_master.dart';
import '../models/category_product_master.dart';
import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/contact_us_master.dart';
import '../models/home_master.dart';
import '../models/login_master.dart';
import '../models/offer_product_master.dart';
import '../models/product_master.dart';
import '../models/sub_category_product_master.dart';
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

  @override
  Future<OtpMaster?> updateProfile({
    required Map<String, dynamic> params,
    required String picture,
    String? fileKey,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.UPDATE_PROFILE,
      postParams: params,
      images: picture.isNotEmpty ? [File(picture)] : [],
      fileKey: fileKey,
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
  Future<HomeMaster?> getHomePageApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_HOMEPAGE,
      postParams: params,
    );
    if (response != null) {
      try {
        return HomeMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<GetCategoryProductMaster?> getCategoryProductApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_PRODUCT_BY_CATEGORY,
      postParams: params,
    );
    if (response != null) {
      try {
        return GetCategoryProductMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ProfileMaster?> getProfileApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_PROFILE,
    );
    if (response != null) {
      try {
        return ProfileMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AddressMaster?> getAddressApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_ADDRESS,
    );
    if (response != null) {
      try {
        return AddressMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> deleteAddressApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.DELETE_ADDRESS,
      postParams: params,
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

  @override
  Future<CommonMaster?> addAddressApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.ADD_ADDRESS,
      postParams: params,
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

  @override
  Future<CommonMaster?> updateAddressApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.UPDATE_ADDRESS,
      postParams: params,
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

  @override
  Future<CommonMaster?> addToCartApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.ADD_TO_CART,
      postParams: params,
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

  @override
  Future<GetCartMaster?> getCartApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_CART,
    );
    if (response != null) {
      try {
        return GetCartMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<GetCouponMaster?> getCouponApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_COUPON,
    );
    if (response != null) {
      try {
        return GetCouponMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<SubCategoryProductMaster?> getSubCategoryProductApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_SUB_PRODUCT_BY_CATEGORY,
      postParams: params,
    );
    if (response != null) {
      try {
        return SubCategoryProductMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<BrandProductMaster?> getBrandProductApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_PRODUCT_BY_BRAND,
      postParams: params,
    );
    if (response != null) {
      try {
        return BrandProductMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<OfferProductMaster?> getOfferProductApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_PRODUCT_BY_OFFER,
      postParams: params,
    );
    if (response != null) {
      try {
        return OfferProductMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ButtonProductMaster?> getButtonProductApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_PRODUCT_BY_BUTTON,
      postParams: params,
    );
    if (response != null) {
      try {
        return ButtonProductMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ContactMaster?> getContactUsApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_CONTACT_US,
    );
    if (response != null) {
      try {
        return ContactMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AboutUsMaster?> getAboutUsApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_ABOUT_US,
    );
    if (response != null) {
      try {
        return AboutUsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
