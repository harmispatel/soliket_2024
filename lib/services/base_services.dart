import 'package:solikat_2024/models/coupon_master.dart';
import 'package:solikat_2024/models/otp_master.dart';
import 'package:solikat_2024/models/product_details_master.dart';
import 'package:solikat_2024/models/return_policy_master.dart';

import '../models/about_us_master.dart';
import '../models/address_master.dart';
import '../models/brand_product_master.dart';
import '../models/button_product_master.dart';
import '../models/cancellation_policy_master.dart';
import '../models/cart_master.dart';
import '../models/category_product_master.dart';
import '../models/common_master.dart';
import '../models/confirm_location_master.dart';
import '../models/contact_us_master.dart';
import '../models/faq_master.dart';
import '../models/home_master.dart';
import '../models/login_master.dart';
import '../models/notification_master.dart';
import '../models/offer_product_master.dart';
import '../models/privacy_policy_master.dart';
import '../models/product_master.dart';
import '../models/shipping_policy_master.dart';
import '../models/sub_category_product_master.dart';
import '../models/terms_and_conditions_master.dart';
import '../models/transaction_history_master.dart';

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

  Future<GetCouponMaster?> getCouponApi();

  Future<SubCategoryProductMaster?> getSubCategoryProductApi({
    required Map<String, dynamic> params,
  });

  Future<BrandProductMaster?> getBrandProductApi({
    required Map<String, dynamic> params,
  });

  Future<OfferProductMaster?> getOfferProductApi({
    required Map<String, dynamic> params,
  });

  Future<ButtonProductMaster?> getButtonProductApi({
    required Map<String, dynamic> params,
  });

  Future<ContactMaster?> getContactUsApi();

  Future<AboutUsMaster?> getAboutUsApi();

  Future<FaqMaster?> getFaqApi();

  Future<ProductDetailsMaster?> getProductDetailsApi({
    required Map<String, dynamic> params,
  });

  Future<PrivacyPolicyMaster?> getPrivacyPolicyApi();

  Future<TermsAndConditionsMaster?> getTermsAndConditionsApi();

  Future<ShippingPolicyMaster?> getShippingPolicyApi();

  Future<ReturnPolicyMaster?> getReturnPolicyApi();

  Future<CancellationPolicyMaster?> getCancellationPolicyApi();

  Future<CommonMaster?> deleteAccount();

  Future<NotificationMaster?> getNotificationApi();

  Future<TransactionHistoryMaster?> getTransactionHistoryApi();
}
