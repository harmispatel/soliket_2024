import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/common_view/bottom_navbar/bottom_navbar_view.dart';
import 'package:solikat_2024/view/home/sub_brand/sub_brand_view_model.dart';
import 'package:solikat_2024/view/home/sub_category/sub_category_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/common_appbar.dart';
import '../../../widget/common_product_container_view.dart';
import '../../../widget/primary_button.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../../common_view/common_img_slider/common_img_slider_view.dart';
import '../home_view_model.dart';
import '../search/search_view_model.dart';
import '../sub_offer/sub_offer_view_model.dart';
import '../view_all_products/view_all_products_view_model.dart';

class SubBrandView extends StatefulWidget {
  final int brandId;
  final String title;

  SubBrandView({super.key, required this.brandId, required this.title});

  @override
  State<SubBrandView> createState() => _SubBrandViewState();
}

class _SubBrandViewState extends State<SubBrandView> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  int itemCount = 0;
  late SubBrandViewModel mViewModel;
  late HomeViewModel mHomeViewModel;
  late SubOfferViewModel mOfferViewModel;
  late SubCategoryViewModel mSubCategoryViewModel;
  late SearchViewModel mSearchViewModel;
  late ViewAllProductsViewModel mAllProductViewModel;

  bool isBottomSheetOpen = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mHomeViewModel.attachedContext(context);
      mOfferViewModel.attachedContext(context);
      mSubCategoryViewModel.attachedContext(context);
      mSearchViewModel.attachedContext(context);
      mAllProductViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      mViewModel.getBrandProductApi(
          latitude: gUserLat,
          longitude: gUserLong,
          brandId: widget.brandId.toString());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.resetPage();
    mViewModel.brandCategoryList.clear();
    super.dispose();
  }

  void _scrollListener() {
    final mViewModel = context.read<SubBrandViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getBrandProductApi(
          latitude: gUserLat,
          longitude: gUserLong,
          brandId: widget.brandId.toString());
    }
  }

  Future<void> incrementItem(int index) async {
    if ((mViewModel.brandProductList[index].cartCount ?? 0) <
        (mViewModel.brandProductList[index].stock ?? 0)) {
      setState(() {
        mViewModel.brandProductList[index].cartCount =
            (mViewModel.brandProductList[index].cartCount ?? 0) + 1;
      });
      await mHomeViewModel.addToCartApi(
          variantId: mViewModel.brandProductList[index].variantId.toString(),
          type: 'p');
    } else if (mViewModel.brandProductList[index].stock != 0) {
      print(
          ".......Sorry this product have only ${mViewModel.brandProductList[index].stock} in a stock......");
      String msg =
          "Only ${mViewModel.brandProductList[index].stock} product available in stock";
      CommonUtils.showCustomToast(context, msg);
    } else if (mViewModel.brandProductList[index].stock == 0) {
      print(".......Sorry this item is sold out......");
      String msg = "Sorry this item is sold out";
      CommonUtils.showCustomToast(context, msg);
    }
  }

  Future<void> decrementItem(int index) async {
    if ((mViewModel.brandProductList[index].cartCount ?? 0) > 0) {
      setState(() {
        mViewModel.brandProductList[index].cartCount =
            (mViewModel.brandProductList[index].cartCount ?? 0) - 1;
      });
      await mHomeViewModel.addToCartApi(
          variantId: mViewModel.brandProductList[index].variantId.toString(),
          type: 'm');
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SubBrandViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);
    mOfferViewModel = Provider.of<SubOfferViewModel>(context);
    mSubCategoryViewModel = Provider.of<SubCategoryViewModel>(context);
    mSearchViewModel = Provider.of<SearchViewModel>(context);
    mAllProductViewModel = Provider.of<ViewAllProductsViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: widget.title,
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
      body: Column(
        children: [
          if (mViewModel.brandCategoryList.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]),
              child: SizedBox(
                height: 102,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: mViewModel.brandCategoryList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          mViewModel.currentPage = 1;
                          mViewModel.isPageFinish = false;
                          mViewModel.isInitialLoading = true;
                          mViewModel.brandProductList.clear();
                          // mViewModel.subCategoryList.clear();

                          mViewModel.getBrandProductApi(
                              latitude: gUserLat,
                              longitude: gUserLong,
                              brandId: mViewModel
                                  .brandCategoryList[index].brandId
                                  .toString());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: _selectedIndex == index
                                  //         ? Colors.orange
                                  //         : Colors.grey.shade50,
                                  //     width: 4),
                                  gradient: LinearGradient(
                                    colors: _selectedIndex == index
                                        ? [
                                            Colors.yellow.withOpacity(0.1),
                                            Colors.orange
                                          ]
                                        : [
                                            Colors.grey.shade50,
                                            Colors.grey.shade50
                                          ],
                                    //begin: Alignment.topLeft,
                                    //end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mViewModel
                                              .brandCategoryList[index].image ??
                                          ''),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                // CachedNetworkImage(
                                //   imageUrl: mViewModel
                                //           .brandCategoryList[index].image ??
                                //       '',
                                //   imageBuilder: (context, imageProvider) =>
                                //       Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: imageProvider,
                                //         fit: BoxFit.contain,
                                //       ),
                                //     ),
                                //   ),
                                //   placeholder: (context, url) => Padding(
                                //     padding: EdgeInsets.all(12.0),
                                //     child: Center(
                                //       child: CircularProgressIndicator(
                                //         strokeWidth: 2,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //   ),
                                //   errorWidget: (context, url, error) => Center(
                                //     child: Icon(
                                //       Icons.error_outline,
                                //       color: Colors.red,
                                //     ),
                                //   ),
                                // ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2, bottom: 3),
                                child: SizedBox(
                                  width: 80,
                                  child: Text(
                                    mViewModel.brandCategoryList[index].name ??
                                        '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: getAppStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 4,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: _selectedIndex == index
                                        ? [
                                            Colors.yellow.shade700,
                                            Colors.orange
                                          ]
                                        : [
                                            Colors.transparent,
                                            Colors.transparent
                                          ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          mViewModel.isInitialLoading
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Container(
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                    kCommonSpaceV5,
                                    Container(
                                      height: 14.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              kCommonSpaceV5,
                                              Container(
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
              : Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: mViewModel.brandProductList.length,
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ProductContainer(
                            onTapProduct: () async {
                              var variantId =
                                  mViewModel.brandProductList[index].variantId;
                              if (!isBottomSheetOpen) {
                                isBottomSheetOpen = true;
                                await mHomeViewModel.getProductDetailsApi(
                                  variantId: variantId?.toString() ?? '',
                                );
                                if (mHomeViewModel.productDetailsData != null) {
                                  productDetailsBottomSheet(variantId!);
                                }
                              }
                            },
                            imgUrl:
                                mViewModel.brandProductList[index].image ?? '',
                            productName: mViewModel
                                    .brandProductList[index].productName ??
                                '',
                            onIncrement: () => incrementItem(index),
                            onDecrement: () => decrementItem(index),
                            stock:
                                mViewModel.brandProductList[index].stock ?? 0,
                            variantName: mViewModel
                                    .brandProductList[index].variantName ??
                                '',
                            discountPrice: mViewModel
                                    .brandProductList[index].discountPrice ??
                                0,
                            productPrice: mViewModel
                                    .brandProductList[index].productPrice ??
                                0,
                            discountPer: mViewModel
                                    .brandProductList[index].discountPer ??
                                0,
                            cartCount:
                                mViewModel.brandProductList[index].cartCount ??
                                    0,
                            productId: mViewModel
                                .brandProductList[index].productId
                                .toString(),
                            variantId: mViewModel
                                .brandProductList[index].variantId
                                .toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return mHomeViewModel.cartDataList.isNotEmpty
              ? FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15) +
                        const EdgeInsets.only(top: 14, bottom: 5),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 48,
                            width: 60,
                            margin: const EdgeInsets.only(right: 6),
                            color: Colors.transparent,
                            child: Stack(
                              children: List.generate(
                                // Get the last three items or the total length if less than 3
                                mHomeViewModel.cartDataList.length > 3
                                    ? 3
                                    : mHomeViewModel.cartDataList.length,
                                (index) {
                                  // Calculate the index from the end of the list
                                  int reverseIndex =
                                      mHomeViewModel.cartDataList.length -
                                          1 -
                                          index;

                                  return Positioned(
                                    left: index * 6,
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: CommonColors.mGrey500),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: homeViewModel
                                                .cartDataList[reverseIndex]
                                                .image ??
                                            '',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              void incrementItem(int index) {
                                if ((homeViewModel
                                            .cartDataList[index].cartCount ??
                                        0) <
                                    (homeViewModel.cartDataList[index].stock ??
                                        0)) {
                                  setState(() {
                                    for (var item
                                        in homeViewModel.section4DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in homeViewModel.section9DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount = item.cartCount + 1;
                                        break;
                                      }
                                    }

                                    for (var item in mSubCategoryViewModel
                                        .categoryProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mOfferViewModel.offerProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mSearchViewModel.productList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    for (var item in mAllProductViewModel
                                        .viewAllProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mViewModel.brandProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) + 1;
                                        break;
                                      }
                                    }

                                    homeViewModel.cartDataList[index]
                                        .cartCount = (homeViewModel
                                                .cartDataList[index]
                                                .cartCount ??
                                            0) +
                                        1;
                                  });

                                  homeViewModel.addToCartApi(
                                    variantId: homeViewModel
                                        .cartDataList[index].variantId
                                        .toString(),
                                    type: 'p',
                                  );
                                } else {
                                  print(
                                      ".......Sorry this product have only ${homeViewModel.cartDataList[index].stock} in stock......");
                                  String msg =
                                      "Only ${homeViewModel.cartDataList[index].stock} product available in stock";
                                  CommonUtils.showCustomToast(context, msg);
                                }
                              }

                              void decrementItem(int index) {
                                if ((homeViewModel
                                            .cartDataList[index].cartCount ??
                                        0) >
                                    1) {
                                  setState(() {
                                    for (var item
                                        in homeViewModel.section4DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in homeViewModel.section9DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount = item.cartCount - 1;
                                        break;
                                      }
                                    }

                                    for (var item in mSubCategoryViewModel
                                        .categoryProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mOfferViewModel.offerProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mSearchViewModel.productList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item in mAllProductViewModel
                                        .viewAllProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mViewModel.brandProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    homeViewModel.cartDataList[index]
                                        .cartCount = (homeViewModel
                                                .cartDataList[index]
                                                .cartCount ??
                                            0) -
                                        1;
                                  });

                                  homeViewModel.addToCartApi(
                                      variantId: homeViewModel
                                          .cartDataList[index].variantId
                                          .toString(),
                                      type: 'm');
                                } else if (homeViewModel
                                        .cartDataList[index].cartCount ==
                                    1) {
                                  homeViewModel.addToCartApi(
                                      variantId: homeViewModel
                                          .cartDataList[index].variantId
                                          .toString(),
                                      type: 'm');

                                  setState(() {
                                    for (var item
                                        in homeViewModel.section4DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount = item.cartCount - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in homeViewModel.section9DataList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount = item.cartCount - 1;
                                        break;
                                      }
                                    }

                                    for (var item in mSubCategoryViewModel
                                        .categoryProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mOfferViewModel.offerProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mSearchViewModel.productList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item in mAllProductViewModel
                                        .viewAllProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    for (var item
                                        in mViewModel.brandProductList) {
                                      if (homeViewModel
                                              .cartDataList[index].variantId
                                              ?.toString()
                                              .trim() ==
                                          item.variantId.toString().trim()) {
                                        item.cartCount =
                                            (item.cartCount ?? 0) - 1;
                                        break;
                                      }
                                    }

                                    homeViewModel.cartDataList.removeAt(index);
                                  });

                                  if (homeViewModel.cartDataList.length == 0) {
                                    Navigator.pop(context);
                                  }
                                }
                              }

                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (_) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15, top: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Review Cart',
                                                      style: getAppStyle(
                                                          color: CommonColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${mHomeViewModel.cartDataList.length} Items • Total ",
                                                          style: getAppStyle(
                                                              color:
                                                                  CommonColors
                                                                      .black54),
                                                        ),
                                                        Text(
                                                          "₹${mHomeViewModel.cartTotalPrice}",
                                                          style: getAppStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: const Offset(
                                                            2.0,
                                                            2.0,
                                                          ),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 0.0,
                                                        ), //BoxShadow
                                                        BoxShadow(
                                                          color: CommonColors
                                                              .primaryColor,
                                                          offset: const Offset(
                                                              0.0, 0.0),
                                                          blurRadius: 0.0,
                                                          spreadRadius: 0.0,
                                                        ), //BoxShadow
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color:
                                                            CommonColors.mWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          kCommonSpaceV10,
                                          kCommonSpaceV3,
                                          Container(
                                            height: 3,
                                            color: Colors.grey[300],
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.grey[100],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                child: Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding:
                                                          EdgeInsets.all(18),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: homeViewModel
                                                          .cartDataList.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CachedNetworkImage(
                                                                  height: 60,
                                                                  width: 70,
                                                                  imageUrl: mHomeViewModel
                                                                          .cartDataList[
                                                                              index]
                                                                          .image ??
                                                                      '',
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            12.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .error_outline,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 14),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        mHomeViewModel.cartDataList[index].productName ??
                                                                            '',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            getAppStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                02),
                                                                        child:
                                                                            Text(
                                                                          mHomeViewModel.cartDataList[index].variantName ??
                                                                              '',
                                                                          style:
                                                                              getAppStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              4,
                                                                          vertical:
                                                                              4),
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              4),
                                                                      height:
                                                                          30,
                                                                      width: 80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                        color: CommonColors
                                                                            .primaryColor,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              decrementItem(index);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.remove,
                                                                              size: 16,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            mHomeViewModel.cartDataList[index].cartCount.toString(),
                                                                            style:
                                                                                getAppStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              incrementItem(index);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                const Icon(
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
                                                                          "₹${mHomeViewModel.cartDataList[index].productPrice}",
                                                                          style:
                                                                              getAppStyle(
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          "₹${mHomeViewModel.cartDataList[index].discountPrice}",
                                                                          style:
                                                                              getAppStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10)
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 15,
                                                  left: 15),
                                              child: IntrinsicWidth(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      width: 60,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 6),
                                                      color: Colors.transparent,
                                                      child: Stack(
                                                        children: List.generate(
                                                          // Get the last three items or the total length if less than 3
                                                          homeViewModel
                                                                      .cartDataList
                                                                      .length >
                                                                  3
                                                              ? 3
                                                              : homeViewModel
                                                                  .cartDataList
                                                                  .length,
                                                          (index) {
                                                            // Calculate the index from the end of the list
                                                            int reverseIndex =
                                                                homeViewModel
                                                                        .cartDataList
                                                                        .length -
                                                                    1 -
                                                                    index;

                                                            return Positioned(
                                                              left: index * 6,
                                                              child: Container(
                                                                height: 48,
                                                                width: 48,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: CommonColors
                                                                          .mGrey500),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: mHomeViewModel
                                                                          .cartDataList[
                                                                              reverseIndex]
                                                                          .image ??
                                                                      '',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                    Icons
                                                                        .error_outline,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${mHomeViewModel.cartDataList.length} Items",
                                                            style: getAppStyle(
                                                              color: CommonColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: CommonColors
                                                                .primaryColor,
                                                            size: 30,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    kCommonSpaceH15,
                                                    kCommonSpaceH10,
                                                    PrimaryButton(
                                                      height: 50,
                                                      width: 220,
                                                      label: "View Cart",
                                                      buttonColor: CommonColors
                                                          .primaryColor,
                                                      labelColor: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      onPress: () {
                                                        Navigator.pop(context);
                                                        mainNavKey
                                                            .currentContext!
                                                            .read<
                                                                BottomNavbarViewModel>()
                                                            .onMenuTapped(3);
                                                        pushAndRemoveUntil(
                                                            BottomNavBarView());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "${mHomeViewModel.cartDataList.length} Items",
                                  style: getAppStyle(
                                    color: CommonColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_up_rounded,
                                  color: CommonColors.primaryColor,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          kCommonSpaceH15,
                          kCommonSpaceH15,
                          PrimaryButton(
                            height: 55,
                            width: 240,
                            label: "View Cart",
                            buttonColor: CommonColors.primaryColor,
                            labelColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            onPress: () {
                              mainNavKey.currentContext!
                                  .read<BottomNavbarViewModel>()
                                  .onMenuTapped(3);
                              pushAndRemoveUntil(BottomNavBarView());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox();
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
                            kCommonSpaceV10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Product Details',
                                  style: getAppStyle(
                                      color: CommonColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    isBottomSheetOpen = false;
                                  },
                                  child: Container(
                                    height: 26,
                                    width: 26,
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
                                          color: CommonColors.primaryColor,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CommonImgSliderView(
                              imgUrls: mHomeViewModel
                                  .productDetailsData![0].image!
                                  .map((imageData) => imageData.image ?? "")
                                  .toList(),
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
                                fontSize: 13,
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
                            kCommonSpaceV10,
                            Text(
                              mHomeViewModel.productDetailsData![0].description!
                                  .isEmpty
                                  ? ""
                                  : "Description",
                              style: getAppStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            HtmlWidget(
                              mHomeViewModel
                                      .productDetailsData![0].description ??
                                  "--",
                              textStyle: getAppStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: IntrinsicWidth(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   mHomeViewModel.productDetailsData
                                  //               ?.isNotEmpty ==
                                  //           true
                                  //       ? mHomeViewModel.productDetailsData![0]
                                  //               .variantName ??
                                  //           "No product Unit available"
                                  //       : "No product details available",
                                  //   style: getAppStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 13,
                                  //   ),
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${mHomeViewModel.productDetailsData?.isNotEmpty == true ? mHomeViewModel.productDetailsData![0].discountPrice.toString() : "No product details available"}",
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
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
                                          fontSize: 16,
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
                                                    CommonUtils.showCustomToast(
                                                        context, msg);
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
                                                fontSize: 16,
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
