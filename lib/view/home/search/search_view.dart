import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/common_view/bottom_navbar/bottom_navbar_view.dart';
import 'package:solikat_2024/view/home/search/search_view_model.dart';
import 'package:solikat_2024/view/home/view_all_products/view_all_products_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widget/common_product_container_view.dart';
import '../../../widget/common_text_field.dart';
import '../../../widget/primary_button.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../../common_view/common_img_slider/common_img_slider_view.dart';
import '../home_view_model.dart';
import '../sub_brand/sub_brand_view_model.dart';
import '../sub_category/sub_category_view_model.dart';
import '../sub_offer/sub_offer_view_model.dart';

class SearchView extends StatefulWidget {
  final String voiceText;
  const SearchView({super.key, required this.voiceText});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isSpeaking = false;
  int itemCount = 0;
  bool isBottomSheetOpen = false;

  late SearchViewModel mViewModel;
  late HomeViewModel mHomeViewModel;
  late SubCategoryViewModel mSubCategoryViewModel;
  late SubOfferViewModel mOfferViewModel;
  late ViewAllProductsViewModel mAllProductViewModel;
  late SubBrandViewModel mBrandViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mHomeViewModel.attachedContext(context);
      mSubCategoryViewModel.attachedContext(context);
      mOfferViewModel.attachedContext(context);
      mAllProductViewModel.attachedContext(context);
      mBrandViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      if (widget.voiceText.isNotEmpty) {
        searchController.text = widget.voiceText;
        mViewModel.getSearchDataApi(
          latitude: gUserLat,
          longitude: gUserLong,
          keyWord: searchController.text.trim(),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.currentPage = 1;
    mViewModel.productList.clear();
    searchController.clear();
    super.dispose();
  }

  void _scrollListener() {
    final mViewModel = context.read<SearchViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getSearchDataApi(
        latitude: gUserLat,
        longitude: gUserLong,
        keyWord: searchController.text.trim(),
      );
    }
  }

  Future<void> incrementItem(int index) async {
    if ((mViewModel.productList[index].cartCount ?? 0) <
        (mViewModel.productList[index].stock ?? 0)) {
      setState(() {
        mViewModel.productList[index].cartCount =
            (mViewModel.productList[index].cartCount ?? 0) + 1;
      });
      await mHomeViewModel.addToCartApi(
          variantId: mViewModel.productList[index].variantId.toString(),
          type: 'p');
    } else if (mViewModel.productList[index].stock != 0) {
      print(
          ".......Sorry this product have only ${mViewModel.productList[index].stock} in a stock......");
      String msg =
          "Only ${mViewModel.productList[index].stock} product available in stock";
      CommonUtils.showCustomToast(context, msg);
    } else if (mViewModel.productList[index].stock == 0) {
      print(".......Sorry this item is sold out......");
      String msg = "Sorry this item is sold out";
      CommonUtils.showCustomToast(context, msg);
    }
  }

  Future<void> decrementItem(int index) async {
    if ((mViewModel.productList[index].cartCount ?? 0) > 0) {
      setState(() {
        mViewModel.productList[index].cartCount =
            (mViewModel.productList[index].cartCount ?? 0) - 1;
      });
      await mHomeViewModel.addToCartApi(
          variantId: mViewModel.productList[index].variantId.toString(),
          type: 'm');
    }
  }

