import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/brand_product_master.dart';

import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class SubBrandViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;
  List<BrandProduct> brandProductList = [];
  List<Brand> brandCategoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getBrandProductApi(
      {required String latitude,
      required String longitude,
      required String brandId}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.brand_id: brandId,
    };

    BrandProductMaster? master =
        await services.api!.getBrandProductApi(params: params);
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
      brandProductList.addAll(master.data?.product ?? []);
      brandCategoryList.addAll(master.data?.brand ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      brandProductList.clear();
      // subCategoryList.clear();
      notifyListeners();
    });
  }
}