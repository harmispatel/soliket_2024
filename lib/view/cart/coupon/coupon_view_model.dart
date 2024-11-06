import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../models/coupon_master.dart';

class CouponViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = true;
  List<CouponData> couponList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    getCouponApi();
    notifyListeners();
  }

  Future<void> getCouponApi() async {
    GetCouponMaster? master = await _services.api!.getCouponApi();
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
      couponList = master.data ?? [];
    }
    notifyListeners();
  }
}
