import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../widget/common_appbar.dart';

class TrackOrderView extends StatefulWidget {
  const TrackOrderView({super.key});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Track order",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: kDeviceWidth,
              color: CommonColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white30, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.access_time,
                            color: CommonColors.mWhite,
                          ),
                        )),
                    kCommonSpaceH15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Schedule For",
                          style: getAppStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: CommonColors.mWhite),
                        ),
                        Text(
                          "Fri, 20 Sep, 8:00 AM - 10:00 AM",
                          style: getAppStyle(
                              fontSize: 16, color: CommonColors.mWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.directions_bike_rounded,
                      ),
                    ),
                  ),
                  kCommonSpaceH15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rider",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "Not Assigned",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 1,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                      ),
                    ),
                  ),
                  kCommonSpaceH15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Location",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "A-25 Number",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 1,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.card_travel,
                      ),
                    ),
                  ),
                  kCommonSpaceH15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID 1-8965264",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "Placed on 19 sep 2024 - 11:46 PM",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 4,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "4 items in this order",
                style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.jdmagicbox.com/quickquotes/images_main/patato-vegetable-2216996689-nvibzgar.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  kCommonSpaceH10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fresh Potato Aloo 2Kg",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "x1",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 1,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.jdmagicbox.com/quickquotes/images_main/patato-vegetable-2216996689-nvibzgar.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  kCommonSpaceH10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fresh Potato Aloo 2Kg",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "x1",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 1,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.jdmagicbox.com/quickquotes/images_main/patato-vegetable-2216996689-nvibzgar.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  kCommonSpaceH10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fresh Potato Aloo 2Kg",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "x1",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.jdmagicbox.com/quickquotes/images_main/patato-vegetable-2216996689-nvibzgar.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  kCommonSpaceH10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fresh Potato Aloo 2Kg",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "x1",
                        style: getAppStyle(
                            fontSize: 14, color: CommonColors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CommonColors.blackColor),
                      ),
                      Text(
                        "₹ 280",
                        style: getAppStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            color: CommonColors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: CommonColors.mGrey500,
                thickness: 4,
              ),
            ),
            kCommonSpaceV10,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Bill Details",
                style: getAppStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: CommonColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 14),
              child: Row(
                children: [
                  Text(
                    "Item Total",
                    style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: CommonColors.blackColor),
                  ),
                  const Spacer(),
                  Text(
                    "₹ 1543",
                    style: getAppStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.black54),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "₹ 1444",
                    style: getAppStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CommonColors.blackColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 14),
              child: Row(
                children: [
                  Text(
                    "Total Paid",
                    style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: CommonColors.blackColor),
                  ),
                  const Spacer(),
                  Text(
                    "₹ 1444",
                    style: getAppStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CommonColors.blackColor),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_border_outlined, color: Colors.green),
                    Text(
                      "Saving ",
                      style: getAppStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    Text(
                      "₹99",
                      style: getAppStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    Text(
                      " on this order",
                      style: getAppStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
