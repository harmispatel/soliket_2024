import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/home/view_all_products/view_all_products_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/common_appbar.dart';
import '../../common_view/common_img_slider/common_img_slider_view.dart';
import '../home_view_model.dart';

class ViewAllProductsView extends StatefulWidget {
  final int id;

  const ViewAllProductsView({super.key, required this.id});

  @override
  State<ViewAllProductsView> createState() => _ViewAllProductsViewState();
}

class _ViewAllProductsViewState extends State<ViewAllProductsView> {
  late ViewAllProductsViewModel mViewModel;
  late HomeViewModel mHomeViewModel;
  int itemCount = 0;
  bool isBottomSheetOpen = false;
  bool isExpanded = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mHomeViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      mViewModel.getViewAllProductApi(
          latitude: gUserLat,
          longitude: gUserLong,
          // offerId: widget.id.toString()
          productId: "2,1,5,89,65");
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.resetPage();
    super.dispose();
  }

  void _scrollListener() {
    final mViewModel = context.read<ViewAllProductsViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getViewAllProductApi(
          latitude: gUserLat,
          longitude: gUserLong,
          // offerId: widget.id.toString()
          productId: "2,1,5,89,65");
    }
  }

  void incrementItem() {
    setState(() {
      itemCount++;
    });
    // widget.onIncrement!();
  }

  void decrementItem() {
    if (itemCount > 0) {
      setState(() {
        itemCount--;
      });
      // widget.onDecrement!();
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ViewAllProductsViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Products",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 20),
            child: GestureDetector(
              onTap: () {
                debugPrint("On Tap Search");
              },
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: mViewModel.isInitialLoading
          ? Expanded(
              child: Shimmer.fromColors(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          kCommonSpaceH15,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      kCommonSpaceV15,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          kCommonSpaceH15,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      kCommonSpaceV15,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          kCommonSpaceH15,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV10,
                                Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Container(
                                  height: 14.0,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                                kCommonSpaceV15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.0,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          Container(
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kCommonSpaceH5,
                                    kCommonSpaceH3,
                                    Expanded(
                                      child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 2,
                mainAxisSpacing: 5,
              ),
              itemCount: mViewModel.viewAllProductList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () async {
                      var variantId = mViewModel
                          .viewAllProductList[index].variantId;
                      if (!isBottomSheetOpen) {
                        isBottomSheetOpen = true;
                        await mHomeViewModel.getProductDetailsApi(
                          variantId: variantId?.toString() ?? '',
                        );
                        if (mHomeViewModel.productDetailsData !=
                            null) {
                          productDetailsBottomSheet(variantId!);
                        }
                      }
                    },
                    child: Container(
                      width: 170,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    if (mViewModel
                                            .viewAllProductList[index].stock !=
                                        0)
                                      Center(
                                        child: Image.network(
                                          mViewModel.viewAllProductList[index]
                                                  .image ??
                                              '',
                                          fit: BoxFit.contain,
                                          height: 170,
                                        ),
                                      ),
                                    if (mViewModel
                                            .viewAllProductList[index].stock ==
                                        0)
                                      Center(
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            Colors.white.withOpacity(0.5),
                                            BlendMode
                                                .srcOver, // Blend mode for overlay
                                          ),
                                          child: Image.network(
                                            mViewModel.viewAllProductList[index]
                                                    .image ??
                                                '',
                                            fit: BoxFit.contain,
                                            height: 170,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      mViewModel.viewAllProductList[index]
                                              .productName ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: mViewModel
                                                      .viewAllProductList[index]
                                                      .stock ==
                                                  0
                                              ? Colors.grey[400]
                                              : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    mViewModel.viewAllProductList[index]
                                            .variantName ??
                                        '',
                                    style: getAppStyle(
                                      fontSize: 14,
                                      color: mViewModel.viewAllProductList[index]
                                                  .stock ==
                                              0
                                          ? Colors.grey[400]
                                          : Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mViewModel.viewAllProductList[index]
                                                .discountPrice
                                                .toString(),
                                            style: getAppStyle(
                                              fontSize: 14,
                                              color: mViewModel
                                                          .viewAllProductList[
                                                              index]
                                                          .stock ==
                                                      0
                                                  ? Colors.grey[400]
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            mViewModel.viewAllProductList[index]
                                                .productPrice
                                                .toString(),
                                            style: getAppStyle(
                                              color: mViewModel
                                                          .viewAllProductList[
                                                              index]
                                                          .stock ==
                                                      0
                                                  ? Colors.grey[400]
                                                  : Colors.black54,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (mViewModel
                                              .viewAllProductList[index].stock !=
                                          0) ...[
                                        itemCount > 0
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 4),
                                                margin: const EdgeInsets.only(
                                                    bottom: 4),
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      CommonColors.primaryColor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: decrementItem,
                                                      child: const Icon(
                                                        Icons.remove,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      itemCount.toString(),
                                                      style: getAppStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: incrementItem,
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : InkWell(
                                                onTap: incrementItem,
                                                child: Container(
                                                  width: 100,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    border: Border.all(
                                                        color: CommonColors
                                                            .primaryColor,
                                                        width: 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Add",
                                                      style: getAppStyle(
                                                        color: CommonColors
                                                            .primaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (mViewModel.viewAllProductList[index].discountPer !=
                                  0 &&
                              mViewModel.viewAllProductList[index].stock != 0)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Text(
                                    "${mViewModel.viewAllProductList[index].discountPer}% off",
                                    style: getAppStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (mViewModel.viewAllProductList[index].stock == 0)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      CommonColors.primaryColor.withOpacity(0.2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: const Offset(
                                        2.0,
                                        4.0,
                                      ),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 3),
                                  child: Text(
                                    "Sorry, this item is sold out",
                                    textAlign: TextAlign.center,
                                    style: getAppStyle(
                                        color: CommonColors.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        height: 1.2),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
  void productDetailsBottomSheet(int variantId) {
    isBottomSheetOpen = false;
    mHomeViewModel.getProductDetailsApi(variantId: variantId.toString());
    showModalBottomSheet(
      context: mainNavKey.currentContext!,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return IntrinsicHeight(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  isBottomSheetOpen = false;
                                },
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.pop(context);
                            //     },
                            //     child: Container(
                            //       height: 28,
                            //       width: 28,
                            //       margin: const EdgeInsets.only(top: 10),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(30),
                            //         color: Colors.white,
                            //         boxShadow: const [
                            //           BoxShadow(
                            //             color: Colors.grey,
                            //             blurRadius: 1,
                            //             //spreadRadius: 0.001,
                            //           ),
                            //         ],
                            //       ),
                            //       child: Center(
                            //         child: Image.asset(
                            //           LocalImages.img_whatsapp,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            CommonImgSliderView(
                              imgUrls: mHomeViewModel
                                  .productDetailsData![0].image!
                                  .map((imageData) => imageData.image ?? "")
                                  .toList(),
                            ),
                            Container(
                              height: 20,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                              margin: const EdgeInsets.only(
                                  right: 16, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.orangeAccent.withOpacity(0.2)),
                              child: RichText(
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                                //textDirection: TextDirection.rtl,
                                softWrap: true,
                                maxLines: 1,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Delivery in ',
                                      style: getAppStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "11 Min",
                                      style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child: Icon(
                                        Icons.electric_bolt_rounded,
                                        size: 16,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              mHomeViewModel.productDetailsData?.isNotEmpty ==
                                  true
                                  ? mHomeViewModel
                                  .productDetailsData![0].productName ??
                                  "No product name available"
                                  : "No product details available",
                              style: getAppStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              mHomeViewModel.productDetailsData?.isNotEmpty ==
                                  true
                                  ? mHomeViewModel
                                  .productDetailsData![0].variantName ??
                                  "No product Unit available"
                                  : "No product details available",
                              style: getAppStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "₹${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].discountPrice.toString() : "No product details available"}",
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "₹${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].productPrice.toString() : "No product details available"}",
                                  style: getAppStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                mHomeViewModel
                                    .productDetailsData![0].discountPer
                                    .toString() ==
                                    "0"
                                    ? const SizedBox.shrink()
                                    : Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Text(
                                    "${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].discountPer.toString() : "No product details available"}% off",
                                    style: getAppStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "More Details",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.blueAccent),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.blueAccent,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isExpanded) ...[
                                  // Text(
                                  //   "Packaging Type",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "Blister",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Shelf Life",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "3 years",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Unit",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   mViewModel.productDetailsData?.isNotEmpty ==
                                  //           true
                                  //       ? mViewModel.productDetailsData![0]
                                  //               .variantName ??
                                  //           "No product Unit available"
                                  //       : "No product details available",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Marketed By",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "Procter & Gamble",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Country of Origin",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "India",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  Text(
                                    "Description",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  HtmlWidget(
                                    mHomeViewModel.productDetailsData![0]
                                        .description ??
                                        "",
                                    textStyle: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Customer Care Details",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "support@log2retail.in",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Return Policy",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 6),
                                  // Text(
                                  //   "Type",
                                  //   style: getAppStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "Call",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ]
                              ],
                            ),
                            isExpanded == true
                                ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Less Details",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.blueAccent),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.blueAccent,
                                  )
                                ],
                              ),
                            )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Divider(),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: IntrinsicWidth(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mHomeViewModel.productDetailsData
                                        ?.isNotEmpty ==
                                        true
                                        ? mHomeViewModel.productDetailsData![0]
                                        .variantName ??
                                        "No product Unit available"
                                        : "No product details available",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].discountPrice.toString() : "No product details available"}",
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "₹${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].productPrice.toString() : "No product details available"}",
                                        style: getAppStyle(
                                          decoration:
                                          TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      mHomeViewModel.productDetailsData![0]
                                          .discountPer
                                          .toString() ==
                                          "0"
                                          ? const SizedBox(width: 50)
                                          : Container(
                                        margin: const EdgeInsets.only(
                                            left: 8),
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2),
                                        ),
                                        child: Text(
                                          "${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].discountPer.toString() : "No product details available"}% off",
                                          style: getAppStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 70),
                              const Spacer(),
                              if (mHomeViewModel.productDetailsData![0].stock !=
                                  0) ...[
                                mHomeViewModel
                                    .productDetailsData![0].cartCount! >
                                    0
                                    ? Container(
                                  height: 55,
                                  width: 240,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: CommonColors.primaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (mHomeViewModel
                                              .productDetailsData![0]
                                              .cartCount! >
                                              0) {
                                            await mHomeViewModel
                                                .addToCartApi(
                                              variantId: mHomeViewModel
                                                  .productDetailsData![0]
                                                  .variantId
                                                  .toString(),
                                              type: 'm',
                                            );
                                            setState(() {
                                              mHomeViewModel
                                                  .productDetailsData![0]
                                                  .cartCount = mHomeViewModel
                                                  .productDetailsData![
                                              0]
                                                  .cartCount! -
                                                  1;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        mHomeViewModel
                                            .productDetailsData![0]
                                            .cartCount
                                            .toString(),
                                        style: getAppStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // Ensure productDetailsData is non-null and has at least one item
                                          if (mHomeViewModel
                                              .productDetailsData !=
                                              null &&
                                              mHomeViewModel
                                                  .productDetailsData!
                                                  .isNotEmpty) {
                                            int stock = mHomeViewModel
                                                .productDetailsData![
                                            0]
                                                .stock ??
                                                0; // Provide a default value (e.g., 0)

                                            if (mHomeViewModel
                                                .productDetailsData![
                                            0]
                                                .cartCount! <
                                                stock) {
                                              await mHomeViewModel
                                                  .addToCartApi(
                                                variantId: mHomeViewModel
                                                    .productDetailsData![
                                                0]
                                                    .variantId
                                                    .toString(),
                                                type: 'p',
                                              );
                                              setState(() {
                                                mHomeViewModel
                                                    .productDetailsData![
                                                0]
                                                    .cartCount = mHomeViewModel
                                                    .productDetailsData![
                                                0]
                                                    .cartCount! +
                                                    1;
                                              });
                                            } else {
                                              String msg =
                                                  "Only $stock product(s) available in stock";
                                              CommonUtils.showSnackBar(
                                                  msg,
                                                  color:
                                                  CommonColors.mRed);
                                            }
                                          }
                                        },
                                        // onTap: () async {
                                        //   await mViewModel.addToCartApi(
                                        //     variantId: mViewModel
                                        //         .productDetailsData![0]
                                        //         .variantId
                                        //         .toString(),
                                        //     type: 'p',
                                        //   );
                                        //   setState(() {
                                        //     mViewModel
                                        //         .productDetailsData![0]
                                        //         .cartCount = mViewModel
                                        //             .productDetailsData![
                                        //                 0]
                                        //             .cartCount! +
                                        //         1;
                                        //   });
                                        // },
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
                                    await mHomeViewModel.addToCartApi(
                                      variantId: mHomeViewModel
                                          .productDetailsData![0]
                                          .variantId
                                          .toString(),
                                      type: 'p',
                                    );
                                    setState(() {
                                      mHomeViewModel
                                          .productDetailsData![0]
                                          .cartCount = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 240,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: CommonColors.primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add to Cart",
                                        style: getAppStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
