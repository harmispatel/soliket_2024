import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../widget/common_text_field.dart';
import '../../widget/primary_button.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  Color buttonColor = CommonColors.mGrey200;
  Color labelColor = Colors.black26;
  late LoginViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // phoneController.text = "+91 ";
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));

      phoneController.addListener(() {
        setState(() {
          // Update button color based on phone number length
          buttonColor = phoneController.text.length == 10
              ? CommonColors.primaryColor
              : CommonColors.mGrey200;

          labelColor = phoneController.text.length == 10
              ? CommonColors.mWhite
              : Colors.black26;

          if (phoneController.text.length == 10) {
            FocusScope.of(context).unfocus();
          }
        });
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
    mViewModel = Provider.of<LoginViewModel>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: CommonColors.grayShade200,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: CommonColors.grayShade200),
    );
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(
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
                maxLength: 10,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 13, left: 12),
                  child: Text(
                    "+91",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                  if (phoneController.text.length == 10) {
                    mViewModel.loginApi(
                        country_code: "91",
                        mobile_no: phoneController.text.trim().toString());
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
              // kCommonSpaceV100,
              // kCommonSpaceV20,
              // Padding(
              //   padding: const EdgeInsets.all(25.0),
              //   child: Image.asset(LocalImages.img_splash_logo),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (phoneController.text.length == 4) {
      CommonUtils.showSnackBar("Please enter mobile number",
          color: CommonColors.mRed);
      return false;
    } else if (phoneController.text.length != 14) {
      CommonUtils.showSnackBar("Mobile number must be 10 digits",
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }
}
