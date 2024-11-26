import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../models/faq_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_utils.dart';

class FaqViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  List<FaqData> faqList = [];
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getFaqApi() async {
    FaqMaster? master = await services.api!.getFaqApi();
    isInitialLoading = false;

    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      faqList = master.data ?? [];
    }
    notifyListeners();
  }
}
