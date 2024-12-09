import 'package:flutter/cupertino.dart';

import '../../../models/offer_product_master.dart';
import '../../../models/product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';

class SubOfferViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;
  List<ProductData> offerProductList = [];
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
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      if (currentPage == master.totalPage!) {
        isPageFinish = true;
      } else {
        currentPage++;
      }
      offerProductList.addAll(master.data?.product ?? []);
      // offerCategoryList.addAll(master.data?.offer ?? []);

      final newItems = (master.data?.offer ?? []);

      Set<int?> existingIds = offerCategoryList.map((e) => e.offerId).toSet();

      for (var item in newItems) {
        if (!existingIds.contains(item.offerId)) {
          offerCategoryList.add(item);
          existingIds.add(item.offerId);
        }
      }
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
