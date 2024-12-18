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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    final mViewModel = context.read<NotificationViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getNotificationApi();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.resetPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<NotificationViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFF4E8),
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
                          Image.asset(
                            height: 180,
                            LocalImages.img_no_notification,
                          ),
                          kCommonSpaceV20,
                          Text(
                            "No Notification Here",
                            textAlign: TextAlign.center,
                            style: getAppStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: kCommonScreenPadding,
                    controller: _scrollController,
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
