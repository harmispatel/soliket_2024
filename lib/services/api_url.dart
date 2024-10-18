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
}

class DomainApiUrl {
  /* --- Local BASE_URL for domain user --- */
  static const String BASE_URL = "http://192.168.1.143/register_shop/api/";

  static const String REGISTER = "${BASE_URL}register";
  static const String LOGIN = "${BASE_URL}login";
  static const String DOMAIN_USER_DETAIL = "${BASE_URL}getUserDetails";
  static const String UPDATE = "${BASE_URL}updateUser";
}
