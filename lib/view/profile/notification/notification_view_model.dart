import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../utils/common_utils.dart';
import '../../../../models/notification_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';

class NotificationViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<NotificationData> notificationList = [];
  bool isInitialLoading = true;
  int currentPage = 1;
  bool isPageFinish = false;

  void attachedContext(BuildContext context) {
    this.context = context;
    getNotificationApi();
    notifyListeners();
  }

  Future<void> getNotificationApi() async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
    };
    NotificationMaster? master =
        await services.api!.getNotificationApi(params: params);
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      if (currentPage == master.totalPage!) {
        isPageFinish = true;
      } else {
        currentPage++;
      }
      notificationList.addAll(master.data ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      notificationList.clear();
      notifyListeners();
    });
  }
}
