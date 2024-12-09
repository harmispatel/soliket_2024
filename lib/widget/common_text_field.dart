import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? inputType;
  final GestureTapCallback? onTap;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool isIconButton;
  final bool readOnly;
  final bool isPrefixIconButton;
  final bool obscureText;
  final bool? enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onSuffixIconPressed;
  final VoidCallback? onPrefixIconPressed;
  final void Function(String)? onEditComplete;
  final double? height;

  const CommonTextField({
    this.controller,
    this.hintText,
    this.inputType,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    this.isRequired = false,
    this.isIconButton = false,
    this.readOnly = false,
    this.isPrefixIconButton = false,
    this.obscureText = false,
    this.enabled,
    this.textInputAction,
    this.onSuffixIconPressed,
    this.onPrefixIconPressed,
    this.onEditComplete,
    this.height,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: CommonColors.mGrey300, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        // boxShadow: [
        //   BoxShadow(
        //     color: CommonColors.black45,
        //     blurRadius: 3,
        //     offset: Offset(0, 2),
        //     spreadRadius: 0,
        //   )
        // ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
        child: TextFormField(
          onTap: onTap,
          onChanged: onEditComplete,
          textInputAction: textInputAction,
          keyboardType: inputType,
          controller: controller,
          focusNode: focusNode,
          cursorColor: CommonColors.primaryColor,
          enabled: enabled ?? true,
          obscureText: obscureText,
          readOnly: readOnly,
          style: getAppStyle(),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: isPrefixIconButton
                ? IconButton(
                    icon: Icon(
                      prefixIcon ?? Icons.search,
                      color: CommonColors.mGrey,
                    ),
                    onPressed: onPrefixIconPressed,
                  )
                : null,
            suffixIcon: isIconButton
                ? IconButton(
                    icon: Icon(
                      suffixIcon,
                      color: CommonColors.mGrey,
                    ),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            hintText: hintText,
            hintStyle: getAppStyle(
                color: CommonColors.mGrey,
                fontSize: 13,
                fontWeight: FontWeight.normal),
            border: InputBorder.none,
          ),
          maxLines: maxLines ?? 1,
          maxLength: maxLength ?? 200,
          autocorrect: false,
        ),
      ),
    );
  }
}

class PrefixTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const PrefixTextField({
    required this.controller,
    required this.prefix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          prefix,
          Flexible(
            child: TextFormField(
              onChanged: onEditComplete,
              textInputAction: textInputAction,
              keyboardType: inputType,
              controller: controller,
              cursorColor: CommonColors.primaryColor,
              enabled: enabled ?? true,
              decoration: InputDecoration(
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                prefixIconColor: Colors.black,
                hintText: hintText,
                hintStyle: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 200,
              autocorrect: false,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const OTPTextField({
    required this.controller,
    required this.prefix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          prefix,
          Flexible(
            child: TextFormField(
              onChanged: onEditComplete,
              textInputAction: textInputAction,
              keyboardType: inputType,
              controller: controller,
              cursorColor: CommonColors.primaryColor,
              enabled: enabled ?? true,
              decoration: InputDecoration(
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                prefixIconColor: Colors.black,
                hintText: hintText,
                hintStyle: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 200,
              autocorrect: false,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuffixTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget suffix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const SuffixTextField({
    required this.controller,
    required this.suffix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                onChanged: onEditComplete,
                textInputAction: textInputAction,
                keyboardType: inputType,
                controller: controller,
                cursorColor: CommonColors.primaryColor,
                enabled: enabled ?? true,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  prefixIconColor: Colors.black,
                  hintText: hintText,
                  hintStyle: getAppStyle(
                      color: CommonColors.mGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                ),
                maxLines: maxLines ?? 1,
                maxLength: maxLength ?? 200,
                autocorrect: false,
                style: getAppStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            suffix
          ],
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool? enabled;
  final bool isShadow;
  final bool? readOnly;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final void Function(String)? onEditComplete;
  final double? height;
  final bool? isObscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const LabeledTextField({
    this.controller,
    this.inputFormatters,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.isRequired = false,
    this.enabled,
    this.isShadow = true,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.isObscure,
    this.readOnly,
    this.autofocus = false,
    this.suffixIcon,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 65,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: CommonColors.mTransparent,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: isObscure ?? false,
        onChanged: onEditComplete,
        textInputAction: textInputAction,
        keyboardType: inputType,
        controller: controller,
        readOnly: readOnly ?? false,
        cursorColor: CommonColors.primaryColor,
        enabled: enabled ?? true,
        autofocus: autofocus ?? false,
        inputFormatters: inputFormatters,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this field';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ), // Adjusted vertical padding for spacing
          floatingLabelStyle: getAppStyle(
            color: CommonColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: CommonColors.primaryColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: CommonColors.primaryColor, width: 1),
          ),

          labelText: hintText, // Label text
          labelStyle: getAppStyle(
            color: Colors.grey.shade400,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),

          hintText: hintText, // Placeholder text
          hintStyle: getAppStyle(
            color: Colors.grey.shade400, // Gray color for hint text
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        style: getAppStyle(
          color: Colors.grey.shade600,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 200,
        autocorrect: false,
      ),
    );
  }
}

class LabelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final bool isRequired;
  final bool isOnlyChar;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onEditComplete;
  final double? height;
  final void Function()? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Color? bgColor;

  const LabelTextField({
    this.controller,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.isRequired = false,
    this.isOnlyChar = false,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.label,
    this.onTap,
    this.readOnly,
    this.suffixIcon,
    this.bgColor,
    this.textCapitalization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Flexible(
                child: Text(
                  label!,
                  maxLines: 2,
                  style: getAppStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: CommonColors.blackColor,
                  ),
                ),
              ),
              if (isRequired) ...[
                kCommonSpaceH5,
                Text(
                  "*",
                  style: getAppStyle(
                    color: CommonColors.mRed,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            ],
          ),
          kCommonSpaceV5,
        ],
        Container(
          height: maxLines != null ? 100 : 50,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: bgColor ?? CommonColors.mWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: TextFormField(
            readOnly: readOnly ?? false,
            onTap: onTap,
            onChanged: onEditComplete,
            textInputAction: textInputAction,
            keyboardType: inputType,
            controller: controller,
            cursorColor: CommonColors.primaryColor,
            enabled: enabled ?? true,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: isOnlyChar
                ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))]
                : null,
            // Only allow alphabets
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 8, left: 15, right: 15),
              counterText: "",
              hintText: hintText ?? "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxLines ?? 1,
            maxLength: maxLength ?? 200,
            autocorrect: false,
            style: getAppStyle(
              color: CommonColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
