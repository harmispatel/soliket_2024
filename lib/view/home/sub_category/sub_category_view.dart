import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/home/sub_category/sub_category_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/common_appbar.dart';

class SubCategoryView extends StatefulWidget {
  final int categoryId;

  SubCategoryView({super.key, required this.categoryId});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  late SubCategoryViewModel mViewModel;
  final ScrollController _scrollController = ScrollController();
  int itemCount = 0;
  int _selectedIndex = 0;

  bool isExpanded = false;

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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      mViewModel.getCategoryProductApi(
          latitude: gUserLat,
          longitude: gUserLong,
          categoryId: widget.categoryId.toString());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.resetPage();
    mViewModel.subCategoryList.clear();
    super.dispose();
  }

  void _scrollListener() {
    final mViewModel = context.read<SubCategoryViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getCategoryProductApi(
        latitude: gUserLat,
        longitude: gUserLong,
        categoryId: widget.categoryId.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SubCategoryViewModel>(context);
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
      body: Row(
        children: [
          if (mViewModel.subCategoryList.isNotEmpty) ...[
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          //spreadRadius: 0.001,
                        )
                      ],
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      scrollDirection: Axis.vertical,
                      itemCount: mViewModel.subCategoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });

                            print(
                                "Category id :::: ${mViewModel.subCategoryList[index].subCategoryId}");

                            // mViewModel.resetPage();

                            mViewModel.currentPage = 1;
                            mViewModel.isPageFinish = false;
                            mViewModel.isInitialLoading = true;
                            mViewModel.categoryProductList.clear();
                            // mViewModel.subCategoryList.clear();

                            mViewModel.getCategoryProductApi(
                              latitude: gUserLat,
                              longitude: gUserLong,
                              categoryId: widget.categoryId.toString(),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10) +
                                            EdgeInsets.only(left: 6),
                                    padding: EdgeInsets.all(6),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: _selectedIndex == index
                                            ? [
                                                Colors.orange.withOpacity(0.5),
                                                Colors.yellow.withOpacity(0.1)
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
                                    child: CachedNetworkImage(
                                      imageUrl: mViewModel
                                              .subCategoryList[index].image ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        colors: _selectedIndex == index
                                            ? [
                                                CommonColors.primaryColor
                                                    .withOpacity(0.5),
                                                CommonColors.primaryColor
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 12, left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        mViewModel
                                                .subCategoryList[index].name ??
                                            '',
                                        textAlign: TextAlign.center,
                                        style: getAppStyle(
                                          fontSize: 12,
                                          color: _selectedIndex == index
                                              ? CommonColors.primaryColor
                                              : Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            kCommonSpaceH10,
          ],
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: mViewModel.subCategoryList.isEmpty
                        ? EdgeInsets.all(15)
                        : EdgeInsets.only(top: 15, right: 5),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: mViewModel.categoryProductList.length,
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
                                            if (mViewModel
                                                    .categoryProductList[index]
                                                    .stock !=
                                                0)
                                              Center(
                                                child: Image.network(
                                                  mViewModel
                                                          .categoryProductList[
                                                              index]
                                                          .image ??
                                                      '',
                                                  fit: BoxFit.contain,
                                                  height: 170,
                                                ),
                                              ),
                                            if (mViewModel
                                                    .categoryProductList[index]
                                                    .stock ==
                                                0)
                                              Center(
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.white
                                                        .withOpacity(0.5),
                                                    BlendMode
                                                        .srcOver, // Blend mode for overlay
                                                  ),
                                                  child: Image.network(
                                                    mViewModel
                                                            .categoryProductList[
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
                                              mViewModel
                                                      .categoryProductList[
                                                          index]
                                                      .productName ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: getAppStyle(
                                                  fontSize: 14,
                                                  color: mViewModel
                                                              .categoryProductList[
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
                                            mViewModel
                                                    .categoryProductList[index]
                                                    .variantName ??
                                                '',
                                            style: getAppStyle(
                                              fontSize: 14,
                                              color: mViewModel
                                                          .categoryProductList[
                                                              index]
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
                                                        .categoryProductList[
                                                            index]
                                                        .discountPrice
                                                        .toString(),
                                                    style: getAppStyle(
                                                      fontSize: 14,
                                                      color: mViewModel
                                                                  .categoryProductList[
                                                                      index]
                                                                  .stock ==
                                                              0
                                                          ? Colors.grey[400]
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    mViewModel
                                                        .categoryProductList[
                                                            index]
                                                        .productPrice
                                                        .toString(),
                                                    style: getAppStyle(
                                                      color: mViewModel
                                                                  .categoryProductList[
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
                                                      .categoryProductList[
                                                          index]
                                                      .stock !=
                                                  0) ...[
                                                itemCount > 0
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4,
                                                                vertical: 4),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 4),
                                                        height: 35,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
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
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              itemCount
                                                                  .toString(),
                                                              style:
                                                                  getAppStyle(
                                                                color: Colors
                                                                    .white,
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
                                                                color: Colors
                                                                    .white,
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
                                  if (mViewModel.categoryProductList[index]
                                              .discountPer !=
                                          0 &&
                                      mViewModel.categoryProductList[index]
                                              .stock !=
                                          0)
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          child: Text(
                                            "${mViewModel.categoryProductList[index].discountPer}% off",
                                            style: getAppStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .categoryProductList[index].stock ==
                                      0)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                                color:
                                                    CommonColors.primaryColor,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void productDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20) +
                    EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.64,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 1,
                                        //spreadRadius: 0.001,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 1,
                                        //spreadRadius: 0.001,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      "https://cdn-icons-png.freepik.com/256/15707/15707820.png?ga=GA1.1.932127944.1675351316&semt=ais_hybrid",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ProductImgSliderWidget(),
                            Container(
                              height: 20,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              margin: EdgeInsets.only(
                                  right: 16, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.orangeAccent.withOpacity(0.2)),
                              child: RichText(
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
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
                                    WidgetSpan(
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
                              "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                              style: getAppStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "1 unit",
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
                                  "₹${"80.0"}",
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "₹${"80.0"}",
                                  style: getAppStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Text(
                                    "₹10 Off",
                                    style: getAppStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
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
                                  Icon(
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
                                  Text(
                                    "Packaging Type",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Blister",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Shelf Life",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "3 years",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Unit",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "1 Unit",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Marketed By",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Procter & Gamble",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Country of Origin",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "India",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Return Policy",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Customer Care Details",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "support@log2retail.in",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Return Policy",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Type",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Call",
                                    style: getAppStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
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
                                        Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.blueAccent,
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1 Unit",
                                style: getAppStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹250.0",
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "₹250.0",
                                    style: getAppStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Text(
                                      "₹10 Off",
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
                          SizedBox(width: 30),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                debugPrint("On Tap Add to Cart");
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.blueAccent,
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
                          ),
                        ],
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

// class SubCategoryListView extends StatefulWidget {
//   SubCategoryListView({super.key});
//
//   @override
//   State<SubCategoryListView> createState() => _SubCategoryListViewState();
// }
//
// class _SubCategoryListViewState extends State<SubCategoryListView> {
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: 100,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 1,
//               //spreadRadius: 0.001,
//             )
//           ],
//         ),
//         child: ListView.builder(
//           padding: EdgeInsets.only(top: 12, bottom: 12),
//           scrollDirection: Axis.vertical,
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         height: 70,
//                         width: 70,
//                         margin: EdgeInsets.symmetric(horizontal: 10) +
//                             EdgeInsets.only(left: 6),
//                         padding: EdgeInsets.symmetric(horizontal: 6),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomRight,
//                             colors: _selectedIndex == index
//                                 ? [
//                                     Colors.orange.withOpacity(0.5),
//                                     Colors.yellow.withOpacity(0.1)
//                                   ]
//                                 : [Colors.grey.shade50, Colors.grey.shade50],
//                             //begin: Alignment.topLeft,
//                             //end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl:
//                               "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                           imageBuilder: (context, imageProvider) => Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: imageProvider,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                           placeholder: (context, url) => Padding(
//                             padding: EdgeInsets.all(12.0),
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => Center(
//                             child: Icon(
//                               Icons.error_outline,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         width: 4,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10),
//                             topLeft: Radius.circular(10),
//                           ),
//                           gradient: LinearGradient(
//                             colors: _selectedIndex == index
//                                 ? [Colors.yellow.shade700, Colors.orange]
//                                 : [Colors.transparent, Colors.transparent],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2, bottom: 12, left: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 80,
//                           child: Text(
//                             "Item Name",
//                             textAlign: TextAlign.center,
//                             style: getAppStyle(
//                               fontSize: 12,
//                               color: _selectedIndex == index
//                                   ? Colors.orange
//                                   : Colors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class ProductImgSliderWidget extends StatefulWidget {
  ProductImgSliderWidget({super.key});

  @override
  _ProductImgSliderWidgetState createState() => _ProductImgSliderWidgetState();
}

class _ProductImgSliderWidgetState extends State<ProductImgSliderWidget> {
  final List<String> imgUrls = [
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgUrls.map((item) {
      return CachedNetworkImage(
        imageUrl: item,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.image),
      );
    }).toList();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgUrls.asMap().entries.map((entry) {
            int index = entry.key;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 6.0,
              width: 6.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.black : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
