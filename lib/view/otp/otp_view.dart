import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';
import '../../widget/common_appbar.dart';
import '../../widget/primary_button.dart';
import '../location/location_allow_view.dart';
import '../location/location_donNot_allow_view.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    print(status);

    if (status.isGranted) {
      print("Location permission already granted.");
      push(LocationAllowView());
    } else if (status.isPermanentlyDenied) {
      // Show a message and prompt the user to open settings
      // CommonUtils.showSnackBar(
      //   "Location permission is required to proceed. Please enable it in settings.",
      //   color: CommonColors.mRed,
      // );

      push(LocationDonNotAllowView());

      // Optionally, open the app settings
      await openAppSettings();
    } else {
      // Request permission
      var result = await Permission.location.request();

      if (result.isGranted) {
        print("Location permission granted.");
        push(LocationAllowView());
      } else {
        // CommonUtils.showSnackBar(
        //   "Location permission is required to proceed.",
        //   color: CommonColors.mRed,
        // );
        push(LocationDonNotAllowView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(LocalImages.img_splash_logo),
              ),
              kCommonSpaceV80,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code resent After: ",
                    style:
                        getAppStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "59",
                    style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: CommonColors.primaryColor),
                  ),
                ],
              ),
              kCommonSpaceV50,
              PrimaryButton(
                height: 50,
                label: "Verify and Proceed",
                lblSize: 20,
                onPress: () {
                  requestLocationPermission();
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
      width: MediaQuery.sizeOf(context).width * 0.12,
      height: MediaQuery.sizeOf(context).width * 0.12,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: CommonColors.primaryColor,
        ),
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
      // controller: otpFieldController,
      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: 6,
      submittedPinTheme: submittedPinTheme,
      // validator: (s) {
      //   return s == '2222' ? null : 'Pin is incorrect';
      // },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      // onChanged: (pin) => editOtp = pin,
      // onCompleted: (pin) => editOtp = pin,
    );
    // return OTPTextField(
    //   length: otpLength,
    //   controller: otpFieldController,
    //   fieldWidth: MediaQuery.sizeOf(context).width * 0.12,
    //   width: MediaQuery.sizeOf(context).width,
    //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
    //   fieldStyle: FieldStyle.box,
    //   outlineBorderRadius: 10,
    //   inputFormatter: [FilteringTextInputFormatter.digitsOnly],
    //   otpFieldStyle: OtpFieldStyle(
    //       borderColor: ColorsRes.appColor,
    //       enabledBorderColor: ColorsRes.appColor),
    //   keyboardType: TextInputType.number,
    //   style: TextStyle(
    //     color: ColorsRes.appColor,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   onChanged: (value) {
    //     editOtp = value;
    //   },
    //   onCompleted: (value) {
    //     editOtp = value;
    //   },
    // );
  }
}

///////.///////
