// import 'package:flutter/material.dart';
// import '../../../../utils/common_colors.dart';
// import '../../../../utils/constant.dart';
// import '../../../../utils/local_images.dart';
// import '../../../../widget/common_appbar.dart';
//
// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});
//
//   @override
//   State<NotificationView> createState() => _NotificationViewState();
// }
//
// class _NotificationViewState extends State<NotificationView> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: CommonColors.grayShade200,
//         appBar: const CommonAppBar(
//           title: "Notification",
//           isShowShadow: true,
//           isTitleBold: true,
//           iconTheme: IconThemeData(color: CommonColors.blackColor),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             margin: kCommonScreenPadding,
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               color: CommonColors.mWhite,
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   height: 70,
//                   width: 70,
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                       gradient: new LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           CommonColors.primaryColor,
//                           CommonColors.primaryColor.withOpacity(0.55)
//                         ],
//                       ),
//                     borderRadius: BorderRadius.circular(12),
//                     color: CommonColors.primaryColor,
//                   ),
//                   child: Image.asset(
//                     LocalImages.img_notification,
//                     color: CommonColors.mWhite,
//                   ),
//                 ),
//                 kCommonSpaceH20,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Limitel Time Offers! ⏳",
//                         style: getAppStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: CommonColors.blackColor),
//                       ),
//                       kCommonSpaceV10,
//                       Text(
//                         "Hurry! Exclusive deals are running out fast! Grab your daily essentials at unbeatable prices before they're gone! 🛒✨",
//                         style: getAppStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                             color: CommonColors.blackColor),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';
import '../../../../widget/common_appbar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<Map<String, String>> notifications = [
    {
      "title": "Limited Time Offer! ⏳",
      "message":
          "Hurry! Exclusive deals are running out fast! Grab your daily essentials at unbeatable prices before they're gone! 🛒✨",
    },
    {
      "title": "Flash Sale!",
      "message":
          "Don't miss out on our 24-hour flash sale! Get up to 50% off selected items! 🛍️💥",
    },
    {
      "title": "New Arrivals Alert!",
      "message":
          "Check out the latest additions to our collection. Be the first to shop the newest trends! 👗👟",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.grayShade200,
        appBar: const CommonAppBar(
          title: "Notification",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: ListView.builder(
          padding: kCommonScreenPadding,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: CommonColors.mWhite,
              ),
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          CommonColors.primaryColor,
                          CommonColors.primaryColor.withOpacity(0.55)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      LocalImages.img_notification,
                      color: CommonColors.mWhite,
                    ),
                  ),
                  kCommonSpaceH20,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notifications[index]['title']!,
                          style: getAppStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CommonColors.blackColor),
                        ),
                        kCommonSpaceV5,
                        Text(
                          notifications[index]['message']!,
                          style: getAppStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: CommonColors.blackColor),
                        ),
                      ],
                    ),
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
