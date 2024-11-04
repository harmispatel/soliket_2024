import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class PrimaryButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? shadowColor;
  final void Function()? onPress;
  final double? lblSize;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  const PrimaryButton({
    this.label,
    this.onPress,
    this.labelColor,
    this.buttonColor,
    this.shadowColor,
    this.lblSize,
    this.height,
    this.borderColor,
    this.borderRadius,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 40,
      clipBehavior: Clip.antiAlias,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: buttonColor ?? CommonColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(6.0),
        border: Border.all(color: borderColor ?? Colors.transparent,)
        /* boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 0,
            color: shadowColor?.withOpacity(0.4) ??
                CommonColors.primaryColor.withOpacity(0.4),
          )
        ],*/
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          splashColor: CommonColors.mWhite.withOpacity(0.150),
          highlightColor: CommonColors.mWhite.withOpacity(0.150),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: getAppStyle(
                color: labelColor ?? CommonColors.mWhite,
                fontSize: lblSize ?? 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? buttonColor;
  final Function()? onPress;

  const SecondaryButton({
    this.label,
    this.onPress,
    this.labelColor,
    this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: buttonColor ?? CommonColors.primaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          splashColor: CommonColors.mWhite.withOpacity(0.150),
          highlightColor: CommonColors.mWhite.withOpacity(0.150),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            alignment: Alignment.center,
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: getAppStyle(
                color: labelColor ?? CommonColors.mWhite,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
