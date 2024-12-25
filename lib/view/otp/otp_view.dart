import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/global_variables.dart';
import '../../utils/local_images.dart';
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
    Future.delayed(Duration.zero, () async {
      mViewModel.attachedContext(context);
      mViewModel.startTimer();
      if (Platform.isAndroid) {
        otpController = OTPTextEditController(codeLength: 6)
          ..startListenUserConsent((value) {
            final exp = RegEx.otpLengthRegex;
            final matchedString = exp.stringMatch(value ?? '') ?? '';
            if (exp.hasMatch(value ?? '')) {
              otpController.text = matchedString;
            }
            return matchedString;
          });
      } else if (Platform.isIOS) {
        await SmsAutoFill().listenForCode();
      }
    });
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      otpController.dispose();
    } else if (Platform.isIOS) {
      SmsAutoFill().unregisterListener();
    }
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

  Future<void> _dialNumber(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _redirectToWhatsApp(String phoneNumber, String message) async {
    final Uri launchUri = Uri(
        scheme: 'https',
        host: 'wa.me',
        path: phoneNumber,
        queryParameters: {'text': message});
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OtpViewModel>(context);
    return Scaffold(
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
            FittedBox(
              child: Row(
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
            kCommonSpaceV50,
            kCommonSpaceV50,
            Text(
              "अगर आपको OTP प्राप्त नहीं हो रहा है, तो आप कॉल या व्हाट्सएप पर संपर्क करके समस्या हल कर सकते हैं।",
              textAlign: TextAlign.center,
              style: getAppStyle(fontSize: 18, height: 1.2),
            ),
            kCommonSpaceV10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      _dialNumber("8982188799");
                    },
                    child: Image.asset(height: 50, LocalImages.img_call)),
                kCommonSpaceH20,
                kCommonSpaceH20,
                GestureDetector(
                    onTap: () {
                      _redirectToWhatsApp("+918982188799",
                          "Hello, Soliket \nमेरे नंबर पर OTP प्राप्त नहीं हो रहा है।");
                    },
                    child: Image.asset(height: 50, LocalImages.img_whatsapp)),
              ],
            )
          ],
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
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
      // onCompleted: (pin) async {
      //   mViewModel.otpVerifyApi(
      //     user_id: gUserId,
      //     otp: pin,
      //     device_token: deviceToken ?? 'no device',
      //     device_type: deviceType,
      //   );
      // },
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
