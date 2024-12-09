import 'package:flutter/cupertino.dart';

import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
import '../../models/get_order_master.dart';

class MyOrderViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;

  List<GetOrderData> orderList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getOrdersApi({
    required String status,
  }) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.status: status,
    };

    GetOrderMaster? master = await services.api!.getOrder(params: params);
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      if (currentPage == master.totalPage!) {
        isPageFinish = true;
      } else {
        currentPage++;
      }
      orderList.addAll(master.data ?? []);
    }
    notifyListeners();
  }

  Future<void> resetPage() async {
    await Future.delayed(Duration.zero);
    currentPage = 1;
    isPageFinish = false;
    isInitialLoading = true;
    orderList.clear();
    print("................All Clear.................. ${currentPage}");
    print("................All Clear.................. ${isPageFinish}");
    print("................All Clear.................. ${isInitialLoading}");
    print("................All Clear.................. ${orderList.length}");
    notifyListeners();
  }
}
