import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colors.dart';
import 'global_variables.dart';

const SizedBox kCommonSpaceV15 = SizedBox(height: 15);
const SizedBox kCommonSpaceV20 = SizedBox(height: 20);
const SizedBox kCommonSpaceV30 = SizedBox(height: 30);
const SizedBox kCommonSpaceV50 = SizedBox(height: 50);
const SizedBox kCommonSpaceV100 = SizedBox(height: 100);
const SizedBox kCommonSpaceV80 = SizedBox(height: 80);
const SizedBox kCommonSpaceH15 = SizedBox(width: 15);
const SizedBox kCommonSpaceH20 = SizedBox(width: 20);
const SizedBox kCommonSpaceV5 = SizedBox(height: 5);
const SizedBox kCommonSpaceV3 = SizedBox(height: 3);
const SizedBox kCommonSpaceH5 = SizedBox(width: 5);
const SizedBox kCommonSpaceV10 = SizedBox(height: 10);
const SizedBox kCommonSpaceH10 = SizedBox(width: 10);
const SizedBox kCommonSpaceH2 = SizedBox(width: 2);
const SizedBox kCommonSpaceH3 = SizedBox(width: 3);
const EdgeInsets kCommonScreenPadding = EdgeInsets.all(15);
const EdgeInsets kCommonScreenPaddingH = EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets kCommonScreenPaddingV = EdgeInsets.symmetric(vertical: 15);
const EdgeInsets kCommonScreenPadding10 = EdgeInsets.all(10);
const EdgeInsets kCommonScreenPadding5 = EdgeInsets.all(5);
ShapeBorder kCommonShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
double kDeviceWidth = MediaQuery.of(mainNavKey.currentContext!).size.width;
double kDeviceHeight = MediaQuery.of(mainNavKey.currentContext!).size.height;

const String appPackageName = 'com.soliket.customerapp&pcampaignid=web_share';
const String playStoreUrl =
    'https://play.google.com/store/apps/details?id=$appPackageName';

const String appStoreUrl = 'https://apps.apple.com/in/app/soliket/id6478860593';

final kSmallCircular = Transform.scale(
  scale: 0.7,
  child: const CircularProgressIndicator(
    strokeWidth: 2,
    color: CommonColors.mWhite,
  ),
);

EdgeInsets kCommonAllBottomPadding = EdgeInsets.fromLTRB(
  15,
  15,
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.bottom +
      (Platform.isIOS ? 10 : 15),
);

EdgeInsets kCommonAllTopPadding = EdgeInsets.fromLTRB(
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.top + 15,
  15,
  15,
);

EdgeInsets kCommonAllTopBottomPadding = EdgeInsets.fromLTRB(
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.top + 15,
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.bottom + 10,
);

var networkImageLoadBuilder =
    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
};

var networkImageLoadBuilderWhite =
    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: Colors.white,
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
};

TextStyle getAppStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
  Color? textDecorationColor,
  TextDecorationStyle? textDecorationStyle,
}) {
  return GoogleFonts.roboto(
    color: color ?? Colors.black87,
    letterSpacing: letterSpacing ?? 0.3,
    decoration: decoration,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decorationColor: textDecorationColor,
    decorationStyle: textDecorationStyle,
  );
}

class AppConstants {
  /* ------------------- Language Codes ------------------- */
  static const String LANGUAGE_ENGLISH = 'en';
  static const String LANGUAGE_HINDI = 'hi';
  static const int USD_ID = 197;

  /* ------------------- Images Link ------------------- */
  static const String networkPlaceHolder =
      "https://taylor-made.harmistechnology.com/public/assets/img/placeholder.jpg";

  /* ------------------- font families ------------------- */

  static const String OUTFIT_FONT = 'Outfit';

  /* ------------------- Login roles ------------------- */

  static const String customer = "customer"; // 1 ------ No bank details
  static const String seller = "seller"; // 2
  static const String model = "model"; // 3
  static const String measurer = "measurer"; // 4
  static const String repairStore = "repair_store"; // 5
  static const String deliveryStore = "delivery_store"; // 6
  static const String ticketOwner = "ticket_owner"; // 7 ------ No bank details
  static const String physicalStore = "physical_store"; // 8
  static const String manufacturer = "manufacturer"; // 9
  static const String deliveryAgent = "delivery_agent"; // 10
  static const String measurementRequester = "measurement_requester"; // 10

