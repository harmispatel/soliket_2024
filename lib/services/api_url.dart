class ApiUrl {
  /* --- local --- */
  // static const String BASE_URL = "http://192.168.1.143/taylor-made/api/v2/";

  /* --- live --- */
  static const String BASE_URL =
      "https://taylor-made.harmistechnology.com/api/v2/";

  static const String SIGN_UP = "${BASE_URL}auth/signup";
  static const String VERIFY_OTP = "${BASE_URL}auth/confirm_code";
  static const String RESEND_OTP = "${BASE_URL}auth/resend_code";
  static const String LOGIN = "${BASE_URL}auth/login";
  static const String FORGOT_PASSWORD =
      "${BASE_URL}auth/password/forget_request";
  static const String VERIFY_FORGOT = "${BASE_URL}auth/password/confirm_reset";
  static const String USER_DETAIL = "${BASE_URL}auth/user";
  static const String RESEND_PASSWORD = "${BASE_URL}auth/password/resend_code";
  static const String NEW_PRODUCT = "${BASE_URL}new-product";
  static const String SALE_PRODUCT = "${BASE_URL}sale-product";
  static const String WISHLIST = "${BASE_URL}wishlists";
  static const String PRODUCTDETAILS = "${BASE_URL}customer/products/details/";
  static const String DIRECT_COMPLETED_MEASURER =
      "${BASE_URL}direct-completed-measures";
  static const String SHOW_USER_MEASUREMENT =
      "${BASE_URL}show-user-measurement";
  static const String FAV_ADD_REMOVE =
      "${BASE_URL}wishlists-add-remove-product";
  static const String CART_LIST = "${BASE_URL}carts/customer-list";
  static const String UPDATE_PROFILE = "${BASE_URL}profile/customer-update";
  static const String UPDATE_EMAIL = "${BASE_URL}profile/email-update";
  static const String RELATED_PRODUCT = "${BASE_URL}products/related/";
  static const String ALL_PRODUCT = "${BASE_URL}all-product";
  static const String PRODUCT_MEASUREMENT_LIST =
      "${BASE_URL}product/product_measurement_list";
  static const String BOOKED_ORDER_LIST = "${BASE_URL}store/myBookedOrder";
  static const String SHIPPING_LIST = "${BASE_URL}shipping-info";
  static const String PURCHASE_HISTORY = "${BASE_URL}purchase-history";
  static const String PURCHASE_HISTORY_DETAILS =
      "${BASE_URL}purchase-history-details/";
  static const String LOGOUT = "${BASE_URL}auth/logout";
  static const String GET_COUNTRY_LIST = "${BASE_URL}countries";
  static const String GET_STATE_LIST_BY_COUNTRY =
      "${BASE_URL}states-by-country/";
  static const String GET_CITY_LIST_BY_STATE = "${BASE_URL}cities-by-state/";
  static const String GET_CITY_LIST = "${BASE_URL}cities";
  static const String CREATE_SHIPPING = "${BASE_URL}user/shipping/create";
  static const String UPDATE_SHIPPING = "${BASE_URL}user/shipping/update";
  static const String DELETE_SHIPPING = "${BASE_URL}user/shipping/delete/";
  static const String MAKE_DEFAULT_SHIPPING =
      "${BASE_URL}user/shipping/make_default";
  static const String PARTNER_SHOP = "${BASE_URL}myPartnerShopsOrManufacturer";
  static const String ORDERS_REQUEST = "${BASE_URL}myOrderRequest";
  static const String NOTIFY = "${BASE_URL}notify";
  static const String CONNECTION_REQUEST_LIST =
      "${BASE_URL}ConnectionRequestList";
  static const String ACCEPT_OR_REJECT_CONNECTION =
      "${BASE_URL}acceptOrRejectConnectionCodeRequest";
  static const String ACCEPT_OR_REJECT_ORDER =
      "${BASE_URL}acceptOrRejectOrderRequest";
  static const String SEARCH_CONNECTION_CODE =
      "${BASE_URL}searchConnectionCode";
  static const String SEND_CONNECTION_REQUEST =
      "${BASE_URL}sendConnectionRequest";
  static const String MANUFACTURER_LIST = "${BASE_URL}manufacurerList";
  static const String CREATE_PHYSICAL_STORE_ORDER = "${BASE_URL}createOrder";
  static const String DELETE_ORDER = "${BASE_URL}deleteOrder";

  // static const String BOOKING_LIST = "${BASE_URL}myBookings";
  static const String DELIVERY_STORE_AVAILABILITY =
      "${BASE_URL}deliveryStoreAvailability";
  static const String DELIVERY_STORE_AVAILABILITY_BY_ID =
      "${BASE_URL}deliveryStoreAvailabilityById";
  static const String MEASURER_AVAILABILITY_BY_ID =
      "${BASE_URL}measurer/measurerAvailabilityById";
  static const String REPAIR_STORE_AVAILABILITY =
      "${BASE_URL}repairStore/availablity";
  static const String ADD_UPDATE_REPAIR_STORE_AVAILABILITY =
      "${BASE_URL}addOrUpdateRepairStoreAvailability";
  static const String ADD_UPDATE_DELIVERY_STORE_AVAILABILITY =
      "${BASE_URL}addOrUpdateDeliveryStoreAvailability";
  static const String REPAIR_SERVICES = "${BASE_URL}repairStore/service";
  static const String ADD_UPDATE_REPAIR_SERVICE =
      "${BASE_URL}repairStore/service/add-update";
  static const String DELETE_REPAIR_SERVICE =
      "${BASE_URL}repairStore/service/delete";
  static const String ADD_UPDATE_BENK_DETAILS =
      "${BASE_URL}bank-detail/add-update";
  static const String GET_REPAIR_REQUEST_LIST =
      "${BASE_URL}repairStore/repair-request";
  static const String REPAIRER_PH = "${BASE_URL}repairStore/paymentHistory";
  static const String GET_REPAIRER_WITHDRAW_REQUEST_LIST =
      "${BASE_URL}repairStore/withdraw/list";
  static const String REPAIRER_SEND_WITHDRAWAL_REQUEST =
      "${BASE_URL}repairStore/repairStoreSendWithdrawRequest";
  static const String GET_SUPPORT_TICKET_LIST =
      "${BASE_URL}support-ticket/list";
  static const String CREATE_SUPPORT_TICKET =
      "${BASE_URL}support-ticket/create";
  static const String MODEL_PHOTO_OR_VIDEO_UPLOAD =
      "${BASE_URL}model/model-upload-image";

  //static const String ALBUM_LIST = "${BASE_URL}model/albums-list";
  static const String GET_SUPPORT_TICKET_DETAILS =
      "${BASE_URL}support-ticket/viewDetails";
  static const String REPLY_SUPPORT_TICKET = "${BASE_URL}support-ticket/reply";
  static const String SUPPORT_TICKET_REPLY_LIST =
      "${BASE_URL}support-ticket/replyList";
  static const String MY_ALBUM_LIST = "${BASE_URL}model/my-albums-list";
  static const String MODEL_LIST = "${BASE_URL}model/model-list";
  static const String ALBUM_LIST = "${BASE_URL}model/albums-list";
  static const String GALLERY_LIST = "${BASE_URL}model/modelGalleryList";
  static const String Model_LIKE = "${BASE_URL}modelLike";
  static const String ADD_UPDATE_ALBUM = "${BASE_URL}model/albums-add-update";
  static const String GET_ALBUM_POST_APPROVAL_LIST =
      "${BASE_URL}model/album-post-approval";
  static const String ALBUM_POST_APPROVA_OR_REJECT =
      "${BASE_URL}model/post-approval";
  static const String DELETE_ALBUM = "${BASE_URL}model/albums-delete";
  static const String MODEL_POST = "${BASE_URL}model/single-model-gallery";
  static const String DELETE_MODEL_POST =
      "${BASE_URL}model/delete-model-picture";
  static const String MODEL_ALBUM = "${BASE_URL}model/album-post-list";
  static const String APPOINTMENT_MODEL =
      "${BASE_URL}model/appointment-for-modeling";
  static const String UPDATE_STATUS =
      "${BASE_URL}model/update-request-model-status";
  static const String COMPLETE_APPOINTMENT =
      "${BASE_URL}model/complete-appointment";
  static const String ADD_COMMENT = "${BASE_URL}comment/add";
  static const String VERIFY_ACCESS_CODE = "${BASE_URL}verify-accesscode";
  static const String ADD_MODEL_DETAILS =
      "${BASE_URL}model/store-model-details";
  static const String SELLER_ORDERS = "${BASE_URL}seller/orders";
  static const String SELLER_ORDERS_DETAILS =
      "${BASE_URL}seller/orders-details";
  static const String SELLER_PRODUCT_LIST = "${BASE_URL}seller/product-list";
  static const String GET_FILE_LIST = "${BASE_URL}seller/upload-list";
  static const String UPLOAD_FILE = "${BASE_URL}upload-file";
  static const String DELETE_UPLOADED_FILE = "${BASE_URL}upload-destroy";
  static const String PRODUCT_FEATURE_UPDATE =
      "${BASE_URL}seller/product-update-featured";
  static const String PRODUCT_PUBLISH_UPDATE =
      "${BASE_URL}seller/product-update-published";
  static const String PRODUCT_DUPLICATE = "${BASE_URL}seller/product-duplicate";
  static const String PRODUCT_DELETE = "${BASE_URL}seller/product-destroy";
  static const String GET_SELLER_COUPON_LIST = "${BASE_URL}seller/coupon-list";
  static const String SELLER_COUPON_DELETE = "${BASE_URL}seller/coupon-destroy";
  static const String SELLER_PAYMENT_HISTORY =
      "${BASE_URL}seller/payment-history";
  static const String SELLER_COMMISSION_HISTORY =
      "${BASE_URL}seller/commission-history";
  static const String SELLER_ALL_POST = "${BASE_URL}seller/view-all-post";
  static const String PRODUCT_LIST_FOR_COUPON =
      "${BASE_URL}seller/coupon-product-list";
  static const String COUPON_ADD_UPDATE = "${BASE_URL}seller/coupon-add-update";
  static const String GET_COUPON_DETAIL = "${BASE_URL}seller/coupon-edit";
  static const String PROFILE_NAME = "${BASE_URL}seller/profile-name";
  static const String GET_BRANDS = "${BASE_URL}seller/brand-name";
  static const String REQUEST_TO_MODEL =
      "${BASE_URL}seller/request-to-model-list";
  static const String SELLER_TOP_PRODUCT = "${BASE_URL}seller/top-product-list";
  static const String COMMENT_LIST = "${BASE_URL}seller/all-comment-list";
  static const String MODEL_ALBUM_LIST = "${BASE_URL}seller/model-album-list";
  static const String MODEL_ALBUM_POST =
      "${BASE_URL}seller/model-album-post-list";
  static const String MODEL_DETAILS_LIST =
      "${BASE_URL}seller/model-details-list";
  static const String Seller_DASHBOARD_COUNT =
      "${BASE_URL}seller/dashboard-counts";
  static const String MEASURER_APPOINTMENT =
      "${BASE_URL}measurer/appointment-list";
  static const String COMPLETE_MEASURER_APPOINTMENT =
      "${BASE_URL}measurer/completed-measures-list";
  static const String UPDATE_APPOINTMENT_STATUS =
      "${BASE_URL}measurer/acceptRejectOrMarkAppointment";
  static const String ADD_NEW_PRODUCT = "${BASE_URL}seller/storeProduct";
  static const String GET_CATEGORY = "${BASE_URL}seller/product-category";
  static const String GET_COLORS = "${BASE_URL}seller/product-color";
  static const String NEARBY_REPAIRER = "${BASE_URL}seller/nearby-repairer";
  static const String services = "${BASE_URL}repairStore/service";
  static const String GET_ATTRIBUTE = "${BASE_URL}seller/product-attribute";
  static const String GET_ATTRIBUTE_VALUE =
      "${BASE_URL}seller/product-attribute-value";
  static const String SERVICES = "${BASE_URL}repairStore/service";
  static const String BOOK_SERVICES =
      "${BASE_URL}repairStore/bookRepairStoreService";
  static const String SERVICE_DETAILS =
      "${BASE_URL}repairStore/repairerServiceDetails";
  static const String ADD_SHOP = "${BASE_URL}shops/update-info";
  static const String GET_EDIT_PRODUCT_DETAILS =
      "${BASE_URL}seller/products/details";
  static const String SELLER_UPDATE_EMAIL = "${BASE_URL}seller/update_email";
  static const String SELLER_UPDATE_PROFILE =
      "${BASE_URL}seller/updateSellerProfile";
  static const String SELLER_PROFILE_TYPE = "${BASE_URL}seller/profileType";
  static const String SELLER_MEMBERSHIP_REQ =
      "${BASE_URL}seller/membershipRequestStore";
  static const String CHAT_LIST = "${BASE_URL}measurer/conversation-list";
  static const String SET_COMMISSION = "${BASE_URL}user/setCommission";
  static const String SUBMIT_MEASUREMENTS =
      "${BASE_URL}measurer/clothesOrShoesMeasurements";
  static const String SUBMIT_VIDEO =
      "${BASE_URL}measurer/recordMeasurementVideo";
  static const String ADD_OR_UPDATE_MEASURER_AVAILABILITY =
      "${BASE_URL}measurer/addOrUpdateMeasurerAvailability";
  static const String MEASURER_AVAILABILITY =
      "${BASE_URL}measurer/measurerAvailablity";
  static const String MEASURER_WITHDRAW_HISTORY =
      "${BASE_URL}measurer/withdrawRequestPaymentHistory";
  static const String ORDER_PAYMENT_HISTORY =
      "${BASE_URL}measurer/orderCommissionPaymentHistory";
  static const String SEND_WITHDRAW_REQUEST =
      "${BASE_URL}measurer/measurerStoreSendWithdrawRequest";
  static const String FOLLOW_UPDATE = "${BASE_URL}user/follow";
  static const String GET_DELIVERY_REQUEST = "${BASE_URL}getDeliveryRequest";
  static const String COMMENT_REPLY = "${BASE_URL}comment/reply";
  static const String USER_TICKET_LIST = "${BASE_URL}user/ticketList";
  static const String PURCHASE_TICKET = "${BASE_URL}user/purchaseStoreTicket";
  static const String UPDATE_TICKET = "${BASE_URL}updateTicketDetails";
  static const String GET_WALLET_TRANSACTION = "${BASE_URL}orderPaymentHistory";
  static const String SEND_DELIVERY_STORE_WITHDRAWAL_REQUEST =
      "${BASE_URL}deliveryStoreSendWithdrawRequest";
  static const String DELIVERY_STORE_WITHDRAW_REQUEST_HISTORY =
      "${BASE_URL}withDrawRequestHistory";
  static const String UPDATE_BOOKING_STATUS = "${BASE_URL}confirmOrRejectOrder";
  static const String BOOKED_ORDERS = "${BASE_URL}myBookedDeliveryStoreList";
  static const String CONTRACT_EMAIL = "${BASE_URL}contractEmailAddressList";
  static const String UPDATE_DELIVERY_ORDER = "${BASE_URL}updateDeliveryOrder";
  static const String SEND_ALERT_REQUEST_LIST =
      "${BASE_URL}sendAlertRequestList";
  static const String VALID_TICKET = "${BASE_URL}validTicket";
  static const String GET_NEARBY_DELIVERY_STORE =
      "${BASE_URL}getNearByDeliveryStore";
  static const String SEND_ALERTS_TO_STORES =
      "${BASE_URL}sendAlertRequestToDeliveryStore";
  static const String BOOKABLE_SPACE_LIST = "${BASE_URL}bookableSpaceList";
  static const String SEND_REQUEST_TO_STORE =
      "${BASE_URL}sendRequestToDeliveryStore";
  static const String SEND_MESSAGE = "${BASE_URL}measurer/send-message";
  static const String ADD_EDIT_CONTRACT_EMAIL =
      "${BASE_URL}addContractEmailAddress";
  static const String GET_CHAT_LIST_MESSAGE =
      "${BASE_URL}measurer/list-message";
  static const String COLLECT_PARCEL = "${BASE_URL}collect-parcel";
  static const String UPDATE_PRODUCT = "${BASE_URL}seller/updateProduct";
  static const String UPDATE_REPAIR_REQUEST =
      "${BASE_URL}repairStore/acceptOrRejectRepairStoreOrder";
  static const String SHOP_DETAILS = "${BASE_URL}shops/details";
  static const String SELLER_WALLET_HISTORY = "${BASE_URL}shops/details";
  static const String SELLER_WITHDRAW_REQUEST = "${BASE_URL}shops/details";
  static const String CREATE_MODEL_APPOINTMENT =
      "${BASE_URL}modelAppointmentCreate";
  static const String CREATE_PARCEL_RECORD = "${BASE_URL}createParcelRecord";
  static const String GET_PARCEL_RECORD_LIST = "${BASE_URL}ParcelRecordList";
  static const String GET_NEAR_BY_USER_COMMON = "${BASE_URL}nearByUser";
  static const String CREATE_REQUESTER_MEASUREMETN_APPOINTMENT =
      "${BASE_URL}createMeasurerAppointment";
  static const String GET_REQUESTER_CREATED_APPOINTMENT =
      "${BASE_URL}measurement-appointments";
  static const String CREATE_CONVERSATION = "${BASE_URL}createConversation";
  static const String RECORD_PACKAGE = "${BASE_URL}videoRecords";
  static const String SENT_MAIL = "${BASE_URL}sentMailToTicketOwner";
  static const String ADD_TO_CART = "${BASE_URL}carts/add";
  static const String REMOVE_CART_ITEM = "${BASE_URL}removeCartItem";
  static const String ADD_TO_FAVOURITE_STYLE = "${BASE_URL}addFavouriteStyle";
  static const String CUSTOMER_ORDER_CREATE = "${BASE_URL}orderCreate";
  static const String SUBMIT_REVIEW = "${BASE_URL}reviews/submit";
  static const String PRODUCT_REVIEW_LIST = "${BASE_URL}productReviewList";
  static const String PAY_COMMISSION_TO_MEASURER =
      "${BASE_URL}payCommissionToMeasurer";
  static const String GET_CURRENCY_LIST = "${BASE_URL}currencies";
  static const String PAY_SELLER_REPAIR_REQUEST =
      "${BASE_URL}doRepairerOrderPayment";
  static const String GET_REPORT_OPTION_LIST = "${BASE_URL}optionList";
  static const String GET_NOTIFICATION_LIST = "${BASE_URL}notificationList";
  static const String READ_NOTIFICATION_API = "${BASE_URL}readNotification";
  static const String UPDATE_CHATTED_WITH = "${BASE_URL}updateChattedWith";
  static const String READ_ALL_MESSAGES = "${BASE_URL}readMessage";
  static const String GET_CONVERSION_COUNT = "${BASE_URL}unReadMessageCount";
  static const String VERIFY_ACCOUNT = "${BASE_URL}verifyAccount";
  static const String SEARCH_LOCATION = "${BASE_URL}searchLocation";
  static const String CREATE_REPORT = "${BASE_URL}createReport";
  static const String RECHARGE_WALLET = "${BASE_URL}rechargeWallet";
}

class DomainApiUrl {
  /* --- Local BASE_URL for domain user --- */
  static const String BASE_URL = "http://192.168.1.143/register_shop/api/";

  static const String REGISTER = "${BASE_URL}register";
  static const String LOGIN = "${BASE_URL}login";
  static const String DOMAIN_USER_DETAIL = "${BASE_URL}getUserDetails";
  static const String UPDATE = "${BASE_URL}updateUser";
}
