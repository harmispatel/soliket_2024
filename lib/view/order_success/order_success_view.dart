import 'package:flutter/material.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';
import '../../widget/common_appbar.dart';
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
        appBar: CommonAppBar(
          automaticallyImplyLeading: false,
          title: "Order Confirmed",
          isShowShadow: true,
          isTitleBold: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 160, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ_KPMKbQ0JLUNVf4Ac-aOFTRQpHPlK6V-Qw&s",
                height: 200,
              ),
              kCommonSpaceV20,
              kCommonSpaceV20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Your Order Has Been Placed You Will Receive on Email Receive Shortly",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontSize: 18,
                      color: CommonColors.blackColor),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print("Order Tracking");
                },
                child: Column(
                  children: [
                    Text(
                      "Order Tracking",
                      textAlign: TextAlign.center,
                      style: getAppStyle(
                        color: CommonColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 112,
                      color: CommonColors.primaryColor,
                    )
                  ],
                ),
              ),
              kCommonSpaceV20,
              kCommonSpaceV20,
              PrimaryButton(
                height: 55,
                label: "Order Continue",
                buttonColor: CommonColors.primaryColor,
                labelColor: CommonColors.mWhite,
                onPress: () {
                  print("Order Continue");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
