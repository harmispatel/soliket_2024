class ApiUrl {
  /* --- local --- */
  // static const String BASE_URL = "http://192.168.1.143/taylor-made/api/v2/";

  /* --- live --- */
  static const String BASE_URL = "Https://newadmin.soliket.com/api/";

  static const String VERIFY_OTP = "${BASE_URL}verify_otp";
  static const String RESEND_OTP = "${BASE_URL}resend_otp";
  static const String LOGIN = "${BASE_URL}login";
  static const String LOGOUT = "${BASE_URL}logout";
  static const String CONFIRM_LOCATION = "${BASE_URL}confirm_location";
  static const String GET_HOMEPAGE = "${BASE_URL}get_homepage";
  static const String GET_PRODUCT_BY_CATEGORY =
      "${BASE_URL}get_product_by_category";
  static const String UPDATE_PROFILE = "${BASE_URL}update_profile";
  static const String GET_PROFILE = "${BASE_URL}get_profile";
  static const String GET_ADDRESS = "${BASE_URL}get_address";
  static const String GET_CART = "${BASE_URL}get_cart_list";
  static const String GET_COUPON = "${BASE_URL}get_coupon_list";
  static const String ADD_ADDRESS = "${BASE_URL}add_address";
  static const String ADD_TO_CART = "${BASE_URL}add_to_cart";
  static const String DELETE_ADDRESS = "${BASE_URL}delete_address";
  static const String UPDATE_ADDRESS = "${BASE_URL}update_address";
}

class DomainApiUrl {
  /* --- Local BASE_URL for domain user --- */
  static const String BASE_URL = "http://192.168.1.143/register_shop/api/";

  static const String REGISTER = "${BASE_URL}register";
  static const String LOGIN = "${BASE_URL}login";
  static const String DOMAIN_USER_DETAIL = "${BASE_URL}getUserDetails";
  static const String UPDATE = "${BASE_URL}updateUser";
}
