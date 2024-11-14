import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../models/transaction_history_master.dart';

class TransactionHistoryViewModel with ChangeNotifier {
  late BuildContext context;

  final services = Services();

  bool isInitialLoading = true;

  List<Total>? transactionHistoryTotal = [];

  List<TransactionList>? transactionHistoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    getTransactionHistoryApi();
    notifyListeners();
  }

  Future<void> getTransactionHistoryApi() async {
    CommonUtils.showProgressDialog();
    TransactionHistoryMaster? master =
        await services.api!.getTransactionHistoryApi();
    CommonUtils.hideProgressDialog();
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
      transactionHistoryTotal = master.data?.total ?? [];
      transactionHistoryList = master.data?.list ?? [];
    }
    notifyListeners();
  }
}
