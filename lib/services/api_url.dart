import '../core/remote_config/remote_global_config.dart';

class ApiUrl {
  static var appDownConfig = RemoteGlobalConfig.remoteGlobalModel.appDownMaster;

  /* --- local --- */
  // static   String BASE_URL = "http://192.168.1.143/taylor-made/api/v2/";

  /* --- live --- */

  static String BASE_URL = appDownConfig?.apiBaseUrl ?? '';

  // static String BASE_URL = "Https://newadmin.soliket.com/api/";

  static String VERIFY_OTP = "${BASE_URL}verify_otp";
  static String RESEND_OTP = "${BASE_URL}resend_otp";
  static String LOGIN = "${BASE_URL}login";
  static String LOGOUT = "${BASE_URL}logout";
  static String CONFIRM_LOCATION = "${BASE_URL}confirm_location";
  static String GET_HOMEPAGE = "${BASE_URL}get_homepage";
  static String GET_PRODUCT_BY_CATEGORY = "${BASE_URL}get_product_by_category";
  static String UPDATE_PROFILE = "${BASE_URL}update_profile";
  static String GET_PROFILE = "${BASE_URL}get_profile";
  static String GET_ADDRESS = "${BASE_URL}get_address";
  static String GET_CART = "${BASE_URL}get_cart_list";
  static String GET_COUPON = "${BASE_URL}get_coupon_list";
  static String ADD_ADDRESS = "${BASE_URL}add_address";
  static String ADD_TO_CART = "${BASE_URL}add_to_cart";
  static String DELETE_ADDRESS = "${BASE_URL}delete_address";
  static String UPDATE_ADDRESS = "${BASE_URL}update_address";
  static String GET_PRODUCT_BY_BRAND = "${BASE_URL}get_product_by_brand";
  static String GET_PRODUCT_BY_OFFER = "${BASE_URL}get_product_by_offer";
  static String GET_CONTACT_US = "${BASE_URL}get_contact_us";
  static String GET_ABOUT_US = "${BASE_URL}get_about_us";
  static String GET_FAQ = "${BASE_URL}get_faq";
  static String GET_PRODUCT_BY_BUTTON = "${BASE_URL}get_product_by_button";
  static String GET_SUB_PRODUCT_BY_CATEGORY =
      "${BASE_URL}get_product_by_subcategory";
  static String GET_PRODUCT_DETAILS = "${BASE_URL}get_product_details";
  static String SEARCH_PRODUCT = "${BASE_URL}search_product";
  static String GET_PRIVACY_POLICY = "${BASE_URL}get_privacy_policy";
  static String GET_TERMS_CONDITIONS = "${BASE_URL}get_term_conditions";
  static String GET_SHIPPING_POLICY = "${BASE_URL}get_shipping_policy";
  static String GET_RETURN_POLICY = "${BASE_URL}get_return_policy";
  static String GET_CATEGORY = "${BASE_URL}get_category_list";
  static String GET_CANCELLATION_POLICY = "${BASE_URL}get_cancellation_policy";
  static String DELETE_ACCOUNT = "${BASE_URL}delete_account";
  static String SET_DEFAULT_ADDRESS = "${BASE_URL}set_default_address";
  static String APPLY_COUPON = "${BASE_URL}apply_coupon_code";
  static String REMOVE_COUPON = "${BASE_URL}remove_coupon_code";
  static String UPDATE_BILL_DETAILS = "${BASE_URL}update_bill_details";
  static String GET_INFO_POPUP = "${BASE_URL}get_info_popup";
  static String PLACE_ORDER = "${BASE_URL}place_order";
  static String CONFIRM_ORDER = "${BASE_URL}confirm_order";
  static String MY_ORDER = "${BASE_URL}my_order";
  static String ORDER_DETAILS = "${BASE_URL}order_details";
  static String TRACK_ORDER = "${BASE_URL}track_order";
  static String CANCEL_ORDER = "${BASE_URL}cancel_order";
  static String CHECK_DELIVERY_AVAILABLE = "${BASE_URL}check_delivery_or_not";
  static String GET_NOTIFICATION = "${BASE_URL}get_notification_list";
  static String GET_TRANSACTION_HISTORY = "${BASE_URL}get_transaction_list";
  static String GET_APP_VERSION = "${BASE_URL}get_app_version";
  static String CHECK_OUT_DETAILS = "${BASE_URL}checkout";
  static String GET_APP_CREDENSIALS = "${BASE_URL}get_soliket_credensials";
}

class DomainApiUrl {
  /* --- Local BASE_URL for domain user --- */
  static String BASE_URL = "http://192.168.1.143/register_shop/api/";
  static String REGISTER = "${BASE_URL}register";
  static String LOGIN = "${BASE_URL}login";
  static String DOMAIN_USER_DETAIL = "${BASE_URL}getUserDetails";
  static String UPDATE = "${BASE_URL}updateUser";
}
