import 'package:flutter/cupertino.dart';

import '../../../models/category_product_master.dart';
import '../../../models/product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';

class SubCategoryViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;
  int selectedIndexCategoryId = 0;

  List<ProductData> categoryProductList = [];
  List<SubCategory> subCategoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getCategoryProductApi({
    required String latitude,
    required String longitude,
    required String categoryId,
    required bool isReset,
  }) async {
    if (isReset) {
      currentPage = 1;
      selectedIndexCategoryId = 0;
      isPageFinish = false;
      isInitialLoading = true;
      categoryProductList.clear();
      notifyListeners();
    }

    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.category_id: categoryId,
    };

    GetCategoryProductMaster? master =
        await services.api!.getCategoryProductApi(params: params);
    isInitialLoading = false;
    print(".......... Page ${currentPage}............");

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
      categoryProductList.addAll(master.data?.product ?? []);
      // subCategoryList.addAll(master.data?.subCategory ?? []);
      final newItems = (master.data?.subCategory ?? []);

      Set<int?> existingIds =
          subCategoryList.map((e) => e.subCategoryId).toSet();

      for (var item in newItems) {
        if (!existingIds.contains(item.subCategoryId)) {
          subCategoryList.add(item);
          existingIds.add(item.subCategoryId);
        }
      }
      if (selectedIndexCategoryId == 0 && subCategoryList.isNotEmpty) {
        selectedIndexCategoryId = subCategoryList.first.subCategoryId ?? 0;
      }
    }
    notifyListeners();
  }

  Future<void> resetPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      selectedIndexCategoryId = 0;
      isPageFinish = false;
      isInitialLoading = true;
      categoryProductList.clear();
      // subCategoryList.clear();
      print("Current page ........ $currentPage");
      print("SelectedIndexCategoryId ........ $selectedIndexCategoryId");
      print("isPageFinish ........ $isPageFinish");
      print("isInitialLoading ........ $isInitialLoading");
      print("categoryProductList ........ $categoryProductList");
      notifyListeners();
    });
  }
}
