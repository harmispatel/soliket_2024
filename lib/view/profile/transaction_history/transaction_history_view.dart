import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/profile/transaction_history/transaction_history_view_model.dart';

import '../../../../utils/common_colors.dart';
import '../../../../widget/common_appbar.dart';

class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  late TransactionHistoryViewModel mViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    final mViewModel = context.read<TransactionHistoryViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getTransactionHistoryApi();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    mViewModel.resetPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<TransactionHistoryViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(
          title: "Transaction History",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: mViewModel.isInitialLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  padding: kCommonScreenPadding,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          kCommonSpaceH15,
                          Expanded(
                            child: Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              height: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : mViewModel.transactionHistoryList.isEmpty
                ? Padding(
                    padding: kCommonScreenPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Orders",
                                      style: getAppStyle(
                                        fontSize: 20,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Text(
                                      "0",
                                      style: getAppStyle(
                                        fontSize: 16,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            kCommonSpaceH15,
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: getAppStyle(
                                        fontSize: 20,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Text(
                                      "₹0.00",
                                      style: getAppStyle(
                                        fontSize: 16,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                height: 180,
                                "https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png"),
                            Text(
                              "No Transaction History Here",
                              textAlign: TextAlign.center,
                              style: getAppStyle(
                                  fontSize: 20,
                                  color: CommonColors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Padding(
                    padding: kCommonScreenPadding,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Orders",
                                      style: getAppStyle(
                                        fontSize: 20,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Text(
                                      mViewModel.transactionHistoryTotal
                                              .isNotEmpty
                                          ? mViewModel.transactionHistoryTotal
                                              .first.totalOrder
                                              .toString()
                                          : "0",
                                      style: getAppStyle(
                                        fontSize: 16,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            kCommonSpaceH15,
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: getAppStyle(
                                        fontSize: 20,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Text(
                                      "₹${mViewModel.transactionHistoryTotal.isNotEmpty ? mViewModel.transactionHistoryTotal.first.totalAmount.toString() : "0.00"}",
                                      style: getAppStyle(
                                        fontSize: 16,
                                        color: CommonColors.mWhite,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        kCommonSpaceV15,
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 5, bottom: 30),
                            itemCount: mViewModel.transactionHistoryList.length,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              var transactionHistoryData =
                                  mViewModel.transactionHistoryList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CommonColors.primaryColor
                                              .withOpacity(0.2),
                                        ),
                                        child: Image.network(
                                          //"https://cdn-icons-png.flaticon.com/128/608/608258.png",
                                          "https://cdn-icons-png.flaticon.com/128/626/626075.png",
                                          color: Colors.green,
                                        ),
                                      ),
                                      kCommonSpaceH10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transactionHistoryData.orderId
                                                .toString(),
                                            style: getAppStyle(
                                              fontSize: 16,
                                              color: CommonColors.blackColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            transactionHistoryData.date
                                                .toString(),
                                            style: getAppStyle(
                                              fontSize: 14,
                                              color: CommonColors.mGrey500,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₹${transactionHistoryData.amount.toString()}",
                                            style: getAppStyle(
                                              fontSize: 14,
                                              color: CommonColors.greenColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            transactionHistoryData.paymentMethod
                                                .toString(),
                                            style: getAppStyle(
                                              fontSize: 12,
                                              color: CommonColors.mGrey500,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Divider(
                                      color: CommonColors.grayShade200,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
