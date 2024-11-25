import 'package:flutter/cupertino.dart';

import '../../../models/track_order_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class TrackingOrdersViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  bool isInitialLoading = true;
  List<TrackOrderData> trackOrderData = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> trackingOrderApi({required String orderId}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.order_id: orderId,
    };

    TrackOrderMaster? master =
        await services.api!.trackingOrder(params: params);
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

    if (master.status == true) {
      trackOrderData = master.data ?? [];
    }
    notifyListeners();
  }
}
