import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/common_appbar.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({super.key});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
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
      body: const Column(
        children: [
          kCommonSpaceV15,
          SubCategoryListView(),
          SizedBox(height: 10),
          SubProductView(),
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
    return SizedBox(
      height: 91,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 08),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //     color: _selectedIndex == index
                      //         ? Colors.orange
                      //         : Colors.grey.shade50,
                      //     width: 4),
                      gradient: LinearGradient(
                        colors: _selectedIndex == index
                            ? [Colors.yellow.withOpacity(0.1), Colors.orange]
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
                  const Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 3),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        "Item Name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
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
            ),
          );
        },
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
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.699,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      child: CarouselSlider(
                        items: imageUrls.map((image) {
                          return CachedNetworkImage(
                            imageUrl: image,
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 88,
                      left: 112,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: imageUrls.length,
                        effect: const WormEffect(
                            dotHeight: 4,
                            dotWidth: 4,
                            spacing: 4,
                            type: WormType.thinUnderground,
                            activeDotColor: Colors.red),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orangeAccent.withOpacity(0.2)),
                  child: Center(
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
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250 Cashew Nuts 250",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
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
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("On Tap Sub Product");
                        },
                        child: Container(
                          height: 40,
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
                                fontSize: 16,
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
          );
        },
      ),
    );
  }
}
