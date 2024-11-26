import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/category_master.dart';

import '../../services/index.dart';
import '../../utils/common_utils.dart';

class CategoryViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  bool isInitialLoading = true;
  List<CategoryData> categoryListData = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getCategoryApi() async {
    CategoryMaster? master = await services.api!.getCategoryApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      categoryListData = master.data ?? [];
    }
    notifyListeners();
  }
}
