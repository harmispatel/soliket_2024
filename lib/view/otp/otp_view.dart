import 'package:flutter/material.dart';
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
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with CodeAutoFill {
  late OtpViewModel mViewModel;
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
    startListeningForSms();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  void codeUpdated() {
    otpController.text = code ?? '';
    // Optionally trigger verification here
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
          title: "SOLIKET",
          isTitleBold: true,
          bgColor: CommonColors.mTransparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your code",
                style: getAppStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Text(
                    "Code sent to +918888899999 ",
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
              Center(child: otpPinWidget()),
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
                          "Request for new OTP in",
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
                    CommonUtils.showSnackBar(
                      "Please enter 6 digits otp",
                      color: CommonColors.mRed,
                    );
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
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CommonColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: CommonColors.primaryColor.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: CommonColors.primaryColor.withOpacity(.1),
      ),
    );

    return Pinput(
      controller: otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: 6,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none, // Corrected here
      onCompleted: (pin) {
        // Optionally trigger verification here
        mViewModel.otpVerifyApi(
          user_id: gUserId,
          otp: pin,
          device_token: deviceToken ?? 'no device',
          device_type: deviceType,
        );
      },
    );
  }

  void startListeningForSms() async {
    SmsAutoFill().listenForCode;
  }
}

// ======> Without OTP Auto Fil <====== //

// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:provider/provider.dart';
//
// import '../../utils/common_colors.dart';
// import '../../utils/common_utils.dart';
// import '../../utils/constant.dart';
// import '../../utils/global_variables.dart';
// import '../../widget/common_appbar.dart';
// import '../../widget/primary_button.dart';
// import 'otp_view_model.dart';
//
// class OtpView extends StatefulWidget {
//   const OtpView({super.key});
//
//   @override
//   State<OtpView> createState() => _OtpViewState();
// }
//
// class _OtpViewState extends State<OtpView> {
//   late OtpViewModel mViewModel;
//   final TextEditingController otpController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       mViewModel.attachedContext(context);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     mViewModel = Provider.of<OtpViewModel>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: CommonAppBar(
//           title: "SOLIKET",
//           isTitleBold: true,
//           bgColor: CommonColors.mTransparent,
//           iconTheme: IconThemeData(color: Colors.black),
//         ),
//         body: SingleChildScrollView(
//           padding: kCommonScreenPadding,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Padding(
//               //   padding: const EdgeInsets.all(25.0),
//               //   child: Image.asset(LocalImages.img_splash_logo),
//               // ),
//               // kCommonSpaceV80,
//               Text(
//                 "Enter your code",
//                 style: getAppStyle(fontWeight: FontWeight.w500, fontSize: 20),
//               ),
//               kCommonSpaceV20,
//               Row(
//                 children: [
//                   Text(
//                     "Code sent to +918888899999 ",
//                     style: getAppStyle(fontSize: 14),
//                   ),
//                   Icon(
//                     Icons.edit_outlined,
//                     color: CommonColors.primaryColor,
//                     size: 18,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "Edit",
//                       style: getAppStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                           color: CommonColors.primaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//               kCommonSpaceV20,
//               Center(child: otpPinWidget()),
//               kCommonSpaceV30,
//               mViewModel.second == 0
//                   ? Center(
//                       child: InkWell(
//                         onTap: () {
//                           mViewModel
//                               .reSendOtpApi(user_id: gUserId)
//                               .whenComplete(() => mViewModel.startTimer());
//                         },
//                         child: Text(
//                           "Resend OTP",
//                           style: getAppStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: CommonColors.primaryColor),
//                         ),
//                       ),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Request for new OTP in",
//                           textAlign: TextAlign.center,
//                           style: getAppStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: CommonColors.blackColor,
//                           ),
//                         ),
//                         Text(
//                           " ${mViewModel.second} seconds",
//                           textAlign: TextAlign.center,
//                           style: getAppStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: CommonColors.primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//               kCommonSpaceV50,
//               PrimaryButton(
//                 height: 50,
//                 label: "Verify and Proceed",
//                 lblSize: 18,
//                 onPress: () {
//                   if (otpController.text.length != 6) {
//                     CommonUtils.showSnackBar(
//                       "Please enter 6 digits otp",
//                       color: CommonColors.mRed,
//                     );
//                   } else if (otpController.text.length == 6) {
//                     mViewModel.otpVerifyApi(
//                         user_id: gUserId,
//                         otp: otpController.text.toString(),
//                         device_token: deviceToken ?? 'no device',
//                         device_type: deviceType);
//                   }
//                 },
//               ),
//               kCommonSpaceV30
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget otpPinWidget() {
//     final defaultPinTheme = PinTheme(
//       width: MediaQuery.sizeOf(context).width * 0.12,
//       height: MediaQuery.sizeOf(context).width * 0.12,
//       textStyle: TextStyle(
//         fontSize: 20,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontWeight: FontWeight.w600,
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: CommonColors.primaryColor,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: CommonColors.primaryColor.withOpacity(0.4)),
//       borderRadius: BorderRadius.circular(10),
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration!.copyWith(
//         color: CommonColors.primaryColor.withOpacity(.1),
//       ),
//     );
//
//     return Pinput(
//       controller: otpController,
//       // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
//       defaultPinTheme: defaultPinTheme,
//       focusedPinTheme: focusedPinTheme,
//       length: 6,
//       submittedPinTheme: submittedPinTheme,
//       // validator: (s) {
//       //   return s == '2222' ? null : 'Pin is incorrect';
//       // },
//       pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//       showCursor: true,
//       // onChanged: (pin) => editOtp = pin,
//       // onCompleted: (pin) => editOtp = pin,
//     );
//     // return OTPTextField(
//     //   length: otpLength,
//     //   controller: otpFieldController,
//     //   fieldWidth: MediaQuery.sizeOf(context).width * 0.12,
//     //   width: MediaQuery.sizeOf(context).width,
//     //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
//     //   fieldStyle: FieldStyle.box,
//     //   outlineBorderRadius: 10,
//     //   inputFormatter: [FilteringTextInputFormatter.digitsOnly],
//     //   otpFieldStyle: OtpFieldStyle(
//     //       borderColor: ColorsRes.appColor,
//     //       enabledBorderColor: ColorsRes.appColor),
//     //   keyboardType: TextInputType.number,
//     //   style: TextStyle(
//     //     color: ColorsRes.appColor,
//     //     fontWeight: FontWeight.bold,
//     //   ),
//     //   onChanged: (value) {
//     //     editOtp = value;
//     //   },
//     //   onCompleted: (value) {
//     //     editOtp = value;
//     //   },
//     // );
//   }
// }
