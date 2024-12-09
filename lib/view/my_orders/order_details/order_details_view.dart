import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../widget/common_appbar.dart';
import '../../../utils/local_images.dart';
import '../../../widget/primary_button.dart';
import 'order_details_view_model.dart';

class OrderDetailsView extends StatefulWidget {
  final String orderId;

  const OrderDetailsView({super.key, required this.orderId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  late OrderDetailsViewModel mViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getOrdersDetailsApi(orderId: widget.orderId);
    });
  }

  @override
  void dispose() {
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OrderDetailsViewModel>(context);
    return Scaffold(
      appBar: CommonAppBar(
        title: "Order Details",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
        actions: [
          mViewModel.isInitialLoading
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    if (mViewModel.orderDetailsList[0].isCancelOrder == "y") {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        width: kDeviceWidth,
                        buttonsBorderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                        dismissOnTouchOutside: false,
                        dismissOnBackKeyPress: false,
                        headerAnimationLoop: false,
                        animType: AnimType.topSlide,
                        title: 'Cancel Order',
                        desc: 'Are you sure you want to Cancel this order?',
                        buttonsTextStyle: getAppStyle(),
                        descTextStyle: getAppStyle(fontSize: 15),
                        titleTextStyle: getAppStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                        showCloseIcon: false,
                        btnOk: PrimaryButton(
                          label: "Yes",
                          buttonColor: CommonColors.primaryColor,
                          labelColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          onPress: () {
                            Navigator.pop(context);
                            mViewModel.cancelOrderApi(orderId: widget.orderId);
                          },
                        ),
                        btnCancel: PrimaryButton(
                          label: "No",
                          buttonColor: CommonColors.mRed,
                          labelColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          onPress: () {
                            Navigator.pop(context);
                          },
                        ),
                      ).show();
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: CommonColors.primaryColor.withOpacity(0.1),
                        border: Border.all(color: CommonColors.primaryColor)),
                    child: Text(
                      mViewModel.orderDetailsList[0].cancelText ?? '',
                      style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: mViewModel.isInitialLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.builder(
                    itemCount: 15,
                    padding: kCommonScreenPadding,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          width: double.infinity,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
              )
            : Column(
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
                            ),
                          ),
                          kCommonSpaceH15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mViewModel.orderDetailsList[0].title ?? '',
                                style: getAppStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: CommonColors.mWhite),
                              ),
                              Text(
                                mViewModel.orderDetailsList[0].subTitle ?? '',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: CommonColors.primaryColor
                                  .withOpacity(0.3 / 2),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.directions_bike_rounded,
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ),
                        kCommonSpaceH15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Driver Details",
                              style: getAppStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CommonColors.blackColor),
                            ),
                            Text(
                              mViewModel.orderDetailsList[0].riderName ?? '',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: CommonColors.primaryColor
                                  .withOpacity(0.3 / 2),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ),
                        kCommonSpaceH15,
                        Expanded(
                          child: Column(
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
                                mViewModel
                                        .orderDetailsList[0].deliveryLocation ??
                                    '',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: getAppStyle(
                                    fontSize: 14, color: CommonColors.black54),
                              ),
                            ],
                          ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: CommonColors.primaryColor
                                  .withOpacity(0.3 / 2),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.card_travel,
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ),
                        kCommonSpaceH15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID",
                              style: getAppStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CommonColors.blackColor),
                            ),
                            Text(
                              mViewModel.orderDetailsList[0].orderNo ?? '',
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
                      color: CommonColors.mGrey300,
                      thickness: 4,
                    ),
                  ),
                  kCommonSpaceV10,
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "${mViewModel.orderItemList.length ?? ''} items in this order",
                      style: getAppStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  kCommonSpaceV10,
                  // ListView.builder(
                  //   padding:
                  //       const EdgeInsets.only(top: 12,right: 15),
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: mViewModel.orderItemList.length,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
                  //           child: Row(
                  //             children: [
                  //               Container(
                  //                 width: 70,
                  //                 height: 50,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                       image: NetworkImage(mViewModel
                  //                               .orderItemList[index].image ??
                  //                           ''),
                  //                       fit: BoxFit.cover),
                  //                 ),
                  //               ),
                  //               kCommonSpaceH10,
                  //               Expanded(
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       mViewModel.orderItemList[index]
                  //                               .productName ??
                  //                           '',
                  //                       overflow: TextOverflow.ellipsis,
                  //                       maxLines: 1,
                  //                       style: getAppStyle(
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 16,
                  //                           color: CommonColors.blackColor),
                  //                     ),
                  //                     Text(
                  //                       "x${mViewModel.orderItemList[index].qty ?? ''}",
                  //                       style: getAppStyle(
                  //                           fontSize: 14,
                  //                           color: CommonColors.black54),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               // const Spacer(),
                  //               kCommonSpaceH10,
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.end,
                  //                 children: [
                  //                   Text(
                  //                     "₹${mViewModel.orderItemList[index].discountedPrice ?? ''}",
                  //                     style: getAppStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                         fontSize: 16,
                  //                         color: CommonColors.blackColor),
                  //                   ),
                  //                   Text(
                  //                     "₹${mViewModel.orderItemList[index].price ?? ''}",
                  //                     style: getAppStyle(
                  //                         decoration:
                  //                             TextDecoration.lineThrough,
                  //                         fontSize: 14,
                  //                         color: CommonColors.black54),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 5, right: 5),
                  //           child: Divider(
                  //             color: CommonColors.mGrey500,
                  //             thickness: 1,
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 0, right: 15),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: mViewModel.orderItemList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      bool isLastItem =
                          index == mViewModel.orderItemList.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mViewModel
                                              .orderItemList[index].image ??
                                          ''),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                kCommonSpaceH10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mViewModel.orderItemList[index]
                                                .productName ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: getAppStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: CommonColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        "x${mViewModel.orderItemList[index].qty ?? ''}",
                                        style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                kCommonSpaceH10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₹${mViewModel.orderItemList[index].discountedPrice ?? ''}",
                                      style: getAppStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: CommonColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${mViewModel.orderItemList[index].price ?? ''}",
                                      style: getAppStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: CommonColors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Add divider only if it's not the last item
                          if (!isLastItem)
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Divider(
                                color: CommonColors.mGrey500,
                                thickness: 1,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  kCommonSpaceV5,
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Divider(
                      color: CommonColors.mGrey300,
                      thickness: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(
                      "Bill Details",
                      style: getAppStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 8, left: 15, right: 15),
                    child: Row(
                      children: [
                        Text(
                          "Item Total",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₹${mViewModel.billDetailsList[0].itemTotal}",
                          style: getAppStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 15, right: 15),
                    child: Row(
                      children: [
                        Text(
                          "Delivery Charge",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        // Text(
                        //   "₹${"9"}",
                        //   style: getAppStyle(
                        //     color: Colors.grey,
                        //     decoration: TextDecoration.lineThrough,
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 13,
                        //   ),
                        // ),
                        kCommonSpaceH10,
                        Text(
                          "+ ₹${mViewModel.billDetailsList[0].deliveryCharge}",
                          style: getAppStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textDecorationColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, right: 15, left: 15),
                    child: Row(
                      children: [
                        Text(
                          "Tax",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        // Text(
                        //   "₹${"9"}",
                        //   style: getAppStyle(
                        //     color: Colors.grey,
                        //     decoration: TextDecoration.lineThrough,
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 13,
                        //   ),
                        // ),
                        kCommonSpaceH10,
                        Text(
                          "+ ₹${mViewModel.billDetailsList[0].tax}",
                          style: getAppStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textDecorationColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
                    child: Row(
                      children: [
                        Text(
                          "Offer Discount",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        // Text(
                        //   "₹${"9"}",
                        //   style: getAppStyle(
                        //     color: Colors.grey,
                        //     decoration: TextDecoration.lineThrough,
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 13,
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Text(
                          "- ₹${mViewModel.billDetailsList[0].offerDiscount}",
                          style: getAppStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paid",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "₹${mViewModel.billDetailsList[0].toPaid}",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kCommonSpaceV10,
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.green.withOpacity(0.3),
                        image: DecorationImage(
                            image: AssetImage(LocalImages.img_total_saving_bg),
                            fit: BoxFit.fill),
                      ),
                      child: Center(
                        child: RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          maxLines: 1,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Saving ',
                                style: getAppStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "₹${mViewModel.billDetailsList[0].savingAmount}",
                                style: getAppStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                              TextSpan(
                                text: " on this order.",
                                style: getAppStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.star_rate_outlined,
                                  size: 17,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  kCommonSpaceV20,
                ],
              ),
      ),
    );
  }
}