  /* ------------------- Category id ------------------- */

  static const int accessories = 14;
  static const int individualCampaign = 13;
  static const int womenClothing = 1;
  static const int menClothing = 3;
  static const int jewellery = 7;

  /* ------------------- PhysicalStore and Manufacturer Order status ------------------- */

  static const PENDING = 1;
  static const ACCEPTED = 2;
  static const REJECTED = 3;
  static const PRODUCTION = 4;
  static const COMPLETED = 5;

  /* ------------------- Payment history status ------------------- */

  static const UN_PAID = 2;
  static const PAID = 3;

  /* ------------------- Album type ------------------- */

  static const PUBLIC = 1;
  static const PRIVATE = 0;

  /* ------------------- Model appointment booking status ------------------- */

  static const STATUS_PENDING = 0;
  static const STATUS_CONFIRM = 1;
  static const STATUS_REJECT = 2;
  static const STATUS_COMPLETED = 3;

  /* ------------------- Seller request to model status ------------------- */

  static const REQUEST_PENDING = 0;
  static const REQUEST_CONFIRM = 1;
  static const REQUEST_REJECTED = 2;
  static const REQUEST_COMPLETED = 3;

  /* ------------------- Measurement appointment status ------------------- */

  static const MEASURE_STATUS_REJECTED = 5;
  static const MEASURE_STATUS_COMPLETED = 6;
  static const MEASURE_STATUS_ACCEPTED = 1;
  static const MEASURE_STATUS_EXPIRED = 7;
  static const MEASURE_STATUS_PENDING = 0;

  /* ------------------- File type ------------------- */
  static const ftImage = "image";
  static const ftVideo = "video";
  static const ftDocument = "document";

  static const PRODUCT_APPROVED = 1;
  static const PRODUCT_PENDING = 0;

  static const TYPE_SHOES = "shoes";
  static const TYPE_CLOTHES = "clothes";
  static const PAYPAL_PAYMENT_OPTION = "paypal";

  static const WALLET_STATUS_PENDING = 1;
  static const WALLET_STATUS_PAID = 2;

  static const Ticket_STATUS_PENDING = 1;
  static const Ticket_STATUS_ACTIVE = 2;
  static const Ticket_STATUS_USED = 3;
  static const Ticket_STATUS_EXPIRED = 4;

  /* delivery status */

  static const STORE_STATUS_PENDING = 1;
  static const STORE_STATUS_ACCEPT = 2;
  static const STORE_STATUS_RECEIVED_PARCEL = 3;
  static const STORE_STATUS_COLLECTED_PARCEL = 4;
  static const STORE_STATUS_DELIVERED_PARCEL = 5;
  static const STORE_STATUS_REJECT = 6;

  static const STORE_RECEIVE_PHOTO = "STORE_RECEIVE_PHOTO";
  static const STORE_DELIVER_PHOTO = "STORE_DELIVER_PHOTO";

  /* ------------------- Repair request status ------------------- */
  static const REPAIR_REQ_PENDING = 1;
  static const REPAIR_REQ_ACCEPT = 2;
  static const REPAIR_REQ_REJECT = 3;
  static const REPAIR_REQ_STARTED = 4;
  static const REPAIR_REQ_COMPLETED = 5;

  /* ------------------- Parcel type ------------------- */
  static const PARCEL_TYPE_PACKAGING = 1;
  static const PARCEL_TYPE_UNPACKAGING = 2;
  static const PARCEL_TYPE_RETURN = 3;

  /* ------------------- Verifcation status ------------------- */
  static String VERIFICATION_STATUS_PENDING = "pending";
  static String VERIFICATION_STATUS_VERIFIED = "verified";
}

class LikeType {
  static const albumPost = "albumPost";
  static const modelLike = "modelLike";
  static const modelPostLike = "modelPostLike";
}

class CommentType {
  static const modelComment = "modelComment";
  static const modelPostComment = "modelPostComment";
  static const albumPost = "albumPost";
}

class ReportType {
  static const modelPost = "modelpost";
  static const albumPost = "albumpost";
  static const modelProfile = "modelprofile";
}
