import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/get_cart_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class CartViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isInitialLoading = true;
  List<CartData> cartList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    getCartApi();
    notifyListeners();
  }

  Future<void> getCartApi() async {
    GetCartMaster? master = await _services.api!.getCartApi();
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
      cartList = master.data ?? [];
    }
    notifyListeners();
  }
}
