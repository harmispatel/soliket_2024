import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/i18n.dart';
import '../utils/constant.dart';
import '../widget/primary_button.dart';
import 'common_colors.dart';
import 'global_variables.dart';

class Screen {
  static double height() {
    return MediaQuery.of(mainNavKey.currentContext!).size.height;
  }

  static double width() {
    return MediaQuery.of(mainNavKey.currentContext!).size.width;
  }

  static double bottomPadding() {
    return MediaQuery.of(mainNavKey.currentContext!).viewPadding.bottom;
  }

  static double topPadding() {
    return MediaQuery.of(mainNavKey.currentContext!).viewPadding.top;
  }
}

Future<dynamic> push(Widget screen) async {
  return await Navigator.push(mainNavKey.currentContext!,
      /*Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          :*/
      CupertinoPageRoute(builder: (context) {
    return screen;
  }));
}

pushAndRemoveUntil(Widget screen) async {
  Navigator.pushAndRemoveUntil(mainNavKey.currentContext!,
      /*Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          :*/
      CupertinoPageRoute(builder: (context) {
    return screen;
  }), (route) => false);
}

void pushReplacement(Widget screen) async {
  Navigator.pushReplacement(mainNavKey.currentContext!,
      /*Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          :*/
      CupertinoPageRoute(
    builder: (context) {
      return screen;
    },
  ));
}

String getFormattedDate(DateTime dateTime, String format) {
  try {
    //final DateFormat formatter = DateFormat('d MMM y, HH:mm');
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(dateTime);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
  }
  return "--";
}

