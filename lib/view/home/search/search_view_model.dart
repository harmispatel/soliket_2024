import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/search_master.dart';

import '../../../models/product_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';

class SearchViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  // int currentPage = 1;
  // bool isPageFinish = false;
  bool isInitialLoading = true;
  List<ProductData> productList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getSearchDataApi({
    required String latitude,
    required String longitude,
    required String keyWord,
  }) async {
    Map<String, dynamic> params = <String, dynamic>{
      // ApiParams.page: currentPage.toString(),
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.keyword: keyWord,
    };

    SearchMaster? master = await services.api!.getSearchDataApi(params: params);

    isInitialLoading = false;

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    // print(".................... page : ${currentPage} ................");

    if (master.status == true) {
      // if (currentPage == master.totalPage!) {
      //   isPageFinish = true;
      // } else {
      //   currentPage++;
      // }
      // productList = master.data ?? [];
      productList.addAll(master.data ?? []);
    }

    // print(".................... page : ${currentPage} ................");

    notifyListeners();
  }
}
