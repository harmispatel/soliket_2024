import 'dart:developer';
import 'dart:io';

import 'package:solikat_2024/models/brand_product_master.dart';
import 'package:solikat_2024/models/coupon_master.dart';
import 'package:solikat_2024/models/get_info_master.dart';
import 'package:solikat_2024/models/get_order_master.dart';
import 'package:solikat_2024/models/otp_master.dart';
import 'package:solikat_2024/models/product_details_master.dart';
import 'package:solikat_2024/services/api_url.dart';

import '../models/about_us_master.dart';
import '../models/add_to_cart_api.dart';
import '../models/address_master.dart';
import '../models/app_credensials_master.dart';
import '../models/app_version_master.dart';
import '../models/button_product_master.dart';
import '../models/cancellation_policy_master.dart';
import '../models/cart_master.dart';
import '../models/category_master.dart';
import '../models/category_product_master.dart';
import '../models/check_delivery_available_master.dart';
import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/contact_us_master.dart';
import '../models/faq_master.dart';
import '../models/get_check_out_details_master.dart';
import '../models/home_master.dart';
import '../models/login_master.dart';
import '../models/notification_master.dart';
import '../models/offer_product_master.dart';
import '../models/order_details_master.dart';
import '../models/order_master.dart';
import '../models/privacy_policy_master.dart';
import '../models/profile_master.dart';
import '../models/return_policy_master.dart';
import '../models/search_master.dart';
import '../models/shipping_policy_master.dart';
import '../models/sub_category_product_master.dart';
import '../models/terms_and_conditions_master.dart';
import '../models/track_order_master.dart';
import '../models/transaction_history_master.dart';
import '../models/update_bill_details_master.dart';
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
  Future<AddToCartMaster?> addToCartApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.ADD_TO_CART,
      postParams: params,
    );
    if (response != null) {
      try {
        return AddToCartMaster.fromJson(response);
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

  @override
  Future<ProductDetailsMaster?> getProductDetailsApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_PRODUCT_DETAILS,
      postParams: params,
    );
    if (response != null) {
      try {
        return ProductDetailsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<FaqMaster?> getFaqApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_FAQ,
    );
    if (response != null) {
      try {
        return FaqMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<PrivacyPolicyMaster?> getPrivacyPolicyApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_PRIVACY_POLICY,
    );
    if (response != null) {
      try {
        return PrivacyPolicyMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<TermsAndConditionsMaster?> getTermsAndConditionsApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_TERMS_CONDITIONS,
    );
    if (response != null) {
      try {
        return TermsAndConditionsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ShippingPolicyMaster?> getShippingPolicyApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_SHIPPING_POLICY,
    );
    if (response != null) {
      try {
        return ShippingPolicyMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ReturnPolicyMaster?> getReturnPolicyApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_RETURN_POLICY,
    );
    if (response != null) {
      try {
        return ReturnPolicyMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CancellationPolicyMaster?> getCancellationPolicyApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_CANCELLATION_POLICY,
    );
    if (response != null) {
      try {
        return CancellationPolicyMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> deleteAccount() async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.DELETE_ACCOUNT,
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
  Future<NotificationMaster?> getNotificationApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_NOTIFICATION,
      postParams: params,
    );
    if (response != null) {
      try {
        return NotificationMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<TransactionHistoryMaster?> getTransactionHistoryApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.GET_TRANSACTION_HISTORY,
      postParams: params,
    );
    if (response != null) {
      try {
        return TransactionHistoryMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<SearchMaster?> getSearchDataApi({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.SEARCH_PRODUCT,
      postParams: params,
    );
    if (response != null) {
      try {
        return SearchMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AppVersionMaster?> getAppVersionApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_APP_VERSION,
    );
    if (response != null) {
      try {
        return AppVersionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> setDefaultAddress({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.SET_DEFAULT_ADDRESS,
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
  Future<CategoryMaster?> getCategoryApi() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_CATEGORY,
    );
    if (response != null) {
      try {
        return CategoryMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> applyCoupon({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.APPLY_COUPON,
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
  Future<CommonMaster?> removeCoupon({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.REMOVE_COUPON,
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
  Future<UpdateBillDetailsMaster?> updateBillDetails() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.UPDATE_BILL_DETAILS,
    );
    if (response != null) {
      try {
        return UpdateBillDetailsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CheckDeliveryAvailableMaster?> checkDeliveryAvailable({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.CHECK_DELIVERY_AVAILABLE,
      postParams: params,
    );
    if (response != null) {
      try {
        return CheckDeliveryAvailableMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<OrderMaster?> placeOrder({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.PLACE_ORDER,
      postParams: params,
    );
    if (response != null) {
      try {
        return OrderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> confirmOrder({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.CONFIRM_ORDER,
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
  Future<GetOrderMaster?> getOrder({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.MY_ORDER,
      postParams: params,
    );
    if (response != null) {
      try {
        return GetOrderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<OrderDetailsMaster?> getOrderDetails({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.ORDER_DETAILS,
      postParams: params,
    );
    if (response != null) {
      try {
        return OrderDetailsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<TrackOrderMaster?> trackingOrder({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.TRACK_ORDER,
      postParams: params,
    );
    if (response != null) {
      try {
        return TrackOrderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<getInfoMaster?> getInfoPopUp() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_INFO_POPUP,
    );
    if (response != null) {
      try {
        return getInfoMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AppCredentialsMaster?> getAppCredensials() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.GET_APP_CREDENSIALS,
    );
    if (response != null) {
      try {
        return AppCredentialsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> cancelOrder({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.CANCEL_ORDER,
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
  Future<GetCheckOutDetailsMaster?> getCheckOutDetails() async {
    dynamic response = await appBaseClient.getApiCall(
      url: ApiUrl.CHECK_OUT_DETAILS,
    );
    if (response != null) {
      try {
        return GetCheckOutDetailsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
