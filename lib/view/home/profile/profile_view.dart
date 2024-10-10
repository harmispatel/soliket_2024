import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/home/profile/save_address/save_address_view.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../../utils/common_utils.dart';
import '../../cart/cart_view.dart';
import 'edit_account/edit_account_view.dart';
import 'my_orders/my_orders_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Profile",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: Padding(
        padding: kCommonScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                kCommonSpaceH15,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: getAppStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    kCommonSpaceV3,
                    Text(
                      "+91 1234567890",
                      style: getAppStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    push(EditAccountView());
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.grey,
                    size: 21,
                  ),
                ),
              ],
            ),
            kCommonSpaceV30,
            Text(
              "More Details",
              style: getAppStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            const ProfileOptionsView(),
            Center(
              child: GestureDetector(
                onTap: () {
                  push(MyCartView());
                },
                child: Text(
                  "See Cart Screen",
                  style: getAppStyle(fontSize: 20, color: Colors.blueAccent),
                ),
              ),
            ),
            kCommonSpaceV20,
            Center(
              child: Text(
                "v2.6.1.5(198)",
                style: getAppStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * Profile Options View * //

class ProfileOptionsView extends StatefulWidget {
  const ProfileOptionsView({super.key});

  @override
  State<ProfileOptionsView> createState() => _ProfileOptionsViewState();
}

class _ProfileOptionsViewState extends State<ProfileOptionsView> {
  final List<Map<String, dynamic>> profileOptions = [
    {'icon': Icons.shopping_cart_outlined, 'title': ' My Orders'},
    {'icon': Icons.bookmark_add_outlined, 'title': ' Save Addresses'},
    {'icon': Icons.messenger_outline_rounded, 'title': ' Help & support'},
    {'icon': Icons.translate, 'title': ' Change Language'},
    {'icon': Icons.star_border_purple500_outlined, 'title': ' Rate Us'},
    {'icon': Icons.info_outline, 'title': ' About Us'},
    {'icon': Icons.logout_rounded, 'title': ' Logout'},
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: profileOptions.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print(index);
              if (index == 0) {
                push(MyOrdersView());
              } else if (index == 1) {
                push(SaveAddressView());
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Icon(
                    profileOptions[index]["icon"],
                    color: index == profileOptions.length - 1
                        ? Colors.red
                        : Colors.black,
                  ),
                  kCommonSpaceH10,
                  Text(
                    profileOptions[index]["title"],
                    style: getAppStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: index == profileOptions.length - 1
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  const Spacer(),
                  if (index != profileOptions.length - 1)
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
