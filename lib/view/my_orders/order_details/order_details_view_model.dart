import 'package:flutter/cupertino.dart';

import '../../../models/order_details_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class OrderDetailsViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getOrdersDetailsApi({required String orderId}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.order_id: orderId,
    };

    OrderDetailsMaster? master =
        await services.api!.getOrderDetails(params: params);
    isInitialLoading = false;

    notifyListeners();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

    if (master.status == true) {}
    notifyListeners();
  }
}
