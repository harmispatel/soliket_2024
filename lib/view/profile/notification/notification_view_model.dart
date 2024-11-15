import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../utils/common_utils.dart';
import '../../../../models/notification_master.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';

class NotificationViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<NotificationData> notificationList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    getNotificationApi();
    notifyListeners();
  }

  Future<void> getNotificationApi() async {
    NotificationMaster? master = await services.api!.getNotificationApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      notificationList = master.data ?? [];
    }
    notifyListeners();
  }
}
