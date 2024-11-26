import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../services/index.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../models/transaction_history_master.dart';
import '../../../services/api_para.dart';

class TransactionHistoryViewModel with ChangeNotifier {
  late BuildContext context;

  final services = Services();
  int currentPage = 1;
  bool isPageFinish = false;
  bool isInitialLoading = true;

  List<Total> transactionHistoryTotal = [];

  List<TransactionList> transactionHistoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    getTransactionHistoryApi();
    notifyListeners();
  }

  Future<void> getTransactionHistoryApi() async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.page: currentPage.toString(),
    };
    TransactionHistoryMaster? master =
        await services.api!.getTransactionHistoryApi(params: params);
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      if (currentPage == master.totalPage!) {
        isPageFinish = true;
      } else {
        currentPage++;
      }
      transactionHistoryTotal = master.data?.total ?? [];
      transactionHistoryList.addAll(master.data?.list ?? []);
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPage = 1;
      isPageFinish = false;
      isInitialLoading = true;
      transactionHistoryTotal.clear();
      transactionHistoryList.clear();
      notifyListeners();
    });
  }
}
