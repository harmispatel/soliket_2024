import 'package:flutter/cupertino.dart';

import '../../../models/button_product_master.dart';
import '../../../models/product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';

class ViewAllProductsViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;
  List<ProductData> viewAllProductList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getViewAllProductApi({
    required String latitude,
    required String longitude,
    required String productId,
    required bool isReset,
  }) async {
    if (isReset) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      viewAllProductList.clear();
    }

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.product_id: productId,
    };

    ButtonProductMaster? master =
        await services.api!.getButtonProductApi(params: params);

    isInitialLoading = false;
    notifyListeners();

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
      }
      currentPage++;
      viewAllProductList.addAll(master.data ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      viewAllProductList.clear();
      notifyListeners();
    });
  }
}
