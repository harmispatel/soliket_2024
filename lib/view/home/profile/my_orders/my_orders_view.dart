import 'package:flutter/material.dart';
import 'package:solikat_2024/view/home/profile/my_orders/track_order/track_order_view.dart';
import 'package:solikat_2024/widget/primary_button.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E8),
      appBar: CommonAppBar(
        title: "My Orders",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            MyOrderListView(),
          ],
        ),
      ),
    );
  }
}
// * My Orders List View * //

class MyOrderListView extends StatefulWidget {
  const MyOrderListView({super.key});

  @override
  State<MyOrderListView> createState() => _MyOrderListViewState();
}

class _MyOrderListViewState extends State<MyOrderListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16),
          margin: const EdgeInsets.only(bottom: 10),
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
                          Image.network(
                            "https://cdn-icons-png.freepik.com/256/4715/4715245.png?ga=GA1.1.769342102.1727942475&semt=ais_hybrid",
                            height: 40,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Online",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "19 Sep 2024 - 11:46 PM",
                                  style: getAppStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 22,
                            color: CommonColors.primaryColor,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Order No.",
                              style: getAppStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "1-900082",
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
                              "₹${"800.0"}",
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
                              "Order Placed",
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
                        Expanded(
                          child: PrimaryButton(
                            height: 46,
                            label: "Tracking",
                            buttonColor: Colors.transparent,
                            borderColor: CommonColors.primaryColor,
                            labelColor: CommonColors.primaryColor,
                            onPress: () {},
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
                              push(TrackOrderView());
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
    );
  }
}
