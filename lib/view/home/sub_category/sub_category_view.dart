import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/common_appbar.dart';

class SubCategoryViewRedesign extends StatefulWidget {
  const SubCategoryViewRedesign({super.key});

  @override
  State<SubCategoryViewRedesign> createState() =>
      _SubCategoryViewRedesignState();
}

class _SubCategoryViewRedesignState extends State<SubCategoryViewRedesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Sub Category name",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 20),
            child: GestureDetector(
              onTap: () {
                debugPrint("On Tap Search");
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: const Row(
        children: [
          Column(
            children: [
              SubCategoryListView(),
            ],
          ),
          kCommonSpaceH10,
          Expanded(
            child: Column(
              children: [
                SubProductView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * Sub Category ListView * //

class SubCategoryListView extends StatefulWidget {
  const SubCategoryListView({super.key});

  @override
  State<SubCategoryListView> createState() => _SubCategoryListViewState();
}

class _SubCategoryListViewState extends State<SubCategoryListView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 90,
        decoration: const BoxDecoration(
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
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 10) +
                            const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: _selectedIndex == index
                                ? [
                                    Colors.orange.withOpacity(0.5),
                                    Colors.yellow.withOpacity(0.1)
                                  ]
                                : [Colors.grey.shade50, Colors.grey.shade50],
                            //begin: Alignment.topLeft,
                            //end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
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
                      ),
                      Container(
                        height: 70,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          gradient: LinearGradient(
                            colors: _selectedIndex == index
                                ? [Colors.yellow.shade700, Colors.orange]
                                : [Colors.transparent, Colors.transparent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 12, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Item Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == index
                                  ? Colors.orange
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
    );
  }
}

// * Sub Category Product GridView List * //

class SubProductView extends StatefulWidget {
  const SubProductView({super.key});

  @override
  State<SubProductView> createState() => _SubProductViewState();
}

class _SubProductViewState extends State<SubProductView> {
  final List<String> imageUrls = [
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
    "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
  ];

  late final PageController _pageController;
  int currentPageIndex = 0;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.63,
          crossAxisSpacing: 0,
          mainAxisSpacing: 5,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              productDetailsBottomSheet();
            },
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 85,
                        child: CarouselSlider(
                          items: imageUrls.map((image) {
                            return CachedNetworkImage(
                              imageUrl: image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 360,
                            viewportFraction: 1.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) =>
                                _onPageChanged(index),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          "₹10 Off",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 75,
                        left: 95,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: imageUrls.length,
                          effect: const WormEffect(
                              dotHeight: 3,
                              dotWidth: 3,
                              spacing: 2,
                              type: WormType.thinUnderground,
                              activeDotColor: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 18,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.orangeAccent.withOpacity(0.2)),
                    child: RichText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      maxLines: 1,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '11',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          TextSpan(
                            text: "Min",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2, right: 2),
                              child: Icon(
                                Icons.electric_bolt_rounded,
                                size: 10,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Text(
                    "5 kg",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹250.0",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "₹250.0",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            debugPrint("On Tap Sub Product");
                          },
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.blueAccent,
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
                ],
              ),
            ),
          );
        },
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return FractionallySizedBox(
            heightFactor: 0.73,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              //spreadRadius: 0.001,
                            ),
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
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
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
                  ProductImgSliderWidget(imgList: imageUrls),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    margin:
                        const EdgeInsets.only(right: 16, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.orangeAccent.withOpacity(0.2)),
                    child: RichText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      maxLines: 1,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Delivery in ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          TextSpan(
                            text: "11 Min",
                            style: TextStyle(
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
                  const Flexible(
                    child: Text(
                      "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Text(
                    "1 unit",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "₹${"80.0"}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "₹${"80.0"}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          "₹10 Off",
                          style: TextStyle(
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
                    child: const Row(
                      children: [
                        Text(
                          "More Details",
                          style: TextStyle(
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
                        const Text(
                          "Packaging Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "Blister",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Shelf Life",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "3 years",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Unit",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "1 Unit",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Marketed By",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "Procter & Gamble",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Country of Origin",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "India",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Return Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Customer Care Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "support@log2retail.in",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Return Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          "Call",
                          style: TextStyle(
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
                          child: const Row(
                            children: [
                              Text(
                                "Less Details",
                                style: TextStyle(
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
                      : const SizedBox.shrink(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "1 Unit",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "₹250.0",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "₹250.0",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Text(
                                    "₹10 Off",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
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
                              child: const Center(
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
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
            ),
          );
        });
      },
    );
  }
}

class ProductImgSliderWidget extends StatefulWidget {
  final List<String> imgList;

  const ProductImgSliderWidget({super.key, required this.imgList});

  @override
  _ProductImgSliderWidgetState createState() => _ProductImgSliderWidgetState();
}

class _ProductImgSliderWidgetState extends State<ProductImgSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map(
          (item) => CachedNetworkImage(
            imageUrl: item,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
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
          children: widget.imgList.map(
            (url) {
              int index = widget.imgList.indexOf(url);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6.0,
                width: 6.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 2.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.black : Colors.grey,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
