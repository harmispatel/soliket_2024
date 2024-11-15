import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/home/sub_brand/sub_brand_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/common_appbar.dart';

class SubBrandView extends StatefulWidget {
  final int brandId;

  SubBrandView({super.key, required this.brandId});

  @override
  State<SubBrandView> createState() => _SubBrandViewState();
}

class _SubBrandViewState extends State<SubBrandView> {
  late SubBrandViewModel mViewModel;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
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
    mViewModel = Provider.of<SubBrandViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Sub Category name",
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
                              brandId: widget.brandId.toString());
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
            SizedBox(height: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          if (mViewModel.brandProductList[index]
                                                  .stock !=
                                              0)
                                            Center(
                                              child: Image.network(
                                                mViewModel
                                                        .brandProductList[index]
                                                        .image ??
                                                    '',
                                                fit: BoxFit.contain,
                                                height: 170,
                                              ),
                                            ),
                                          if (mViewModel.brandProductList[index]
                                                  .stock ==
                                              0)
                                            Center(
                                              child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                  Colors.white.withOpacity(0.5),
                                                  BlendMode
                                                      .srcOver, // Blend mode for overlay
                                                ),
                                                child: Image.network(
                                                  mViewModel
                                                          .brandProductList[
                                                              index]
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            mViewModel.brandProductList[index]
                                                    .productName ??
                                                '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: getAppStyle(
                                                fontSize: 14,
                                                color: mViewModel
                                                            .brandProductList[
                                                                index]
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          mViewModel.brandProductList[index]
                                                  .variantName ??
                                              '',
                                          style: getAppStyle(
                                            fontSize: 14,
                                            color: mViewModel
                                                        .brandProductList[index]
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mViewModel
                                                      .brandProductList[index]
                                                      .discountPrice
                                                      .toString(),
                                                  style: getAppStyle(
                                                    fontSize: 14,
                                                    color: mViewModel
                                                                .brandProductList[
                                                                    index]
                                                                .stock ==
                                                            0
                                                        ? Colors.grey[400]
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  mViewModel
                                                      .brandProductList[index]
                                                      .productPrice
                                                      .toString(),
                                                  style: getAppStyle(
                                                    color: mViewModel
                                                                .brandProductList[
                                                                    index]
                                                                .stock ==
                                                            0
                                                        ? Colors.grey[400]
                                                        : Colors.black54,
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (mViewModel
                                                    .brandProductList[index]
                                                    .stock !=
                                                0) ...[
                                              itemCount > 0
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4,
                                                          vertical: 4),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 4),
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: CommonColors
                                                            .primaryColor,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap:
                                                                decrementItem,
                                                            child: const Icon(
                                                              Icons.remove,
                                                              size: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            itemCount
                                                                .toString(),
                                                            style: getAppStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap:
                                                                incrementItem,
                                                            child: const Icon(
                                                              Icons.add,
                                                              size: 16,
                                                              color:
                                                                  Colors.white,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
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
                                                                  FontWeight
                                                                      .bold,
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
                                if (mViewModel.brandProductList[index]
                                            .discountPer !=
                                        0 &&
                                    mViewModel.brandProductList[index].stock !=
                                        0)
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        child: Text(
                                          "${mViewModel.brandProductList[index].discountPer}% off",
                                          style: getAppStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (mViewModel.brandProductList[index].stock ==
                                    0)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 100),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.2),
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
                ),
        ],
      ),
    );
  }
}