String getFormattedDateBookingAsset(DateTime dateTime) {
  try {
    log("Date $dateTime");
    //  final DateFormat formatter = DateFormat('d MMM y, HH:mm');
    final DateFormat formatter = DateFormat('MMM d');
    final String formatted = formatter.format(dateTime);
    log("Format Date $formatted");
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getFormattedTimeBooking(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
  }
  return "";
}

String getSelectedDateFormat(DateTime dateTime) {
  try {
    final DateFormat formatter =
        DateFormat("MMM d'${getDayOfMonthSuffix(dateTime.day)}' yyyy");
    final String formatted = formatter.format(dateTime);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-- -- --";
  }
}

String getFormattedDateNew(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('d MMM y HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getNotificationFormattedDate(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('d MMM, HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getUpcomingFormattedDate(DateTime fromDate, DateTime toDate) {
  try {
    final DateFormat formatter = DateFormat('MMM d, y');
    final String formatted =
        "${formatter.format(fromDate)} - ${formatter.format(toDate)}";
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getFormattedDateBooking(DateTime fromDate) {
  try {
    final DateFormat formatter = DateFormat('d MMMM y');
    final String formatted = formatter.format(fromDate);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getUpcomingFormattedTime(DateTime fromDate, DateTime toDate) {
  try {
    final DateFormat timeFormatter = DateFormat('hh:mm aa');
    final String formatted =
        "${timeFormatter.format(fromDate)} - ${timeFormatter.format(toDate)}";
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "";
  }
}

String getFormattedTime(DateTime fromDate) {
  try {
    final DateFormat timeFormatter = DateFormat('hh:mm aa');
    final String formatted = timeFormatter.format(fromDate);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "";
  }
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

Future<void> launchURL(String url) async {
  try {
    bool isLaunched = await launchUrl(
      Uri.parse(url.startsWith("http") ? url : "https://$url"),
      mode: LaunchMode.externalApplication,
    );
    log("::: ::: ::: $isLaunched ::: ::: :::");
  } on Exception catch (e) {
    log('[CommonUtils] Launch url exception : ${e.toString()}');
  }
}

launchFBURL({String? appUrl, String? webUrl}) async {
  Uri fbProtocolUrl;
  if (Platform.isIOS) {
    appUrl!.replaceAll("page", "profile");
    log('Apple Url : ${appUrl.replaceAll("page", "profile")}');
    fbProtocolUrl = Uri.parse(appUrl);
  } else {
    fbProtocolUrl = Uri.parse(appUrl!);
  }

  Uri url = Uri.parse(webUrl!);

  try {
    bool launched = await launchUrl(fbProtocolUrl);
    if (!launched) {
      log('message web url launch call');
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

int calculateMonthSize(DateTime dateTime) {
  return dateTime.year * 12 + dateTime.month;
}

int getMonthSizeBetweenDates(String initialDate, String endDate) {
  return calculateMonthSize(DateTime.parse(endDate)) -
      calculateMonthSize(DateTime.parse(initialDate)) +
      1;
}

final defaultPinTheme = PinTheme(
  width: 42,
  height: 42,
  textStyle: getAppStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: CommonColors.primaryColor,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: CommonColors.primaryColor,
    ),
  ),
);

void showDatePickerDialog({TextEditingController? dateController}) async {
  final DateTime? selected = await showDatePicker(
    context: mainNavKey.currentContext!,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2030),
    keyboardType: TextInputType.text,
    builder: (BuildContext? context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: CommonColors.primaryColor,
          hintColor: CommonColors.primaryColor,
          colorScheme: const ColorScheme.light(
            primary: CommonColors.primaryColor,
          ),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
  if (selected != null && selected != dateController) {
    var formatter = DateFormat('yyyy-MM-dd');
    dateController!.text = formatter.format(selected);
    log("selectedDate ${dateController.text}");
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/* ----------------- below extension is use to remove duplicate object with same element ----------------- */
extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    for (var element in this) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    }
    return result;
  }
}

extension StringExtensions on String {
  String rmWhitespace() {
    return replaceAll(' ', '');
  }
}

String getDiscount({required String price, required String salePrice}) {
  int percent = 0;
  double mainPrice =
      double.parse((price.replaceAll("\$", "").replaceAll(",", "")));
  double discountedPrice =
      double.parse((salePrice.replaceAll("\$", "").replaceAll(",", "")));
  if (mainPrice != 0.0 && discountedPrice != 0.0) {
    percent = ((100 * (mainPrice - discountedPrice)) / mainPrice).round();
  }
  return "$percent% Off";
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

/*String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = document.body?.text ?? "--";
  return parsedString;
}*/

String getFileSizeString({required int bytes}) {
  const suffixes = ["b", "KB", "MB", "GB", "TB"];
  if (bytes == 0) return '0${suffixes[0]}';
  var i = (math.log(bytes) / math.log(1024)).floor();
  return ((bytes / math.pow(1024, i)).toStringAsFixed(2)) + suffixes[i];
}

String getDisplayCount(int num) {
  NumberFormat f = NumberFormat.compact();
  return f.format(num);
}

class CommonUtils {
  static bool isShowing = false;
  static bool isBlockerShowing = false;
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static Function mathFunc = (Match match) => '${match[1]},';
  static String languageCode = "en";

  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // static late PackageInfo packageInfo;
  static Map<String, dynamic> deviceData = {};

  static bool isvalidEmail(String email) {
    Pattern pattern =
        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";
    // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(email)) ? false : true;
  }

  static bool isValidPassword(String password) {
    String pattern = r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(password)) ? false : true;
  }

  static bool isvalidPhone(String phone) {
    return phone.length == 10 ? true : false;
  }

  static void showSnackBar(
    String? message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(mainNavKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(mainNavKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color ?? CommonColors.greenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message!,
            textAlign: TextAlign.center,
          ),
        ),
        padding: const EdgeInsets.all(5),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static void oopsMSG() {
    if (connectivity) {
      ScaffoldMessenger.of(mainNavKey.currentContext!).hideCurrentSnackBar();
      ScaffoldMessenger.of(mainNavKey.currentContext!).showSnackBar(
        SnackBar(
          elevation: 0,
          content: Text(
            S.of(mainNavKey.currentContext!)!.oops,
            textAlign: TextAlign.center,
            style: getAppStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          padding: const EdgeInsets.all(5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showGreenToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showRedToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static hideKeyboard() {
    try {
      FocusScope.of(mainNavKey.currentContext!).unfocus();
    } catch (e) {
      log("Exception :: $e");
    }
  }

  static void showProgressDialog({from}) {
    isShowing = true;
    showCupertinoDialog(
      barrierDismissible: false,
      // useSafeArea: true,
      context: mainNavKey.currentContext!,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    ).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        hideProgressDialog();
        oopsMSG();
      },
    );
  }

  static void blockerDialog() {
    isBlockerShowing = true;
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.transparent,
      context: mainNavKey.currentContext!,
      builder: (context) {
        return const SizedBox.shrink();
      },
    );
  }

  static void hideProgressDialog() {
    if (isShowing) {
      Navigator.of(mainNavKey.currentContext!, rootNavigator: true)
          .pop('dialog');
      isShowing = false;
    }
  }

  static void hideBlockerDialog() {
    if (isBlockerShowing) {
      Navigator.of(mainNavKey.currentContext!, rootNavigator: true)
          .pop('dialog');
      isBlockerShowing = false;
    }
  }

  static Widget getItemProgressBar() {
    return const Center(
      child: CircularProgressIndicator(
        color: CommonColors.primaryColor,
        strokeWidth: 2,
      ),
    );
  }

  static Future<double> getImageFileInMb(File image) async {
    final bytes = await image.readAsBytes();
    final kb = bytes.length / 1024;
    final mb = kb / 1024;
    return mb;
  }

  /*static String currencyFormat(String number) {
    if (number == "0,00" || number == "0,0" || number == "0") {
      return S.of(mainNavigatorKey.currentContext!!).walletZero;
    }
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,###',
      symbol: '€',
      decimalDigits: 2,
    );
    return "€ ${currencyFormat.format(double.parse(number.replaceAll(",", ".")))}";
  }*/

  static String dateFormatddMMYYYY(String dateStr) {
    try {
      return DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.parse(dateStr));
    } on Exception catch (e) {
      log("Exception (dateFormatddMMYYYY) :: $e");
      return dateStr;
    }
  }

  static String dateFormatddMMYYYYTime(String dateStr) {
    try {
      return DateFormat('hh:mm aa - d MMM yyyy', 'en_US')
          .format(DateTime.parse(dateStr));
    } on Exception catch (e) {
      log("Exception (dateFormatddMMYYYY) :: $e");
      return dateStr;
    }
  }

  static bool isFutureDate(String stringDate) {
    try {
      return !DateTime.now().isAfter(DateTime.parse(stringDate));
    } on Exception catch (e) {
      log("date parsing failed :: $e");
      return false;
    }
  }

  static bool isPastDate(String stringDate) {
    if (stringDate.isEmpty) return true;
    try {
      DateTime cTime = DateTime.now();
      // return !DateTime.now().isBefore(DateTime.parse(stringDate));
      return DateTime.parse(stringDate)
          .isBefore(DateTime(cTime.year, cTime.month, cTime.day));
    } on Exception catch (e) {
      log("date parsing failed :: $e");
      return false;
    }
  }

  static String getDateFormatForDetails(String dateStr) {
    try {
      return DateFormat('EEEE d MMM y', 'it_IT')
          .format(DateTime.parse(dateStr));
    } on Exception catch (e) {
      log("Exception (getDateFormatForDetails) :: $e");
      return dateStr;
    }
  }

  static String getDifference({String? startDate, String? endDate}) {
    final DateTime start = DateTime.parse(startDate!);
    final DateTime end = DateTime.parse(endDate!);

    Duration diff = end.difference(start);
    int diffyears = diff.inDays ~/ 365;
    int diffmonths = diff.inDays ~/ 30;
    int diffweeks = diff.inDays ~/ 7;

    return diffmonths.toString();
  }

  static String getDifferenceFromNow({String? endDate}) {
    final DateTime start = DateTime.now();
    final DateTime end = DateTime.parse(endDate!);

    Duration diff = end.difference(start);
    int diffyears = diff.inDays ~/ 365;
    int diffmonths = diff.inDays ~/ 30;
    int diffweeks = diff.inDays ~/ 7;

    return diffmonths.toString();
  }

  static Color getAlertColor(String color) {
    switch (color) {
      case 'yellow':
        return Colors.yellow.withOpacity(0.2);
      case 'red':
        return Colors.red.withOpacity(0.2);
      case 'green':
        return Colors.green.withOpacity(0.2);
      default:
        return Colors.green.withOpacity(0.2);
    }
  }

  /*static Future<void> getDeviceInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    } else {
      uuid = 'unknown';
      platform = 'unknown';
    }
    log(jsonEncode(deviceData));
  }*/

  /*static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    uuid = build.id;
    platform = "android ${build.version.release}";

    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }*/

  /*static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    uuid = data.identifierForVendor!;
    platform = "${data.systemName} ${data.systemVersion}";

    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }*/

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void makePhoneCall(String phone) async {
    if (phone.isNotEmpty) {
      String url = "tel:$phone";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw S.of(mainNavKey.currentContext!)!.empty;
      }
    } else {
      CommonUtils.showSnackBar(
        S.of(mainNavKey.currentContext!)!.contactNoNotAvailable,
        color: CommonColors.mRed,
      );
    }
  }

  static String getTimeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  static Future<bool> handleLocationPermission() async {
    if (Platform.isAndroid) {
      while (!await Geolocator.isLocationServiceEnabled()) {
        await openPermissionDialog(
          Icons.location_on,
          S.of(mainNavKey.currentContext!)!.locationService,
          S.of(mainNavKey.currentContext!)!.plEnableLocationService,
          S.of(mainNavKey.currentContext!)!.enableService,
          () async {
            await Geolocator.openLocationSettings();
          },
        );
      }
    } else {
      await Geolocator.requestPermission();
    }

    while (LocationPermission.deniedForever ==
            await Geolocator.checkPermission() ||
        LocationPermission.denied == await Geolocator.checkPermission()) {
      if (Platform.isAndroid) {
        await openPermissionDialog(
          Icons.my_location,
          S.of(mainNavKey.currentContext!)!.locationPermission,
          S.of(mainNavKey.currentContext!)!.plAllowLocationPermission,
          S.of(mainNavKey.currentContext!)!.allowPermission,
          () async {
            await Geolocator.openAppSettings();
          },
        );
      } else {
        await Geolocator.requestPermission();
      }
    }
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /*static Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      CommonUtils.showSnackBar(
        "Location services are disabled. Please enable the services",
        color: Colors.red,
      );
      Geolocator.openLocationSettings();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CommonUtils.showSnackBar("Location permissions are denied",
            color: Colors.red);
        Geolocator.openAppSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
      CommonUtils.showSnackBar(
        "Location permissions are permanently denied, we cannot request permissions.",
        color: Colors.red,
      );
      return false;
    }
    return true;
  }*/

  // static Future<Position?> getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return null;
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // static Future<bool> isDeviceSupportBiomatric() async {
  //   LocalAuthentication auth = LocalAuthentication();
  //   final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  //   final bool canAuthenticate =
  //       canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  //   if (canAuthenticate) {
  //     List<BiometricType> availableBiometrics =
  //         await auth.getAvailableBiometrics();
  //     if (availableBiometrics.isNotEmpty) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  static popUpMenu({Function()? onTap, String? text}) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            onTap: onTap,
            child: Text(text!),
          ),
        ];
      },
    );
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

Future<void> imagePickerOption(
    {required Function()? onTapCamera,
    required Function()? onTapPhotos}) async {
  await showModalBottomSheet(
    context: mainNavKey.currentContext!,
    clipBehavior: Clip.antiAlias,
    builder: (context) {
      return Padding(
        padding: kCommonAllBottomPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera,
                size: 25,
              ),
              title: Text(
                S.of(context)!.camera,
                style: getAppStyle(),
              ),
              onTap: onTapCamera,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo,
                size: 25,
              ),
              title: Text(
                S.of(context)!.gallery,
                style: getAppStyle(),
              ),
              onTap: onTapPhotos,
            ),
          ],
        ),
      );
    },
  );
}

Future<File?> openCamera({bool isSquare = false, bool isEdit = false}) async {
  File? image;
  final XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 80,
  );
  if (selectedImage != null) {
    image = File(selectedImage.path);
    if (isSquare || isEdit) {
      // image = await cropImage(selectedImage.path, isSquare: isSquare);
    }
  }
  return image;
}

Future<File?> recordVideo() async {
  File? video;
  final recordedVideo = await ImagePicker().pickVideo(
    source: ImageSource.camera,
    //maxDuration: const Duration(seconds: 30),
    preferredCameraDevice: CameraDevice.front,
  );
  return video;
}

Future<File?> pickSinglePhoto(
    {bool isSquare = false, bool isEdit = false}) async {
  File? image;
  final XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (selectedImage != null) {
    image = File(selectedImage.path);
    if (isSquare || isEdit) {
      // image = await cropImage(selectedImage.path, isSquare: isSquare);
    }
  }
  return image;
}

Future<File?> pickOrTakeSinglePhoto(
    {bool isSquare = false, bool isEdit = false}) async {
  File? image;
  await imagePickerOption(
    onTapCamera: () async {
      final XFile? selectedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (selectedImage != null) {
        image = File(selectedImage.path);
        if (isSquare || isEdit) {
          // image = await cropImage(selectedImage.path, isSquare: isSquare);
        }
      }
      Navigator.pop(mainNavKey.currentContext!);
    },
    onTapPhotos: () async {
      final XFile? selectedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (selectedImage != null) {
        image = File(selectedImage.path);
        if (isSquare || isEdit) {
          // image = await cropImage(selectedImage.path, isSquare: isSquare);
        }
      }
      Navigator.pop(mainNavKey.currentContext!);
    },
  );
  return image;
}

Future<File?> pickOrTakeSingleVideo() async {
  File? video;
  await imagePickerOption(
    onTapCamera: () async {
      final XFile? selectedImage = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 30),
      );
      if (selectedImage != null) {
        video = File(selectedImage.path);
      }
      Navigator.pop(mainNavKey.currentContext!);
    },
    onTapPhotos: () async {
      final XFile? selectedImage = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      if (selectedImage != null) {
        video = File(selectedImage.path);
      }
      Navigator.pop(mainNavKey.currentContext!);
    },
  );
  return video;
}

Future<List<File>> pickMultiplePhotos() async {
  List<File> images = [];
  final List<XFile> selectedImages = await ImagePicker().pickMultiImage(
    imageQuality: 80,
  );

  if (selectedImages.isEmpty) {
    return images;
  }

  for (var element in selectedImages) {
    images.add(File(element.path));
  }
  return images;
}

// Future<String?> pickFile({FileType? type}) async {
//   FilePickerResult? fileName =
//       await FilePicker.platform.pickFiles(type: type ?? FileType.any);
//   if (fileName == null) {
//     return null;
//   }
//   return fileName.paths.first!;
// }

Widget getTextRow(
    {required String title,
    Color? color,
    required String val,
    double? fontSize,
    FontWeight? fontweight}) {
  return Row(
    children: [
      Text(
        "$title : ",
        style: getAppStyle(
            color: CommonColors.textColor,
            fontSize: fontSize ?? 15,
            fontWeight: fontweight ?? FontWeight.w500),
      ),
      kCommonSpaceH5,
      Flexible(
        child: Text(
          val,
          style: getAppStyle(
              // color: color ?? CommonColors.iconColor,
              fontSize: fontSize ?? 15,
              fontWeight: fontweight ?? FontWeight.w400),
        ),
      ),
    ],
  );
}

Widget getTitle({
  required String title,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    title,
    style: getAppStyle(
      color: color ?? CommonColors.textColor,
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w500,
    ),
  );
}

Widget getRequiredTitle(title) {
  return Row(
    children: [
      Text(
        title,
        style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
      kCommonSpaceH5,
      Text(
        "*",
        style: getAppStyle(
          // color: CommonColors.sliderColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

// void datePicker(controller) {
//   showDatePicker(
//       context: mainNavKey.currentContext!,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2019, 1),
//       lastDate: DateTime(2021, 12),
//       builder: (context, picker) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             colorScheme: ColorScheme.dark(
//               primary: Colors.deepPurple,
//               onPrimary: Colors.white,
//               surface: Colors.pink,
//               onSurface: Colors.yellow,
//             ),
//             dialogBackgroundColor: Colors.green[900],
//           ),
//           child: picker!,
//         );
//       }).then((selectedDate) {
//     if (selectedDate != null) {
//       controller.text = selectedDate.toString();
//     }
//   });
// }

Widget getSwitch({
  required String lbl,
  Function(bool)? onChanged,
  bool? isSwitched,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getTitle(
        title: lbl,
        fontSize: 15.0,
      ),
      Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          activeColor: CommonColors.primaryColor,
          value: isSwitched!,
          onChanged: onChanged,
        ),
      )
    ],
  );
}

Widget getSwitchWithIcon({
  required String img,
  required String lbl,
  Function(bool)? onChanged,
  bool? isSwitched,
}) {
  return Row(
    children: [
      Image.asset(
        img,
        height: 25,
        width: 25,
      ),
      kCommonSpaceH10,
      getTitle(title: lbl, fontSize: 15.0),
      const Spacer(),
      Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          activeColor: CommonColors.primaryColor,
          value: isSwitched!,
          onChanged: onChanged,
        ),
      )
    ],
  );
}

Widget getTextCol({required String title, Color? color, String? val}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: getAppStyle(
          color: CommonColors.textColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      if (val != null) ...[
        const SizedBox(
          height: 2,
        ),
        Text(
          val,
          maxLines: 1,
          textAlign: TextAlign.end,
          style: getAppStyle(
            // color: color ?? CommonColors.sliderColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]
    ],
  );
}

void successDialog(msg) {
  showDialog(
    context: mainNavKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 50,
              // color: CommonColors.greenColor,
            ),
            kCommonSpaceV20,
            Text(
              msg,
              textAlign: TextAlign.center,
              style: getAppStyle(
                  color: CommonColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            kCommonSpaceV20,
            SizedBox(
              width: 150,
              child: PrimaryButton(
                label: "ok",
                // buttonColor: CommonColors.greenColor,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

int sentStatus({orderStatus}) {
  if (orderStatus == "Pending Production") {
    return 1;
  } else if (orderStatus == "Production") {
    return 4;
  } else if (orderStatus == "Completed") {
    return 5;
  } else {
    return 1;
  }
}

Future<void> openPermissionDialog(
  IconData icon,
  String dialogTitle,
  String alertMsg,
  String buttonLabel,
  void Function()? onPressBtn,
) async {
  await showDialog<void>(
    context: mainNavKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(
          icon,
          // Icons.location_on,
          color: CommonColors.primaryColor,
        ),
        title: Text(
          dialogTitle,
          // S.of(context)!.locationService,
          style: getAppStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  alertMsg,
                  style: getAppStyle(),
                ),
                kCommonSpaceV15,
              ],
            );
          },
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.mRed,
            ),
            child: Text(
              S.of(mainNavKey.currentContext!)!.done,
              style: getAppStyle(
                color: CommonColors.mWhite,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressBtn,
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.mRed,
            ),
            child: Text(
              buttonLabel,
              style: getAppStyle(
                color: CommonColors.mWhite,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget getButton({onTap, color, notifyTxt, txtSize}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(left: 5.0, top: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(notifyTxt,
          style: getAppStyle(
            color: CommonColors.mWhite,
            fontSize: txtSize ?? 11,
          )),
    ),
  );
}

String getPHStatus({int? paymentStatus}) {
  if (paymentStatus == AppConstants.PENDING) {
    return "Pending";
  } else if (paymentStatus == AppConstants.UN_PAID) {
    return "Un-paid";
  } else if (paymentStatus == AppConstants.PAID) {
    return "Paid";
  } else {
    return "";
  }
}

String getAlbumType({int? type}) {
  if (type == AppConstants.PUBLIC) {
    return S.of(mainNavKey.currentContext!)!.public;
  } else if (type == AppConstants.PRIVATE) {
    return S.of(mainNavKey.currentContext!)!.private;
  } else {
    return "--";
  }
}

Widget getIcon(
    {required icon,
    required borderColor,
    required iconColor,
    onTap,
    iconSize,
    counts,
    countsColor}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.2),
              color: CommonColors.mWhite,
              shape: BoxShape.circle,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: iconSize ?? 15,
                  color: iconColor,
                ),
              ],
            )),
        if (counts != null) ...[
          Text(
            counts,
            maxLines: 1,
            style: getAppStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: countsColor ?? CommonColors.mWhite),
          )
        ],
      ],
    ),
  );
}

