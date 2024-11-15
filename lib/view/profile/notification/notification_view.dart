import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/local_images.dart';
import '../../../../widget/common_appbar.dart';
import 'notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late NotificationViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  void dispose() {
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<NotificationViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.grayShade200,
        appBar: const CommonAppBar(
          title: "Notification",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: mViewModel.isInitialLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: SingleChildScrollView(
                        padding: kCommonScreenPadding,
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                height: 70.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
              )
            : mViewModel.notificationList.isEmpty
                ? Center(
                    child: Padding(
                      padding: kCommonScreenPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            height: 180,
                            "https://cdni.iconscout.com/illustration/premium/thumb/no-notifications-illustration-download-in-svg-png-gif-file-formats--notification-mail-empty-state-pack-design-development-illustrations-4841580.png",
                          ),
                          kCommonSpaceV20,
                          Text(
                            "No Notification Here",
                            textAlign: TextAlign.center,
                            style: getAppStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: Text(
                              "There is no notification to show right now.",
                              textAlign: TextAlign.center,
                              style: getAppStyle(
                                  fontSize: 18, color: CommonColors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: kCommonScreenPadding,
                    itemCount: mViewModel.notificationList.length,
                    itemBuilder: (context, index) {
                      var notificationData = mViewModel.notificationList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(8),
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
                                    notificationData.title ?? "",
                                    style: getAppStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CommonColors.blackColor),
                                  ),
                                  kCommonSpaceV5,
                                  Text(
                                    notificationData.description ?? "",
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
