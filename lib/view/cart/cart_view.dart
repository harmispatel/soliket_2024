import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/cart/cart_view_model.dart';
import 'package:solikat_2024/view/cart/coupon/coupon_view_model.dart';
import 'package:solikat_2024/view/home/home_view_model.dart';

import '../../models/product_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/global_variables.dart';
import '../../utils/local_images.dart';
import '../../widget/common_appbar.dart';
import '../../widget/primary_button.dart';
import '../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../home/search/search_view_model.dart';
import '../home/sub_brand/sub_brand_view_model.dart';
import '../home/sub_category/sub_category_view_model.dart';
import '../home/sub_offer/sub_offer_view_model.dart';
import '../home/view_all_products/view_all_products_view_model.dart';
import 'checkout/check_out_view.dart';
import 'coupon/coupon_view.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  late CartViewModel mViewModel;
  late HomeViewModel mHomeViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CartViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: mViewModel.cartList.isEmpty ? Color(0xFFFFF4E8) : null,
      appBar: const CommonAppBar(
        title: "My Cart",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: mViewModel.isInitialLoading
          ? Center(
              child: CircularProgressIndicator(
                color: CommonColors.primaryColor,
              ),
            )
          : mViewModel.cartList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15) +
                      const EdgeInsets.only(top: 150, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 240,
                        LocalImages.img_cart_empty,
                      ),
                      kCommonSpaceV10,
                      Text(
                        "Your cart is empty",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        height: 55,
                        label: "CONTINUE SHOPPING",
                        buttonColor: CommonColors.primaryColor,
                        labelColor: CommonColors.mWhite,
                        onPress: () {
                          mainNavKey.currentContext!
                              .read<BottomNavbarViewModel>()
                              .onMenuTapped(0);
                        },
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: kCommonScreenPadding,
                  child: Column(
                    children: [
                      mViewModel.isInitialLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 13,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV15,
                                    Row(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: Colors.white,
                                          ),
                                        ),
                                        kCommonSpaceH15,
                                        Expanded(
                                          child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : MyCartList(
                              cartList: mViewModel.cartList,
                              onAddItem: (variantId) async {
                                await mHomeViewModel
                                    .addToCartApi(
                                        variantId: variantId.toString(),
                                        type: 'p')
                                    .whenComplete(() async {
                                  await mViewModel.getCartApi();
                                  if (mViewModel.couponDiscount == "0" &&
                                      mViewModel.appliedCouponList.isNotEmpty) {
                                    setState(() {
                                      mViewModel.appliedCouponList.clear();
                                    });
                                  }
                                });
                              },
                              onRemoveItem: (variantId) async {
                                await mHomeViewModel
                                    .addToCartApi(
                                        variantId: variantId.toString(),
                                        type: 'm')
                                    .whenComplete(() async {
                                  await mViewModel.getCartApi();
                                  if (mViewModel.couponDiscount == "0" &&
                                      mViewModel.appliedCouponList.isNotEmpty) {
                                    setState(() {
                                      mViewModel.appliedCouponList.clear();
                                    });
                                  }
                                });
                              },
                            ),
                      if (mViewModel.dealProductList.isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CommonColors.primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 5.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Image.asset(
                                        LocalImages.img_tag,
                                        height: 26,
                                        color: CommonColors.mWhite,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Center(
                                    child: Text(
                                      "Soliket Special Price Deals",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kCommonSpaceV20,
                              SizedBox(
                                height: kDeviceHeight / 3,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mViewModel.dealProductList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return FittedBox(
                                      child: Container(
                                        width: 170,
                                        clipBehavior: Clip.antiAlias,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              CommonColors.primaryColor
                                                  .withOpacity(0.1),
                                              CommonColors.mWhite
                                                  .withOpacity(0.2),
                                              CommonColors.mWhite,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Center(
                                                  child: Image.network(
                                                    mViewModel
                                                            .dealProductList[
                                                                index]
                                                            .image ??
                                                        '',
                                                    fit: BoxFit.contain,
                                                    height: 150,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: SizedBox(
                                                  height: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8) +
                                                        EdgeInsets.only(
                                                            right: 3),
                                                    child: Text(
                                                      mViewModel
                                                              .dealProductList[
                                                                  index]
                                                              .productName ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: getAppStyle(
                                                          fontSize: 14,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  mViewModel
                                                          .dealProductList[
                                                              index]
                                                          .variantName ??
                                                      '',
                                                  style: getAppStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              FittedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "₹${mViewModel.dealProductList[index].discountPrice ?? ''}",
                                                            style: getAppStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black87
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            "₹${mViewModel.dealProductList[index].productPrice ?? ''}",
                                                            style: getAppStyle(
                                                              color: Colors
                                                                  .grey[400],
                                                              fontSize: 11,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      kCommonSpaceH20,
                                                      kCommonSpaceH5,
                                                      kCommonSpaceH2,
                                                      mViewModel
                                                                  .dealProductList[
                                                                      index]
                                                                  .isAdd ==
                                                              'y'
                                                          ? InkWell(
                                                              onTap: () async {
                                                                await mHomeViewModel
                                                                    .addToCartApi(
                                                                        variantId: mViewModel
                                                                            .dealProductList[
                                                                                index]
                                                                            .variantId
                                                                            .toString(),
                                                                        type:
                                                                            'p')
                                                                    .whenComplete(
                                                                        () async {
                                                                  await mViewModel
                                                                      .getCartApi();
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 100,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border.all(
                                                                      color: CommonColors
                                                                          .primaryColor,
                                                                      width: 1),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Add",
                                                                    style:
                                                                        getAppStyle(
                                                                      color: CommonColors
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              width: 100,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border: Border.all(
                                                                    color: CommonColors
                                                                        .primaryColor,
                                                                    width: 1),
                                                              ),
                                                              child: Icon(
                                                                Icons.lock,
                                                                color: CommonColors
                                                                    .primaryColor,
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                                width: double.infinity,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: CommonColors
                                                        .primaryColor),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  mViewModel
                                                          .dealProductList[
                                                              index]
                                                          .dealText ??
                                                      '',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: getAppStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      height: 1.1,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        kCommonSpaceV15,
                      ],
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                push(CouponsOffersView()).then((_) {
                                  mViewModel.getCartApi();
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    LocalImages.img_coupon_offer,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Coupons & Offers",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: getAppStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "Explore offers & save more",
                                          style: getAppStyle(
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
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              itemCount: mViewModel.appliedCouponList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 16),
                                  margin: const EdgeInsets.only(top: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mViewModel
                                                      .appliedCouponList[index]
                                                      .message ??
                                                  '',
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: getAppStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            RichText(
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.end,
                                              textDirection: TextDirection.rtl,
                                              softWrap: true,
                                              maxLines: 1,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Code ',
                                                    style: getAppStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: mViewModel
                                                            .appliedCouponList[
                                                                index]
                                                            .couponCode ??
                                                        '',
                                                    style: getAppStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          CouponViewModel()
                                              .removeCouponApi(
                                                  couponId: mViewModel
                                                      .appliedCouponList[index]
                                                      .couponId
                                                      .toString())
                                              .whenComplete(() {
                                            mViewModel.getCartApi();
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 16,
                                              right: 6,
                                              top: 6,
                                              bottom: 6),
                                          height: 36,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(08),
                                              color: Colors.red),
                                          child: Center(
                                            child: Text(
                                              "Remove",
                                              style: getAppStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      kCommonSpaceV15,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 0.8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill Details",
                              style: getAppStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 8),
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
                                  Spacer(),
                                  Text(
                                    "₹${mViewModel.discountAmount}",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "₹${mViewModel.itemTotal}",
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
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Delivery Charge ${mViewModel.isFreeDelivery == "y" ? "(Free Delivery)" : ""}",
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
                                  SizedBox(width: 10),
                                  Text(
                                    "+ ₹${mViewModel.deliveryCharge}",
                                    style: getAppStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          mViewModel.isFreeDelivery == "y"
                                              ? TextDecoration.lineThrough
                                              : null,
                                      fontSize: 16,
                                      textDecorationColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 8),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Tax",
                            //         style: getAppStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //       Spacer(),
                            //       // Text(
                            //       //   "₹${"9"}",
                            //       //   style: getAppStyle(
                            //       //     color: Colors.grey,
                            //       //     decoration: TextDecoration.lineThrough,
                            //       //     fontWeight: FontWeight.w600,
                            //       //     fontSize: 13,
                            //       //   ),
                            //       // ),
                            //       SizedBox(width: 10),
                            //       Text(
                            //         "+ ₹${mViewModel.tax}",
                            //         style: getAppStyle(
                            //           color: Colors.green,
                            //           fontWeight: FontWeight.bold,
                            //           // decoration:
                            //           //     mViewModel.isFreeDelivery == "y"
                            //           //         ? TextDecoration.lineThrough
                            //           //         : null,
                            //           fontSize: 16,
                            //           textDecorationColor: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Coupon Discount",
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
                                    "- ₹${mViewModel.couponDiscount}",
                                    style: getAppStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "To Pay",
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "₹${mViewModel.total}",
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            kCommonSpaceV10,
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.green.withOpacity(0.3),
                                image: DecorationImage(
                                    image: AssetImage(
                                        LocalImages.img_total_saving_bg),
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
                                        text: "₹${mViewModel.savingAmount}",
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
                          ],
                        ),
                      ),
                      kCommonSpaceV20
                    ],
                  ),
                ),
      bottomNavigationBar: mViewModel.cartList.isEmpty
          ? null
          : GestureDetector(
              onTap: () {
                debugPrint("OnTap Schedule Delivery");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: getAppStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "₹${mViewModel.total}",
                              style: getAppStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        kCommonSpaceH20,
                        Expanded(
                          child: PrimaryButton(
                            height: 50,
                            lblSize: 18,
                            label: "Proceed to Checkout",
                            borderRadius: BorderRadius.circular(10),
                            onPress: () {
                              push(CheckOutView());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// * My Cart List View * //

class MyCartList extends StatefulWidget {
  final List<ProductData> cartList;
  final Function onAddItem;
  final Function onRemoveItem;

  const MyCartList({
    super.key,
    required this.cartList,
    required this.onAddItem,
    required this.onRemoveItem,
  });

  @override
  State<MyCartList> createState() => _MyCartListState();
}

class _MyCartListState extends State<MyCartList> {
  late CartViewModel mViewModel;
  late HomeViewModel mHomeViewModel;
  late SubCategoryViewModel mSubCategoryViewModel;
  late SubOfferViewModel mOfferViewModel;
  late SubBrandViewModel mBrandViewModel;
  late SearchViewModel mSearchViewModel;
  late ViewAllProductsViewModel mAllProductViewModel;

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mHomeViewModel.attachedContext(context);
      mSubCategoryViewModel.attachedContext(context);
      mOfferViewModel.attachedContext(context);
      mBrandViewModel.attachedContext(context);
      mSearchViewModel.attachedContext(context);
      mAllProductViewModel.attachedContext(context);
    });
  }

  void incrementItem(int index) {
    var cartItem = widget.cartList[index];
    if (cartItem.cartCount != null &&
        cartItem.cartCount! < (cartItem.stock ?? 0)) {
      setState(() {
        cartItem.cartCount = (cartItem.cartCount ?? 0) + 1;
      });
      // mViewModel.updateCartCount(cartItem.variantId ?? 0, cartItem.cartCount!);
      widget.onAddItem(cartItem.variantId);

      for (var item in mHomeViewModel.section4DataList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }

      for (var item in mHomeViewModel.section9DataList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = item.cartCount + 1;
          break;
        }
      }

      for (var item in mSubCategoryViewModel.categoryProductList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }

      for (var item in mBrandViewModel.brandProductList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }

      for (var item in mOfferViewModel.offerProductList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }

      for (var item in mSearchViewModel.productList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }

      for (var item in mAllProductViewModel.viewAllProductList) {
        if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
            item.variantId.toString().trim()) {
          item.cartCount = (item.cartCount ?? 0) + 1;
          break;
        }
      }
    } else {
      debugPrint(
          ".......Sorry this product has only ${cartItem.stock ?? 0} in stock......");
      String msg = "Only ${cartItem.stock ?? 0} product available in stock";
      CommonUtils.showCustomToast(context, msg);
    }
  }

  void decrementItem(int index) {
    var cartItem = widget.cartList[index];
    if (cartItem.cartCount != null && cartItem.cartCount! > 0) {
      setState(() {
        cartItem.cartCount = (cartItem.cartCount ?? 0) - 1;
      });

      if (cartItem.cartCount == 0) {
        widget.onRemoveItem(cartItem.variantId);

        for (var item in mHomeViewModel.section4DataList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mHomeViewModel.section9DataList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = item.cartCount - 1;
            break;
          }
        }

        for (var item in mSubCategoryViewModel.categoryProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mBrandViewModel.brandProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mOfferViewModel.offerProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mSearchViewModel.productList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mAllProductViewModel.viewAllProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }
        setState(() {
          widget.cartList.removeAt(index);
        });
      } else {
        widget.onRemoveItem(cartItem.variantId);

        for (var item in mHomeViewModel.section4DataList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mHomeViewModel.section9DataList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = item.cartCount - 1;
            break;
          }
        }

        for (var item in mSubCategoryViewModel.categoryProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mBrandViewModel.brandProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mOfferViewModel.offerProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mSearchViewModel.productList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }

        for (var item in mAllProductViewModel.viewAllProductList) {
          if (mHomeViewModel.cartDataList[index].variantId?.toString().trim() ==
              item.variantId.toString().trim()) {
            item.cartCount = (item.cartCount ?? 0) - 1;
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CartViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);
    mSubCategoryViewModel = Provider.of<SubCategoryViewModel>(context);
    mOfferViewModel = Provider.of<SubOfferViewModel>(context);
    mBrandViewModel = Provider.of<SubBrandViewModel>(context);
    mSearchViewModel = Provider.of<SearchViewModel>(context);
    mAllProductViewModel = Provider.of<ViewAllProductsViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Items (${widget.cartList.length.toString()})",
          style: getAppStyle(
            color: Colors.grey.withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 12, bottom: 6),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.cartList.length,
          itemBuilder: (BuildContext context, int index) {
            var cartListDate = widget.cartList[index];
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      height: 60,
                      width: 70,
                      imageUrl: cartListDate.image ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    kCommonSpaceH5,
                    kCommonSpaceH2,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            cartListDate.productName ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 02),
                                  child: Text(
                                    cartListDate.variantName ?? "",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                kCommonSpaceH10,
                                if (cartListDate.isDeal == "y")
                                  Text(
                                    "🎉 Deal Applied",
                                    style: getAppStyle(
                                        height: 1,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: CommonColors.primaryColor),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    kCommonSpaceH15,
                    kCommonSpaceH3,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        cartListDate.isDeal == "n"
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                margin: const EdgeInsets.only(bottom: 4),
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () => decrementItem(index),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      cartListDate.cartCount.toString(),
                                      //itemCount.toString(),
                                      style: getAppStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => incrementItem(index),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await mHomeViewModel
                                      .addToCartApi(
                                          variantId:
                                              cartListDate.variantId.toString(),
                                          type: 'm')
                                      .whenComplete(() async {
                                    await mViewModel.getCartApi();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  margin: const EdgeInsets.only(bottom: 4),
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: CommonColors.primaryColor
                                        .withOpacity(0.4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Remove",
                                      style: getAppStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          children: [
                            Text(
                              "₹${cartListDate.productPrice ?? ""}",
                              style: getAppStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            kCommonSpaceH5,
                            Text(
                              "₹${cartListDate.discountPrice ?? ""}",
                              style: getAppStyle(
                                color: CommonColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ],
            );
          },
        ),
      ],
    );
  }
}
