import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/profile/policies/policies_view.dart';
import 'package:solikat_2024/view/profile/profile_view_model.dart';
import 'package:solikat_2024/view/profile/save_address/saved_address_view.dart';
import 'package:solikat_2024/view/profile/transaction_history/transaction_history_view.dart';
import 'package:solikat_2024/widget/common_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/primary_button.dart';
import '../my_orders/my_orders_view.dart';
import 'about_us/about_us_view.dart';
import 'contact_us/contact_us_view.dart';
import 'edit_account/edit_account_view.dart';
import 'faq/faq_view.dart';
import 'notification/notification_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel mViewModel;

  final List<Map<String, dynamic>> profileOptions = [
    {'icon': Icons.shopping_cart_outlined, 'title': ' My Orders'},
    {'icon': Icons.bookmark_add_outlined, 'title': ' Saved Addresses'},
    {'icon': Icons.receipt_long, 'title': ' Transaction History'},
    {'icon': Icons.notifications_none_outlined, 'title': ' Notification'},
    {'icon': Icons.info_outline, 'title': ' About Us'},
    {'icon': Icons.headset_mic_outlined, 'title': ' Contact Us'},
    {'icon': Icons.policy_outlined, 'title': ' Policies'},
    {'icon': Icons.question_mark_rounded, 'title': ' FAQ'},
    {'icon': Icons.star_border_purple500_outlined, 'title': ' Rate Us'},
    {'icon': Icons.share, 'title': ' Share App'},
    {'icon': Icons.logout_rounded, 'title': ' Logout'},
    {'icon': Icons.delete_forever, 'title': ' Delete Account'},
  ];

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
      body: SingleChildScrollView(
        padding: kCommonScreenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !mViewModel.isInitialLoading
                ? Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          mViewModel.profileData?.profile ?? '',
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
                              profileImage: mViewModel.profileData?.profile,
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
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
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
            ListView.builder(
              itemCount: profileOptions.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                bool isLastTwo = index == profileOptions.length - 1 ||
                    index == profileOptions.length - 2;

                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    print(index);
                    if (index == 0) {
                      push(MyOrdersView());
                    } else if (index == 1) {
                      push(SaveAddressView());
                    } else if (index == 2) {
                      push(TransactionHistoryView());
                    } else if (index == 3) {
                      push(NotificationView());
                    } else if (index == 4) {
                      push(AboutUsView());
                    } else if (index == 5) {
                      push(ContactUsView());
                    } else if (index == 6) {
                      push(PoliciesView());
                    } else if (index == 7) {
                      push(FaqView());
                    } else if (index == 8) {
                      _rateUsURL();
                    } else if (index == 9) {
                      _shareText();
                    } else if (index == 10) {
                      showConfirmationBottomSheet(
                        title: "Logout",
                        message:
                            "Are you sure you want to logout of your account?",
                        onConfirm: () {
                          mViewModel.logOutApi();
                        },
                      );
                    } else if (index == 11) {
                      showConfirmationBottomSheet(
                        title: "Delete Account",
                        message:
                            "Are you sure you want to delete your account?",
                        onConfirm: () {
                          mViewModel.deleteAccount();
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Icon(
                          profileOptions[index]["icon"],
                          color: isLastTwo ? Colors.red : Colors.black,
                        ),
                        kCommonSpaceH10,
                        Text(
                          profileOptions[index]["title"],
                          style: getAppStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isLastTwo ? Colors.red : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        if (!isLastTwo)
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
            kCommonSpaceV20,
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Text(
                  "v${mViewModel.latestAppVersion.toString().replaceAll('"', '')}",
                  style: getAppStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _rateUsURL() async {
    if (await canLaunch(playStoreUrl)) {
      await launch(playStoreUrl);
    } else {
      throw 'Could not launch $playStoreUrl';
    }
  }

  void _shareText() {
    Share.share('Check out this amazing Flutter app!');
  }

  void showConfirmationBottomSheet({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showModalBottomSheet(
      context: mainNavKey.currentContext!,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: CommonColors.mWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.zero),
      ),
      builder: (_) {
        return IntrinsicHeight(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: double.infinity,
                    color: CommonColors.primaryColor,
                    child: Center(
                      child: Text(
                        title,
                        overflow: TextOverflow.clip,
                        style: getAppStyle(
                          color: CommonColors.mWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, right: 10, left: 10),
                    child: Text(
                      message,
                      overflow: TextOverflow.clip,
                      style: getAppStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20) +
                        const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryButton(
                          height: 40,
                          width: 100,
                          label: "No",
                          buttonColor: CommonColors.mWhite,
                          labelColor: CommonColors.primaryColor,
                          borderColor: CommonColors.primaryColor,
                          onPress: () {
                            Navigator.pop(context);
                          },
                        ),
                        kCommonSpaceH15,
                        PrimaryButton(
                          height: 40,
                          width: 100,
                          label: "Yes",
                          buttonColor: CommonColors.primaryColor,
                          labelColor: CommonColors.mWhite,
                          onPress: onConfirm,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
// //* forceUpdateBottomSheet Code * //
//
// void forceUpdateBottomSheet() {
//   showModalBottomSheet(
//     context: mainNavKey.currentContext!,
//     clipBehavior: Clip.antiAlias,
//     isScrollControlled: true,
//     useSafeArea: true,
//     backgroundColor: CommonColors.mWhite,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.zero,
//       ),
//     ),
//     builder: (_) {
//       return IntrinsicHeight(
//         child: StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20) +
//                   const EdgeInsets.only(top: 22, bottom: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(14),
//                     child: Image.asset(
//                       LocalImages.img_splash_logo,
//                       height: 70,
//                       width: 70,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   kCommonSpaceV20,
//                   Text(
//                     "New Update Available",
//                     style: getAppStyle(
//                       color: CommonColors.blackColor,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, bottom: 26),
//                     child: Text(
//                       "Update your Soliket app for seamiess experience with new features. You can keep using the app while we update in background.",
//                       overflow: TextOverflow.clip,
//                       style: getAppStyle(
//                         color: Colors.black.withOpacity(0.6),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       PrimaryButton(
//                         height: 55,
//                         width: 100,
//                         label: "Skip",
//                         buttonColor: CommonColors.grayShade200,
//                         labelColor: CommonColors.blackColor,
//                         onPress: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       kCommonSpaceH15,
//                       Expanded(
//                         child: PrimaryButton(
//                           height: 55,
//                           label: "Update App",
//                           buttonColor: CommonColors.primaryColor,
//                           labelColor: CommonColors.mWhite,
//                           onPress: () {
//                             openStoreListing();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     },
//   );
// }
//
// Future<void> openStoreListing() async {
//   const url =
//       "https://play.google.com/store/apps/details?id=com.ludo.king&pcampaignid=web_share";
//   if (url.isNotEmpty) {
//     await tryLaunch(url);
//   } else {
//     log("No URL provided for $url platform");
//   }
// }
//
// Future<bool> tryLaunch(
//     String link, {
//       Function()? onCannotLaunch,
//       LaunchMode mode = LaunchMode.externalApplication,
//     }) async {
//   final uri = Uri.parse(link);
//   if (await canLaunchUrl(uri)) {
//     try {
//       return await launchUrl(
//         uri,
//         mode: mode,
//         webViewConfiguration: const WebViewConfiguration(),
//       );
//     } catch (e) {
//       log("Error launching $link: $e");
//       onCannotLaunch?.call();
//     }
//   } else {
//     log("Cannot launch $link");
//     onCannotLaunch?.call();
//   }
//   return false;
// }
//
// //* forceUpdateBottomSheet Code * //
