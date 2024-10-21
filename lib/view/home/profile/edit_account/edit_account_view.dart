import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../../../utils/common_colors.dart';
import '../../../../widget/primary_button.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  TextEditingController edPhoneNumberController = TextEditingController();
  TextEditingController edYourNameController = TextEditingController();
  TextEditingController edEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "User Name",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              kCommonSpaceV20,
              TextFormFieldCustom(
                maxLength: 10,
                controller: edPhoneNumberController,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                labelText: "Phone Number",
              ),
              kCommonSpaceV20,
              TextFormFieldCustom(
                controller: edYourNameController,
                textInputType: TextInputType.name,
                hintText: "Your Name",
                labelText: "Your Name",
              ),
              kCommonSpaceV20,
              TextFormFieldCustom(
                controller: edEmailController,
                textInputType: TextInputType.emailAddress,
                hintText: "Email",
                labelText: "Email",
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: PrimaryButton(
                      height: 50,
                      label: "Save Changes",
                      lblSize: 18,
                      borderRadius: BorderRadius.circular(16),
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final String? hintText;
  final String? labelText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;

  const TextFormFieldCustom({
    super.key,
    this.controller,
    this.onTap,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onTap: onTap,
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: textInputType ?? TextInputType.text,
        cursorColor: Colors.black,
        readOnly: readOnly,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText ?? "",
          filled: true,
          labelText: labelText ?? "",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          suffixIcon: suffixIcon,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
