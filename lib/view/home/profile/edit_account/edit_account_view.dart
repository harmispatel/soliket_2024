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

class TextFormFieldCustom extends StatefulWidget {
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
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const TextFormFieldCustom({
    super.key,
    this.controller,
    this.onTap,
    this.hintText,
    this.labelText,
    this.textInputAction,
    this.textInputType,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.validator,
    this.onChanged,
  });

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  final FocusNode _focusNode = FocusNode();
  Color _labelColor = Colors.black.withOpacity(0.5);

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validateField() {
    if (widget.validator != null) {
      String? error = widget.validator!(widget.controller?.text);
      if (error != null) {
        _focusNode.requestFocus(); // Open the keyboard on error
        setState(() {
          _labelColor = Colors.red; // Change label color to red on error
        });
      } else {
        setState(() {
          _labelColor = Colors.black.withOpacity(0.5); // Reset label color
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        focusNode: _focusNode,
        onTap: widget.onTap,
        validator: (value) {
          _validateField();
          return widget.validator?.call(value);
        },
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        controller: widget.controller,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.textInputType ?? TextInputType.text,
        cursorColor: Colors.black,
        readOnly: widget.readOnly,
        style: getAppStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText ?? "",
          filled: true,
          labelText: widget.labelText ?? "",
          labelStyle: getAppStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          floatingLabelStyle: getAppStyle(
            color: _labelColor,
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
          errorStyle: getAppStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            height: 1,
            fontSize: 12,
          ),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          hintStyle: getAppStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          suffixIcon: widget.suffixIcon,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
