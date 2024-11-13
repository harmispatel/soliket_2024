import 'package:flutter/material.dart';
import 'package:solikat_2024/view/home/profile/policies/privacy_policy/privacy_policy_view.dart';
import 'package:solikat_2024/view/home/profile/policies/return_policy/return_policy_view.dart';
import 'package:solikat_2024/view/home/profile/policies/shipping_policy/shipping_policy_view.dart';
import 'package:solikat_2024/view/home/profile/policies/terms_and_conditions/terms_and_conditions_view.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';
import 'cancellation_policy/cancellation_policy_view.dart';

class PoliciesView extends StatefulWidget {
  const PoliciesView({super.key});

  @override
  State<PoliciesView> createState() => _PoliciesViewState();
}

class _PoliciesViewState extends State<PoliciesView> {
  final List<Map<String, dynamic>> policiesOptions = [
    {'title': ' Privacy policy'},
    {'title': ' Terms & Conditions'},
    {'title': ' Shipping Policy'},
    {'title': ' Return & Exchanges Policy'},
    {'title': ' Cancellation Policy'},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Policies",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: ListView.builder(
          padding: kCommonScreenPadding + EdgeInsets.only(top: 10),
          itemCount: policiesOptions.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                print(index);
                if (index == 0) {
                  push(PrivacyPolicyView());
                } else if (index == 1) {
                  push(TermsAndConditionsView());
                } else if (index == 2) {
                  push(ShippingPolicyView());
                } else if (index == 3) {
                  push(ReturnPolicyView());
                } else if (index == 4) {
                  push(CancellationPolicyView());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        policiesOptions[index]["title"],
                        style: getAppStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: CommonColors.mGrey500,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: CommonColors.mGrey300),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
