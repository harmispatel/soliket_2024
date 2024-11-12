import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/home/profile/policies/policies_view.dart';
import 'package:solikat_2024/view/home/profile/profile_view_model.dart';
import 'package:solikat_2024/view/home/profile/save_address/saved_address_view.dart';
import 'package:solikat_2024/widget/common_appbar.dart';
import '../../../utils/common_utils.dart';
import 'about_us/about_us_view.dart';
import 'contact_us/contact_us_view.dart';
import 'edit_account/edit_account_view.dart';
import 'faq/faq_view.dart';
import 'help_&_support/help_&_support_view.dart';
import 'my_orders/my_orders_view.dart';
import 'notification/notification_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getProfileApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProfileViewModel>(context);
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
            !mViewModel.isInitialLoading
                ? Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          // mViewModel.profileData?.profile ?? '',
                          'https://img.freepik.com/premium-vector/silver-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-vector-illustration_561158-4195.jpg',
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
                            mViewModel.profileData?.name ?? '',
                            style: getAppStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          kCommonSpaceV3,
                          Text(
                            "+91 ${mViewModel.profileData?.mobile}",
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
                          push(
                            EditAccountView(
                              name: mViewModel.profileData?.name,
                              email: mViewModel.profileData?.email,
                              phone: mViewModel.profileData?.mobile,
                              birthDate: mViewModel.profileData?.birthday,
                              profileImage:
                                  "https://img.freepik.com/premium-vector/silver-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-vector-illustration_561158-4195.jpg",
                              // profileImage: mViewModel.profileData?.profile,
                            ),
                          ).then((_) {
                            mViewModel.getProfileApi();
                          });
                        },
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.grey,
                          size: 21,
                        ),
                      ),
                    ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              kCommonSpaceH15,
                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       push(MyCartView());
            //     },
            //     child: Text(
            //       "See Cart Screen",
            //       style: getAppStyle(fontSize: 20, color: Colors.blueAccent),
            //     ),
            //   ),
            // ),
            // kCommonSpaceV20,
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
  late ProfileViewModel mViewModel;

  final List<Map<String, dynamic>> profileOptions = [
    {'icon': Icons.shopping_cart_outlined, 'title': ' My Orders'},
    {'icon': Icons.notifications_none_outlined, 'title': ' Notification'},
    {'icon': Icons.bookmark_add_outlined, 'title': ' Save Addresses'},
    {'icon': Icons.messenger_outline_rounded, 'title': ' Help & support'},
    {'icon': Icons.headset_mic_outlined, 'title': ' Contact Us'},
    {'icon': Icons.translate, 'title': ' Change Language'},
    {'icon': Icons.star_border_purple500_outlined, 'title': ' Rate Us'},
    {'icon': Icons.info_outline, 'title': ' About Us'},
    {'icon': Icons.policy_outlined, 'title': ' Policies'},
    {'icon': Icons.question_mark_rounded, 'title': ' FAQ'},
    {'icon': Icons.logout_rounded, 'title': ' Logout'},
  ];

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProfileViewModel>(context);

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
                push(NotificationView());
              } else if (index == 2) {
                push(SaveAddressView());
              } else if (index == 3) {
                push(HelpSupportView());
              } else if (index == 4) {
                push(ContactUsView());
              } else if (index == 7) {
                push(AboutUsView());
              } else if (index == 8) {
                push(PoliciesView());
              } else if (index == 9) {
                push(FaqView());
              } else if (index == 10) {
                mViewModel.logOutApi();
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
