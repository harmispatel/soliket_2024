import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/global_variables.dart';
import '../../widget/common_appbar.dart';
import '../../widget/primary_button.dart';
import 'otp_view_model.dart';

class OtpView extends StatefulWidget {
  final String mobileNo;
  const OtpView({super.key, required this.mobileNo});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with CodeAutoFill {
  late OtpViewModel mViewModel;
  OTPTextEditController otpController = OTPTextEditController(codeLength: 6);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.startTimer();
      otpController = OTPTextEditController(codeLength: 6)
        ..startListenUserConsent(
          (value) {
            final exp = RegEx.otpLengthRegex;
            final matchedString = exp.stringMatch(value ?? '') ?? '';
            if (exp.hasMatch(value ?? '')) {
              otpController.text = matchedString;
              codeUpdated();
            }
            return matchedString;
          },
        );
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  void codeUpdated() {
    otpController.text = code ?? '';
    if (otpController.text.length == 6) {
      mViewModel.otpVerifyApi(
        user_id: gUserId,
        otp: otpController.text,
        device_token: deviceToken ?? 'no device',
        device_type: deviceType,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OtpViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: appName,
          isTitleBold: true,
          isShowShadow: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your OTP",
                style: getAppStyle(fontWeight: FontWeight.w500, fontSize: 19),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Text(
                    "OTP has been sent to +91${widget.mobileNo} ",
                    style: getAppStyle(fontSize: 14),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: CommonColors.primaryColor,
                    size: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Edit",
                      style: getAppStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: CommonColors.primaryColor),
                    ),
                  ),
                ],
              ),
              kCommonSpaceV20,
              otpPinWidget(),
              kCommonSpaceV30,
              mViewModel.second == 0
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          mViewModel
                              .reSendOtpApi(user_id: gUserId)
                              .whenComplete(() => mViewModel.startTimer());
                        },
                        child: Text(
                          "Resend OTP",
                          style: getAppStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Request for new OTP after",
                          textAlign: TextAlign.center,
                          style: getAppStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CommonColors.blackColor,
                          ),
                        ),
                        Text(
                          " ${mViewModel.second} seconds",
                          textAlign: TextAlign.center,
                          style: getAppStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CommonColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
              kCommonSpaceV50,
              PrimaryButton(
                height: 50,
                label: "Verify and Proceed",
                lblSize: 18,
                onPress: () {
                  if (otpController.text.length != 6) {
                    CommonUtils.showCustomToast(
                        context, "Please enter 6 digits otp");
                  } else {
                    mViewModel.otpVerifyApi(
                      user_id: gUserId,
                      otp: otpController.text,
                      device_token: deviceToken ?? 'no device',
                      device_type: deviceType,
                    );
                  }
                },
              ),
              kCommonSpaceV30
            ],
          ),
        ),
      ),
    );
  }

  Widget otpPinWidget() {
    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.12,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CommonColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: CommonColors.primaryColor.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: CommonColors.mTransparent,
      ),
    );

    return Pinput(
      controller: otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none, // Corrected here
      onCompleted: (pin) async {
        mViewModel.otpVerifyApi(
          user_id: gUserId,
          otp: pin,
          device_token: deviceToken ?? 'no device',
          device_type: deviceType,
        );
      },
    );
  }
}

class RegEx {
  static final validPasswordRegex = RegExp("^.{8,}\$");
  static final validEmailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final validNameRegex = RegExp(r"^[a-zA-Z ]{3,50}$");
  static final validNomineeNameRegex = RegExp(r"^[a-zA-Z][a-zA-Z `']{1,32}$");
  static final validPANNameRegex = RegExp(r"^[a-zA-Z][a-zA-Z. `']{1,64}$");
  static final validPhoneNumberRegex = RegExp(r"^[0-9+]{10,13}$");
  static final startsWithCountryCodeRegex = RegExp(r"\+[0-9]{2}[0-9]+$");
  static final validPincodeRegex = RegExp(r"^[0-9]{6}$");
  static final validDateRegex =
      RegExp(r"^(([123]0|[012][1-9]|31)-(0[1-9]|1[012])-[0-9]{4})$");
  static final validPANRegex = RegExp(r"^[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}$");
  static final validBankAccountNumber = RegExp(r"^[,0-9]{9,20}$");
  static final goalNameRegex = RegExp(r'^[\x00-\x7F]+$');
  static final validAccountHolderNameRegex = RegExp(r'^.{4,120}$');
  static final otpLengthRegex = RegExp(r'(\d{6})');
}
