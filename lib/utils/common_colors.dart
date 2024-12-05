import 'package:flutter/material.dart';
import 'global_variables.dart';

class CommonColors {
  static Color get primaryColor {
    String hexColor = appColor.replaceAll('0xff', '');
    return Color(int.parse('0xFF$hexColor'));
  }

  static const mWhite = Colors.white;
  static const mTransparent = Colors.transparent;
  static const mGrey = Colors.grey;
  static const greenColor = Color(0xFF2C7E05);
  static const iosGreenColor = Color(0xFF34C759);
  static final mGrey200 = Colors.grey.shade200;
  static final mGrey300 = Colors.grey.shade300;
  static final mGrey500 = Colors.grey.shade500;
  static const mRed = Colors.red;
  static const blackColor = Color(0xFF000000);
  static const bgColor = Color(0xFFFFF59D);
  static const black54 = Colors.black54;
  static const black12 = Colors.black12;
  static final grayShade200 = Colors.grey.shade200;
  static const black45 = Colors.black45;
  static const textColor = Color(0xFF2D2D2D);
}
