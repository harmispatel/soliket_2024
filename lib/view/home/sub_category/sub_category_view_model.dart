import 'package:flutter/cupertino.dart';

import '../../../models/category_product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class SubCategoryViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;

  List<CategoryProduct> categoryProductList = [];
  List<SubCategory> subCategoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getCategoryProductApi(
      {required String latitude,
      required String longitude,
      required int currentPage,
      required String categoryId}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.category_id: categoryId,
    };

    GetCategoryProductMaster? master =
        await services.api!.getCategoryProductApi(params: params);
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
      categoryProductList.addAll(master.data?.product ?? []);
      subCategoryList.addAll(master.data?.subCategory ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      categoryProductList.clear();
      subCategoryList.clear();
      notifyListeners();
    });
  }
}