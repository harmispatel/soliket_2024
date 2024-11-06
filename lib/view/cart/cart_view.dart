import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/cart/cart_view_model.dart';
import 'package:solikat_2024/view/home/home_view_model.dart';

import '../../models/cart_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../widget/common_appbar.dart';
import '../../widget/primary_button.dart';
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
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "My Cart",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: mViewModel.isInitialLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: CommonColors.primaryColor,
              ),
            )
          : mViewModel.cartList.isEmpty
              ? Center(
                  child: Text(
                    "Cart Data Empty",
                    style: getAppStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
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
                                await mHomeViewModel.addToCartApi(
                                    variantId: variantId.toString(), type: 'p');
                              },
                              onRemoveItem: (variantId) async {
                                await mHomeViewModel.addToCartApi(
                                    variantId: variantId.toString(), type: 'm');
                              },
                            ),
                      SizedBox(height: 14),
                      ApplyCouponView(),
                      SizedBox(height: 10),
                      BillDetailsView(),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
      bottomNavigationBar:
          mViewModel.cartList.isEmpty ? null : const BottomSheetView(),
    );
  }
}

// * My Cart List View * //

class MyCartList extends StatefulWidget {
  final List<CartData> cartList;
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
  void incrementItem(int index) {
    var cartItem = widget.cartList[index];
    if (cartItem.cartCount != null &&
        cartItem.cartCount! < (cartItem.stock ?? 0)) {
      setState(() {
        cartItem.cartCount = (cartItem.cartCount ?? 0) + 1;
      });
      widget.onAddItem(cartItem.variantId);
    } else {
      debugPrint(
          ".......Sorry this product has only ${cartItem.stock ?? 0} in stock......");
      String msg = "Only ${cartItem.stock ?? 0} product available in stock";
      CommonUtils.showSnackBar(msg, color: CommonColors.mRed);
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
        setState(() {
          widget.cartList.removeAt(index);
        });
      } else {
        widget.onRemoveItem(cartItem.variantId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(top: 12),
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
                      height: 80,
                      width: 80,
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
                    kCommonSpaceH15,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 02),
                            child: Text(
                              cartListDate.variantName ?? "",
                              style: getAppStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
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
                        Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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

// * Apply Coupon View * //

class ApplyCouponView extends StatefulWidget {
  const ApplyCouponView({super.key});

  @override
  State<ApplyCouponView> createState() => _ApplyCouponViewState();
}

class _ApplyCouponViewState extends State<ApplyCouponView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
              push(CouponsOffersView());
            },
            child: Row(
              children: [
                Image.network(
                  "https://st2.depositphotos.com/5266903/9158/i/450/depositphotos_91586432-stock-photo-discount-coupons-icon.jpg",
                  height: 40,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            margin: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "On Shopping for ₹399, Get Rs 500 free coupon code",
                        maxLines: 1,
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
                              text: 'Use code ',
                              style: getAppStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "WELCOME50",
                              style: getAppStyle(
                                fontWeight: FontWeight.bold,
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
                    debugPrint("OnTap Apply");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(08),
                      color: CommonColors.primaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: getAppStyle(
                          color: CommonColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * Bill Details View * //

class BillDetailsView extends StatefulWidget {
  const BillDetailsView({super.key});

  @override
  State<BillDetailsView> createState() => _BillDetailsViewState();
}

class _BillDetailsViewState extends State<BillDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
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
            padding: EdgeInsets.only(top: 10, bottom: 14),
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
                  "₹${"1000"}",
                  style: getAppStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "₹${"1000"}",
                  style: getAppStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
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
                "₹${"1000"}",
                style: getAppStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.3),
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
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: "₹${"250.0"}",
                      style: getAppStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: " on this order.",
                      style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.star_rate_outlined,
                        size: 16,
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
    );
  }
}

// * Bottom Sheet View * //

class BottomSheetView extends StatefulWidget {
  const BottomSheetView({super.key});

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("OnTap Schedule Delivery");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/128/561/561226.png",
                  height: 26,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Delivering To",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 18,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Home",
                                  style: getAppStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "raipur, Ravinagar, Station Road, Moudhapara",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                    debugPrint("OnTap Change");
                  },
                  child: Text(
                    "Change",
                    style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: CommonColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                      "₹${"250.0"}",
                      style: getAppStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                kCommonSpaceH15,
                Expanded(
                  child: PrimaryButton(
                    height: 50,
                    lblSize: 18,
                    label: "Schedule Delivery",
                    borderRadius: BorderRadius.circular(15),
                    onPress: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
