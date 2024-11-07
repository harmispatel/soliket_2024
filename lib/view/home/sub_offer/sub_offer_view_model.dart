import 'package:flutter/cupertino.dart';

import '../../../models/offer_product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class SubOfferViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;
  List<OfferProduct> offerProductList = [];
  List<Offer> offerCategoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getOfferProductApi(
      {required String latitude,
      required String longitude,
      required String offerId}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.offer_id: offerId,
    };

    OfferProductMaster? master =
        await services.api!.getOfferProductApi(params: params);
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
      if (currentPage > master.totalPage!) {
        isPageFinish = true;
      }
      currentPage++;
      offerProductList.addAll(master.data?.product ?? []);
      offerCategoryList.addAll(master.data?.offer ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      offerProductList.clear();
      // subCategoryList.clear();
      notifyListeners();
    });
  }
}