String productStatus(int status) {
  if (status == 0) {
    return "Pending";
  } else if (status == 1) {
    return "Approved";
  } else {
    return "";
  }
}

String productFeature(int feature) {
  if (feature == 0) {
    return "UnFeatured";
  } else if (feature == 1) {
    return "Featured";
  } else {
    return "";
  }
}

String productPublish(int publishStatus) {
  if (publishStatus == 0) {
    return "UnPublished";
  } else if (publishStatus == 1) {
    return "Published";
  } else {
    return "";
  }
}

String productPersonalized(int status) {
  if (status == 0) {
    return "Not personalised";
  } else if (status == 1) {
    return "Personalised";
  } else {
    return "";
  }
}

String requestStatus(int status) {
  if (status == AppConstants.REQUEST_PENDING) {
    return "Pending";
  } else if (status == AppConstants.REQUEST_CONFIRM) {
    return "Confirm";
  } else if (status == AppConstants.REQUEST_COMPLETED) {
    return "Completed";
  } else {
    return "";
  }
}

String convertDate(String date) {
  String tempTime = date.replaceAll("T", " ").replaceAll("Z", "");
  return DateFormat('dd-MM-yyyy HH:mm:ss').parse(tempTime).toString();
}

String postDateFormat(String date) {
  if (date.isEmpty) {
    return "--";
  }
  String tempTime = date.replaceAll("T", " ").replaceAll("Z", "");
  try {
    return DateFormat('d-MMM-yyyy hh:mm aa').format(DateTime.parse(tempTime));
  } on Exception catch (e) {
    log("Exception (postDateFormat) :: $e");
    return date;
  }
}

