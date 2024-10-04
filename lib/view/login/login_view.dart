import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../widget/common_text_field.dart';
import '../../widget/primary_button.dart';
import '../otp/otp_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  Color buttonColor = CommonColors.mGrey200; // Initial color
  Color labelColor = Colors.black26; // Initial color

  @override
  void initState() {
    super.initState();
    phoneController.text = "+91 ";
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));

    phoneController.addListener(() {
      setState(() {
        if (!phoneController.text.startsWith("+91 ")) {
          phoneController.text = "+91 ";
          phoneController.selection = TextSelection.fromPosition(
              TextPosition(offset: phoneController.text.length));
        }
        // Update button color based on phone number length
        buttonColor = phoneController.text.length == 14
            ? CommonColors.primaryColor
            : CommonColors.mGrey200;

        labelColor = phoneController.text.length == 14
            ? CommonColors.mWhite
            : Colors.black26;

        if (phoneController.text.length == 14) {
          FocusScope.of(context).unfocus();
        }
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Status bar color
        statusBarIconBrightness: Brightness.dark, // Status bar icon color
        systemNavigationBarColor: Colors.white, // Navigation bar color
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "SOLIKET",
          isTitleBold: true,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your phone number to get started",
                style: getAppStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              kCommonSpaceV15,
              LabeledTextField(
                hintText: "Phone Number",
                inputType: TextInputType.number,
                maxLength: 14,
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                controller: phoneController,
                inputFormatters: [
                  // This formatter ensures "+91 " cannot be deleted
                  FilteringTextInputFormatter.allow(RegExp(r'(\d|\+| )')),
                ],
              ),
              kCommonSpaceV30,
              PrimaryButton(
                height: 55,
                label: "CONTINUE",
                buttonColor: buttonColor,
                labelColor: labelColor,
                onPress: () {
                  if (phoneController.text.length == 14) {
                    push(OtpView());
                  }
                },
              ),
              kCommonSpaceV5,
              kCommonSpaceV3,
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By clicking, I accept the ",
                        style: getAppStyle(fontSize: 12),
                      ),
                      Text(
                        "Terms & Conditions",
                        style: getAppStyle(
                          fontSize: 12,
                          color: CommonColors.primaryColor,
                          decoration: TextDecoration.underline,
                          textDecorationColor: CommonColors.primaryColor,
                        ),
                      ),
                      Text(
                        " and ",
                        style: getAppStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: getAppStyle(
                          fontSize: 12,
                          color: CommonColors.primaryColor,
                          decoration: TextDecoration.underline,
                          textDecorationColor: CommonColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV100,
              kCommonSpaceV20,
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(LocalImages.img_splash_logo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
