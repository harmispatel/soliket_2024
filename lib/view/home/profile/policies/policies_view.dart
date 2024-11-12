import 'package:flutter/material.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';

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
            title: "Profile",
            isShowShadow: true,
            isTitleBold: true,
            iconTheme: IconThemeData(color: CommonColors.blackColor),
          ),
          body: Expanded(
            child: ListView.builder(
              padding: kCommonScreenPadding + EdgeInsets.only(top: 10),
              itemCount: policiesOptions.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    print(index);
                    if (index == 0) {
                      //push(MyOrdersView());
                    } else if (index == 1) {
                      //push(NotificationView());
                    } else if (index == 2) {
                      //push(SaveAddressView());
                    } else if (index == 3) {
                      //push(HelpSupportView());
                    } else if (index == 4) {
                      //push(ContactUsView());
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
                        child: Divider(color: CommonColors.mGrey500,),
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