  /// Start listening for speech input
  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _isSpeaking = true;
      });

      _showBottomSheet(context);

      _speechToText.listen(
        onResult: (result) {
          setState(() {
            searchController.text = result.recognizedWords;
          });
        },
        listenFor: Duration(seconds: 3),
        pauseFor: Duration(seconds: 3),
        partialResults: true,
        onSoundLevelChange: (level) {},
      );
      // Automatically close the dialog after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        if (_isListening) {
          _stopListening();
          mViewModel.getSearchDataApi(
            latitude: gUserLat,
            longitude: gUserLong,
            keyWord: searchController.text,
          );
        }
      });
    } else {
      print("Speech recognition not available.");
    }
  }

  /// Stop listening when the user pauses or finishes speaking
  void _stopListening() {
    _speechToText.stop();
    setState(() {
      _isListening = false;
      _isSpeaking = false;
    });

    Navigator.of(context).pop();
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(height: 200, LocalImages.speakingGif),
                SizedBox(height: 20),
                Text(
                  "Listening...",
                  style: getAppStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SearchViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);
    mSubCategoryViewModel = Provider.of<SubCategoryViewModel>(context);
    mOfferViewModel = Provider.of<SubOfferViewModel>(context);
    mAllProductViewModel = Provider.of<ViewAllProductsViewModel>(context);
    mBrandViewModel = Provider.of<SubBrandViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CommonTextField(
            controller: searchController,
            hintText: "Search",
            isPrefixIconButton: true,
            prefixIcon: Icons.arrow_back,
            onPrefixIconPressed: () {
              Navigator.pop(context);
            },
            suffixIcon: Icons.mic,
            onSuffixIconPressed: () {
              if (_isListening) {
                _stopListening();
              } else {
                _startListening();
              }
            },
            isIconButton: true,
            onEditComplete: (value) {
              if (value.length >= 3) {
                mViewModel.currentPage = 1;
                mViewModel.productList.clear();
                mViewModel.getSearchDataApi(
                  latitude: gUserLat,
                  longitude: gUserLong,
                  keyWord: value,
                );
              } else if (value.length <= 2) {
                setState(() {
                  mViewModel.productList.clear();
                });
              }
            },
          )),
      body: mViewModel.productList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(height: 350, LocalImages.noProductGif),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              shrinkWrap: true,
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 2,
                mainAxisSpacing: 5,
              ),
              itemCount: mViewModel.productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ProductContainer(
                    onTapProduct: () async {
                      var variantId = mViewModel.productList[index].variantId;
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
                    imgUrl: mViewModel.productList[index].image ?? '',
                    productName:
                        mViewModel.productList[index].productName ?? '',
                    onIncrement: () => incrementItem(index),
                    onDecrement: () => decrementItem(index),
                    stock: mViewModel.productList[index].stock ?? 0,
                    variantName:
                        mViewModel.productList[index].variantName ?? '',
                    discountPrice:
                        mViewModel.productList[index].discountPrice ?? 0,
                    productPrice:
                        mViewModel.productList[index].productPrice ?? 0,
                    discountPer: mViewModel.productList[index].discountPer ?? 0,
                    cartCount: mViewModel.productList[index].cartCount ?? 0,
                    productId:
                        mViewModel.productList[index].productId.toString(),
                    variantId:
                        mViewModel.productList[index].variantId.toString(),
                  ),
                );
              },
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
                                        in mBrandViewModel.brandProductList) {
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

                                    for (var item in mViewModel.productList) {
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
                                        in mBrandViewModel.brandProductList) {
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

                                    for (var item in mViewModel.productList) {
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
                                        in mBrandViewModel.brandProductList) {
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

                                    for (var item in mViewModel.productList) {
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
                                                      padding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 8),
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
                              mHomeViewModel.productDetailsData![0].cartCount! >
                                      0
                                  ? Container(
                                      height: 55,
                                      width: 240,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                        .productDetailsData![0]
                                                        .stock ??
                                                    0; // Provide a default value (e.g., 0)

                                                if (mHomeViewModel
                                                        .productDetailsData![0]
                                                        .cartCount! <
                                                    stock) {
                                                  await mHomeViewModel
                                                      .addToCartApi(
                                                    variantId: mHomeViewModel
                                                        .productDetailsData![0]
                                                        .variantId
                                                        .toString(),
                                                    type: 'p',
                                                  );
                                                  setState(() {
                                                    mHomeViewModel
                                                        .productDetailsData![0]
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
                                        if (mHomeViewModel
                                                .productDetailsData![0].stock !=
                                            0) {
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
                                        } else {
                                          CommonUtils.showCustomToast(context,
                                              "Only 0 item available in stock");
                                        }
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
