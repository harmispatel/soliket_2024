import 'package:flutter/material.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';
import '../../widget/primary_button.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.mWhite,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 150, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                LocalImages.img_success,
                height: 180,
              ),
              kCommonSpaceV20,
              kCommonSpaceV20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Your Order has been accepted",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: CommonColors.blackColor),
                ),
              ),
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Your items has been placed and is on it's way to being processed",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: CommonColors.mGrey500),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                height: 55,
                label: "Track Order",
                buttonColor: CommonColors.iosGreenColor,
                labelColor: CommonColors.mWhite,
                onPress: () {
                  print("Track Order");
                },
              ),
              kCommonSpaceV20,
              kCommonSpaceV10,
              GestureDetector(
                onTap: () {
                  print("Back to home");
                },
                child: Text(
                  "Back to home",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
