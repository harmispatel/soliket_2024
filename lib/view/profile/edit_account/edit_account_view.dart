import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../widget/primary_button.dart';
import 'edit_account_view_model.dart';

class EditAccountView extends StatefulWidget {
  final String? phone;
  final String? name;
  final String? email;
  final String? birthDate;
  final String? profileImage;
  EditAccountView(
      {super.key,
      this.phone,
      this.name,
      this.email,
      this.birthDate,
      this.profileImage});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  TextEditingController edPhoneNumberController = TextEditingController();
  TextEditingController edYourNameController = TextEditingController();
  TextEditingController edEmailController = TextEditingController();
  TextEditingController edBirthDateController = TextEditingController();
  late EditAccountViewModel mViewModel;
  DateTime? selectedDate;
  File? selectedImage;
  String imagePath = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      edPhoneNumberController.text = widget.phone ?? '';
      edYourNameController.text = widget.name ?? '';
      edEmailController.text = widget.email ?? '';
      edBirthDateController.text = widget.birthDate ?? '';
    });
  }

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        edBirthDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<EditAccountViewModel>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Edit Profile",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                kCommonSpaceV20,
                GestureDetector(
                  onTap: () async {
                    final image = await pickSinglePhoto();
                    if (image != null) {
                      setState(() {
                        selectedImage = image;
                        imagePath = image.path;
                      });
                    }
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: CommonColors.primaryColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: (() {
                      if (selectedImage != null) {
                        return Image.file(
                          selectedImage!,
                          fit: BoxFit.contain,
                        );
                      } else {
                        return Image.network(
                          widget.profileImage ?? '',
                          fit: BoxFit.contain,
                        );
                      }
                    })(),
                  ),
                ),
                kCommonSpaceV20,
                TextFormFieldCustom(
                  maxLength: 10,
                  verticalPadding: 15,
                  controller: edPhoneNumberController,
                  textInputType: TextInputType.number,
                  readOnly: true,
                  bgColor: CommonColors.mGrey200,
                  hintText: "Phone Number",
                  labelText: "Phone Number",
                ),
                kCommonSpaceV20,
                TextFormFieldCustom(
                  verticalPadding: 15,
                  controller: edYourNameController,
                  textInputType: TextInputType.name,
                  hintText: "Your Name",
                  labelText: "Your Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_formKey.currentState?.validate() == true) {
                      _formKey.currentState!.validate();
                    }
                  },
                ),
                kCommonSpaceV20,
                TextFormFieldCustom(
                  verticalPadding: 15,
                  controller: edEmailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email",
                  labelText: "Email",
                ),
                kCommonSpaceV20,
                TextFormFieldCustom(
                  verticalPadding: 15,
                  onTap: () {
                    selectBirthDate(context);
                  },
                  textInputType: TextInputType.emailAddress,
                  controller: edBirthDateController,
                  hintText: "Birth Date",
                  labelText: "Birth Date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birthday';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_formKey.currentState?.validate() == true) {
                      _formKey.currentState!.validate();
                    }
                  },
                  readOnly: true,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PrimaryButton(
                      height: 40,
                      label: "Save",
                      lblSize: 16,
                      borderRadius: BorderRadius.circular(6),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          mViewModel.updateProfileApi(
                              name: edYourNameController.text,
                              email: edEmailController.text,
                              birthday: edBirthDateController.text,
                              profile: imagePath);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldCustom extends StatefulWidget {
  final double? height;
  final double? verticalPadding;
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
  final Color? bgColor;

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
    this.height,
    this.verticalPadding,
    this.bgColor,
  });

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  // final FocusNode _focusNode = FocusNode();
  Color _labelColor = Colors.black.withOpacity(0.5);

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  void _validateField() {
    if (widget.validator != null) {
      String? error = widget.validator!(widget.controller?.text);
      if (error != null) {
        // _focusNode.requestFocus();
        setState(() {
          _labelColor = Colors.red;
        });
      } else {
        setState(() {
          _labelColor = Colors.black.withOpacity(0.5);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: _focusNode,
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
        fillColor: widget.bgColor ?? Colors.transparent,
        labelText: widget.labelText ?? "",
        labelStyle: getAppStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: widget.verticalPadding ?? 12,
        ),
        floatingLabelStyle: getAppStyle(
          color: _labelColor,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
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
      ),
    );
  }
}
