import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/view/my_orders/tracking_orders/tracking_orders_view.dart';

import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../widget/primary_button.dart';
import 'my_order_view_model.dart';
import 'order_details/order_details_view.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView>
    with TickerProviderStateMixin {
  late MyOrderViewModel mViewModel;
  // final ScrollController _scrollController = ScrollController();
  String currentStatus = 'p';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // _scrollController.addListener(_scrollListener);
      mViewModel.getOrdersApi(status: currentStatus);
    });
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    currentStatus = 'p';
    mViewModel.resetPage();
    super.dispose();
  }

  // void _scrollListener() {
  //   final mViewModel = context.read<MyOrderViewModel>();
  //   if (_scrollController.position.pixels ==
  //           _scrollController.position.maxScrollExtent &&
  //       !mViewModel.isPageFinish) {
  //     mViewModel.getOrdersApi(status: currentStatus);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MyOrderViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: CommonAppBar(
          title: "My Orders",
          isTitleBold: true,
          // automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: CommonColors.blackColor),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        currentStatus = 'p';
                      });
                      await mViewModel.resetPage();
                      mViewModel.getOrdersApi(status: currentStatus);
                    },
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            "Pending",
                            style: getAppStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: currentStatus == 'p'
                                  ? CommonColors.primaryColor
                                  : Colors.black,
                            ),
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                                color: currentStatus == 'p'
                                    ? CommonColors.primaryColor
                                    : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        currentStatus = 'c';
                      });
                      await mViewModel.resetPage();

                      mViewModel.getOrdersApi(status: currentStatus);
                    },
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            "Completed",
                            style: getAppStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: currentStatus == 'c'
                                  ? CommonColors.primaryColor
                                  : Colors.black,
                            ),
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: currentStatus == 'c'
                                  ? CommonColors.primaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: mViewModel.isInitialLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: kCommonScreenPadding,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
            )
          : mViewModel.orderList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(height: 270, LocalImages.img_order_not_found),
                      kCommonSpaceV15,
                      Text(
                        "No order Found!",
                        style: getAppStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: CommonColors.blackColor),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  // controller: _scrollController,
                  padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: mViewModel.orderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 16),
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(
                          color: CommonColors.primaryColor.withOpacity(0.4),
                          width: 0.8,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        LocalImages.img_order_basket,
                                        height: 40,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mViewModel.orderList[index]
                                                      .orderNumber ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: getAppStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.orderList[index]
                                                      .created ??
                                                  '',
                                              style: getAppStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          push(
                                            OrderDetailsView(
                                              orderId: mViewModel
                                                  .orderList[index].orderId
                                                  .toString(),
                                            ),
                                          ).then((_) async {
                                            await mViewModel.resetPage();
                                            mViewModel.getOrdersApi(
                                                status: currentStatus);
                                          });
                                        },
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 22,
                                          color: CommonColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Divider(
                                    color: CommonColors.mGrey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Payment Type",
                                          style: getAppStyle(
                                            color: Colors.grey.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          mViewModel.orderList[index]
                                                  .paymentMethod ??
                                              '',
                                          style: getAppStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Total",
                                          style: getAppStyle(
                                            color: Colors.grey.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "₹${mViewModel.orderList[index].total ?? ''}",
                                          style: getAppStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Status",
                                          style: getAppStyle(
                                            color: Colors.grey.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          mViewModel.orderList[index]
                                                  .orderStatus ??
                                              '',
                                          style: getAppStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                kCommonSpaceV20,
                                kCommonSpaceV10,
                                Row(
                                  children: [
                                    mViewModel.orderList[index].orderStatus ==
                                                "Delivered" ||
                                            mViewModel.orderList[index]
                                                    .orderStatus ==
                                                "Cancelled" ||
                                            mViewModel.orderList[index]
                                                    .orderStatus ==
                                                "Returned"
                                        ? Expanded(
                                            child: FittedBox(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    width: 70,
                                                    child: Image.asset(
                                                        LocalImages
                                                            .img_delivered),
                                                  ),
                                                  Text(
                                                    mViewModel.orderList[index]
                                                            .orderStatus ??
                                                        '',
                                                    style: GoogleFonts
                                                        .eduNswActFoundation(
                                                            color: CommonColors
                                                                .primaryColor,
                                                            fontSize: 21,
                                                            height: 1.1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: PrimaryButton(
                                              height: 46,
                                              label: "Tracking",
                                              buttonColor: Colors.transparent,
                                              borderColor:
                                                  CommonColors.primaryColor,
                                              labelColor:
                                                  CommonColors.primaryColor,
                                              onPress: () {
                                                push(
                                                  TrackingOrdersView(
                                                    orderId: mViewModel
                                                        .orderList[index]
                                                        .orderId
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    kCommonSpaceH15,
                                    Expanded(
                                      child: PrimaryButton(
                                        height: 46,
                                        label: "View Details",
                                        buttonColor: CommonColors.primaryColor,
                                        labelColor: CommonColors.mWhite,
                                        onPress: () {
                                          push(
                                            OrderDetailsView(
                                              orderId: mViewModel
                                                  .orderList[index].orderId
                                                  .toString(),
                                            ),
                                          ).then((_) async {
                                            await mViewModel.resetPage();
                                            mViewModel.getOrdersApi(
                                                status: currentStatus);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                kCommonSpaceV15,
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