String convertChatDate(String date) {
  if (date.isEmpty) {
    return "--";
  }
  String tempTime = date.replaceAll("T", " ").replaceAll("Z", "");
  try {
    return DateFormat('d-MMM-yy hh:mm aa').format(DateTime.parse(tempTime));
  } on Exception catch (e) {
    log("Exception (postDateFormat) :: $e");
    return date;
  }
}

String convertToLocalDateTime(String date) {
  if (date.isEmpty) {
    return "--";
  }
  // String tempTime = date.replaceAll("T", " ").replaceAll("Z", "");
  DateTime localDateTime = DateTime.parse(date).toLocal();
  try {
    return DateFormat('d-MMM-yy hh:mm aa').format(localDateTime);
  } on Exception catch (e) {
    log("Exception (postDateFormat) :: $e");
    return date;
  }
}

/*Future<File?> cropImage(String filePath, {bool isSquare = false}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio:
          isSquare ? const CropAspectRatio(ratioX: 1080, ratioY: 1080) : null,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          statusBarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          dimmedLayerColor: Colors.black,
          backgroundColor: Colors.black,
        )
      ]
      // uiSettings:
      );
  if (croppedImage != null) {
    return File(croppedImage.path);
  } else {
    return null;
  }
}*/

String getTime(String? str) {
  if (str == null || str.isEmpty) return "--:--:-- --";
  String formatted =
      DateFormat('hh:mm aa', 'en_US').format(DateTime.parse(str));
  return formatted;
}

