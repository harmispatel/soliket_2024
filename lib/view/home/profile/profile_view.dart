import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

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
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    width: 70,
                    height: 70,
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
                    kCommonSpaceV5,
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
                    debugPrint("On Tap Edit Profile Icon Button");
                  },
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            kCommonSpaceV30,
            Text(
              "More Details",
              style: getAppStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const ProfileOptionsView(),
            Center(
              child: Text(
                "Version 2.6.1.5(198)",
                style: getAppStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.withOpacity(0.5),
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
    {'icon': Icons.bookmark_border_rounded, 'title': ' Save Addresses'},
    {'icon': Icons.messenger_outline_rounded, 'title': ' Help & support'},
    {'icon': Icons.language_outlined, 'title': ' Change Language'},
    {'icon': Icons.star_rate_outlined, 'title': ' Rate Us'},
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
                  kCommonSpaceV15,
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
