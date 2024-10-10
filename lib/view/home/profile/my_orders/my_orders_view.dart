import 'package:flutter/material.dart';

import '../../../../utils/common_colors.dart';
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
      itemCount: 1,
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
              width: 2,
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
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Online",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "19 Sep 2024 - 11:46 PM",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: CommonColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Order No.",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "1-900082",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Order No.",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "₹${"800.0"}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Order No.",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Order Placed",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("OnTap Track Order Button");
                    },
                    child: Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: const BoxDecoration(
                        color: CommonColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Track Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