String getNumFormatter(int num) {
  NumberFormat formatter = NumberFormat("00");
  return formatter.format(num);
}

// Future<void> downloadFile({
//   required String assetPath,
// }) async {
//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;
//   File tempFile = File('$tempPath/${assetPath.split("/").last}.pdf');
//   ByteData bd = await rootBundle.load(assetPath);
//   await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
//   Share.shareXFiles([XFile(tempFile.path)]);
// }

extension ExtendedString on String? {
  String get checkV {
    return this == null || this!.isEmpty ? "--" : this!;
  }
}

Future<void> saveNetworkImage(String? image) async {
  if (image == null || image.isEmpty) return;

  try {
    Response response = await get(Uri.parse(image));
    final result = await ImageGallerySaver.saveImage(
      response.bodyBytes,
      quality: 100,
    );
    print(result);

    if (result != null && result.isNotEmpty) {
      CommonUtils.showToastMessage("Image Saved");
    } else {
      CommonUtils.showSnackBar("Image not Saved");
    }
  } catch (e) {
    print("Error saving image: $e");
    CommonUtils.showSnackBar("Error saving image");
  }
}

// Future<void> shareNetworkImage(String? image) async {
//   if (image == null || image.isEmpty) return;
//
//   try {
//     Response response = await get(Uri.parse(image));
//     Uint8List imageData = response.bodyBytes;
//
//     String imagePath = await saveImageToFile(imageData);
//
//     shareImageFile(imagePath);
//   } catch (e) {
//     print("Error fetching image: $e");
//     CommonUtils.showSnackBar("Error fetching image");
//   }
// }

// Future<String> saveImageToFile(Uint8List imageData) async {
//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;
//   String imagePath = '$tempPath/temp_image.png';
//
//   File imageFile = File(imagePath);
//   await imageFile.writeAsBytes(imageData);
//
//   return imagePath;
// }

// void shareImageFile(String imagePath) {
//   Share.shareFiles([imagePath], text: 'Check out this awesome image!')
//       .then((value) => print('Share Successful'))
//       .catchError((error) => print('Error sharing: $error'));
// }
