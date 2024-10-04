import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/view/home/profile/profile_view.dart';
import 'package:solikat_2024/widget/common_text_field.dart';

import '../../utils/common_colors.dart';
import '../../utils/constant.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imgList = [
    'https://img.freepik.com/free-photo/fresh-pasta-with-hearty-bolognese-parmesan-cheese-generated-by-ai_188544-9469.jpg',
    'https://thumbs.dreamstime.com/b/generative-ai-fruits-vegetables-arranged-heart-shape-healthy-food-nutrition-concept-isolated-business-generative-ai-315051475.jpg',
    'https://img.freepik.com/premium-photo/art-italian-dining-food-stock-photography_1036998-625.jpg',
    'https://img.freepik.com/premium-photo/italian-food_708558-399.jpg',
  ];
  final List<String> images = [
    'https://5.imimg.com/data5/SELLER/Default/2022/1/RY/QF/PW/120561215/aashirvaad-1kg-multi-grain-atta.jpg',
    'https://m.media-amazon.com/images/I/61Y1PZx5CZL.jpg',
    'https://ueirorganic.com/cdn/shop/files/purecowghee.jpg?v=1689066451',
    'https://www.jiomart.com/images/product/original/490861956/madhur-pure-hygienic-sugar-5-kg-product-images-o490861956-p490861956-0-202208221852.jpg?im=Resize=(420,420)',
    'https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg',
    'https://www.jiomart.com/images/product/original/rvcy9i9zh7/aachari-pickel-bittergourd-pickle-400gm-i-karele-ka-achar-product-images-orvcy9i9zh7-p597828449-0-202301242131.jpg?im=Resize=(420,420)',
    'https://cdn.justgotochef.com/uploads/1572864347-DNV-Moong%20Udad%20Handmade%20Flavoured%20Spicy%20Special%20Masala%20Papad,%20100gm-Front.jpg',
    'https://www.jiomart.com/images/product/original/rvhnbrzv9i/naturoz-mixed-dry-fruits-200-g-pack-of-5-product-images-orvhnbrzv9i-p590318090-0-202212141041.jpg?im=Resize=(420,420)',
  ];
  final List<String> text = [
    "oil & ghee",
    "oil & ghee & sugar",
    "ghee",
    "sugar",
    "dry fruit",
    "atta",
    "oil & ghee & basson",
    "oil & ghee",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivering to",
                            style: getAppStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.2),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Home - Joshupura, junagadh, gujarat, Joshuphui hui ura",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontSize: 14,
                                      height: 1.2,
                                      color: CommonColors.black54),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: CommonColors.black54),
                              kCommonSpaceH15,
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: CommonColors.mGrey200),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            push(ProfileView());
                          },
                          child: Icon(
                            Icons.person_2_outlined,
                            color: CommonColors.black54,
                            size: 22,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 60.0,
                maxHeight: 60.0,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: CommonTextField(
                      hintText: "Search",
                      isPrefixIconButton: true,
                      suffixIcon: Icons.mic,
                      isIconButton: true,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: FittedBox(
                  child: Text(
                    "🛵 Free Delivery on first 3 orders! Use Code: FREEDEL 🛍️",
                    maxLines: 1,
                    style: getAppStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: imgList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15.0), // Curve the corners
                      image: DecorationImage(
                        image: NetworkImage(imgList[itemIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Grocery",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 12.0, // Horizontal spacing between items
                    mainAxisSpacing: 10.0, // Vertical spacing between items
                    childAspectRatio:
                        0.7, // Aspect ratio for each item (adjust as needed)
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        // Use Flexible to dynamically adjust height
                        Flexible(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Colors.blueAccent.shade100.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // image: NetworkImage(images[index]),
                                    image: NetworkImage(
                                        "https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5), // Space between image and text

                        // Text that wraps and adjusts based on content
                        Flexible(
                          flex: 2,
                          child: Text(
                            text[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                                fontWeight: FontWeight.w500, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Dairy & Breakfast",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 12.0, // Horizontal spacing between items
                    mainAxisSpacing: 10.0, // Vertical spacing between items
                    childAspectRatio:
                        0.7, // Aspect ratio for each item (adjust as needed)
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        // Use Flexible to dynamically adjust height
                        Flexible(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Colors.blueAccent.shade100.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // image: NetworkImage(images[index]),
                                    image: NetworkImage(
                                        "https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5), // Space between image and text

                        // Text that wraps and adjusts based on content
                        Flexible(
                          flex: 2,
                          child: Text(
                            text[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                                fontWeight: FontWeight.w500, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Snacks & Drinks",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 12.0, // Horizontal spacing between items
                    mainAxisSpacing: 10.0, // Vertical spacing between items
                    childAspectRatio:
                        0.7, // Aspect ratio for each item (adjust as needed)
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        // Use Flexible to dynamically adjust height
                        Flexible(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // image: NetworkImage(images[index]),
                                    image: NetworkImage(
                                        "https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5), // Space between image and text

                        // Text that wraps and adjusts based on content
                        Flexible(
                          flex: 2,
                          child: Text(
                            text[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                                fontWeight: FontWeight.w500, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Beauty & Personal Care",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 12.0, // Horizontal spacing between items
                    mainAxisSpacing: 10.0, // Vertical spacing between items
                    childAspectRatio:
                        0.7, // Aspect ratio for each item (adjust as needed)
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        // Use Flexible to dynamically adjust height
                        Flexible(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade100.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // image: NetworkImage(images[index]),
                                    image: NetworkImage(
                                        "https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5), // Space between image and text

                        // Text that wraps and adjusts based on content
                        Flexible(
                          flex: 2,
                          child: Text(
                            text[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getAppStyle(
                                fontWeight: FontWeight.w500, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Har Rasoi ki Zarurat",
                      style: getAppStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.2),
                    ),
                    Text(
                      "View All >",
                      style: getAppStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.2,
                          color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      "https://www.consciousfood.com/cdn/shop/products/split_bengal_gram_chana_dal_i_1920.jpg?v=1684915570&width=1946"),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "Chana dal Loose 2 kg with ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "1 Kg",
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹450",
                                              style: getAppStyle(
                                                  height: 1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "₹59",
                                              style: getAppStyle(
                                                  color: CommonColors.black54,
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.indigo, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: getAppStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: CommonColors.mWhite, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Text(
                                    "24% off",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kCommonSpaceH15,
                      Container(
                        width: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      "https://www.jiomart.com/images/product/original/490863678/daawat-pulav-basmati-rice-1-kg-product-images-o490863678-p490863678-0-202205172225.jpg?im=Resize=(420,420)"),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "White crystel suger Loose 1 kg",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "1 Kg",
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹450",
                                              style: getAppStyle(
                                                  height: 1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "₹59",
                                              style: getAppStyle(
                                                  color: CommonColors.black54,
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.indigo, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: getAppStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: CommonColors.mWhite, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Text(
                                    "24% off",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kCommonSpaceH15,
                      Container(
                        width: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      "https://www.jiomart.com/images/product/original/490863678/daawat-pulav-basmati-rice-1-kg-product-images-o490863678-p490863678-0-202205172225.jpg?im=Resize=(420,420)"),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "White crystel suger Loose 1 kg",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "1 Kg",
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹450",
                                              style: getAppStyle(
                                                  height: 1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "₹59",
                                              style: getAppStyle(
                                                  color: CommonColors.black54,
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.indigo, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: getAppStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: CommonColors.mWhite, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Text(
                                    "24% off",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kCommonSpaceH15,
                      Container(
                        width: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      "https://www.jiomart.com/images/product/original/490863678/daawat-pulav-basmati-rice-1-kg-product-images-o490863678-p490863678-0-202205172225.jpg?im=Resize=(420,420)"),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "White crystel suger Loose 1 kg",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "1 Kg",
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹450",
                                              style: getAppStyle(
                                                  height: 1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "₹59",
                                              style: getAppStyle(
                                                  color: CommonColors.black54,
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.indigo, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: getAppStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: CommonColors.mWhite, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Text(
                                    "24% off",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kCommonSpaceH15,
                      Container(
                        width: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      "https://www.jiomart.com/images/product/original/490863678/daawat-pulav-basmati-rice-1-kg-product-images-o490863678-p490863678-0-202205172225.jpg?im=Resize=(420,420)"),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "White crystel suger Loose 1 kg",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV5,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      "1 Kg",
                                      style: getAppStyle(
                                          fontSize: 14,
                                          color: CommonColors.black54,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1),
                                    ),
                                  ),
                                  kCommonSpaceV10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹450",
                                              style: getAppStyle(
                                                  height: 1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "₹59",
                                              style: getAppStyle(
                                                  color: CommonColors.black54,
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.indigo, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: getAppStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: CommonColors.mWhite, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Text(
                                    "24% off",
                                    style: getAppStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://www.jiomart.com/images/product/original/490863678/daawat-pulav-basmati-rice-1-kg-product-images-o490863678-p490863678-0-202205172225.jpg?im=Resize=(420,420)"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Image.network(
            //       "https://thumbs.dreamstime.com/b/buy-get-free-set-sale-banners-design-template-discount-tags-collection-great-offer-vector-illustration-badge-app-icons-218969706.jpg"),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Breaking Deals",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                       "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg",
            //                       height: 180,
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://m.media-amazon.com/images/I/41ndyTsEe3L._AC_UF1000,1000_QL80_.jpg",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Instant Food",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://static.india.com/wp-content/uploads/2023/11/9-Best-Street-Foods-In-Ahmedabad-You-Must-Try-in-2023.png?impolicy=Medium_Widthonly&w=400&h=800",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://paramountclientweb.s3.ap-south-1.amazonaws.com/indian-holiday-trip/visualstories/Img_6551_202255130539_Dhokla.jpg?time=1657692020",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Text(
            //       "Offer Zone",
            //       style: getAppStyle(
            //           fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           height: 130,
            //           clipBehavior: Clip.antiAlias,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12)),
            //           child: Image.network(
            //               "https://scontent.famd5-2.fna.fbcdn.net/v/t39.30808-6/432983344_920106996792517_5703558992172754115_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_ohc=oiYsSK4owfYQ7kNvgEhooN5&_nc_ht=scontent.famd5-2.fna&_nc_gid=AbmydzRq8mshWtIXB8CmuKN&oh=00_AYDRrizk824duetP4rGOPkWJXkmCG4q1jZkXsd0N8SWajg&oe=67009010"),
            //         ),
            //         kCommonSpaceH10,
            //         Container(
            //           height: 130,
            //           clipBehavior: Clip.antiAlias,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12)),
            //           child: Image.network(
            //             "https://scontent.famd5-4.fna.fbcdn.net/v/t39.30808-6/423554040_761825772633645_4191526503972294853_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_ohc=PY2SXVnvevUQ7kNvgGWe99e&_nc_ht=scontent.famd5-4.fna&_nc_gid=A1QLxuAv7dtceuyvquvOvEF&oh=00_AYBx8L-6FXC4I6MW5p8Tm7EHajmBZv8ptMMyjuDP1xEDAw&oe=67008A39",
            //           ),
            //         ),
            //         kCommonSpaceH10,
            //         Container(
            //           height: 130,
            //           clipBehavior: Clip.antiAlias,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12)),
            //           child: Image.network(
            //               "https://img.freepik.com/premium-psd/instagram-give-away-contest-banner-social-media-post-template_368797-1070.jpg?w=740"),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Instant Mithai",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 15,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://www.meethi.in/cdn/shop/files/25-pink.webp?v=1697779111",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://images.jdmagicbox.com/quickquotes/images_main/rectangle-sweet-box-2216891232-90jos1es.jpg",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 500,
            //     child: Stack(
            //       children: [
            //         Container(
            //           color: Color(0xff0c5027).withOpacity(0.9),
            //           height: 500,
            //         ),
            //         Column(
            //           children: [
            //             kCommonSpaceV20,
            //             Padding(
            //               padding: const EdgeInsets.only(left: 15, right: 15),
            //               child: Image.network(
            //                 "https://socialpanga.com/wp-content/uploads/2023/02/m13.png",
            //                 fit: BoxFit.cover,
            //                 height: 100,
            //                 width: kDeviceWidth,
            //               ),
            //             ),
            //             Spacer(),
            //             SingleChildScrollView(
            //               scrollDirection: Axis.horizontal,
            //               padding: const EdgeInsets.only(left: 15, right: 15),
            //               child: Row(
            //                 children: [
            //                   Container(
            //                     width: 180,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(10)),
            //                     child: Stack(
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Image.network(
            //                                 "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "White crystel suger Loose 1 kg",
            //                                 maxLines: 2,
            //                                 overflow: TextOverflow.ellipsis,
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "1 Kg",
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     color: CommonColors.black54,
            //                                     fontWeight: FontWeight.w500,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Text(
            //                                         "₹ 45",
            //                                         style: getAppStyle(
            //                                             height: 1,
            //                                             fontWeight:
            //                                                 FontWeight.w500),
            //                                       ),
            //                                       Text(
            //                                         "₹59",
            //                                         style: getAppStyle(
            //                                             color: CommonColors
            //                                                 .black54,
            //                                             decoration:
            //                                                 TextDecoration
            //                                                     .lineThrough),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Container(
            //                                     width: 100,
            //                                     height: 35,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(8),
            //                                       border: Border.all(
            //                                           color: Colors.indigo,
            //                                           width: 1),
            //                                     ),
            //                                     child: Center(
            //                                       child: Text(
            //                                         "Add",
            //                                         style: getAppStyle(
            //                                             color: Colors.indigo,
            //                                             fontSize: 16,
            //                                             fontWeight:
            //                                                 FontWeight.bold),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(5.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: Colors.amber.shade300,
            //                                 border: Border.all(
            //                                     color: CommonColors.mWhite,
            //                                     width: 2),
            //                                 borderRadius:
            //                                     BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8,
            //                                   right: 8,
            //                                   top: 5,
            //                                   bottom: 5),
            //                               child: Text(
            //                                 "24% off",
            //                                 style: getAppStyle(
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1,
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   kCommonSpaceH15,
            //                   Container(
            //                     width: 180,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(10)),
            //                     child: Stack(
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Image.network(
            //                                 "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "White crystel suger Loose 1 kg",
            //                                 maxLines: 2,
            //                                 overflow: TextOverflow.ellipsis,
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "1 Kg",
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     color: CommonColors.black54,
            //                                     fontWeight: FontWeight.w500,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Text(
            //                                         "₹ 45",
            //                                         style: getAppStyle(
            //                                             height: 1,
            //                                             fontWeight:
            //                                                 FontWeight.w500),
            //                                       ),
            //                                       Text(
            //                                         "₹59",
            //                                         style: getAppStyle(
            //                                             color: CommonColors
            //                                                 .black54,
            //                                             decoration:
            //                                                 TextDecoration
            //                                                     .lineThrough),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Container(
            //                                     width: 100,
            //                                     height: 35,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(8),
            //                                       border: Border.all(
            //                                           color: Colors.indigo,
            //                                           width: 1),
            //                                     ),
            //                                     child: Center(
            //                                       child: Text(
            //                                         "Add",
            //                                         style: getAppStyle(
            //                                             color: Colors.indigo,
            //                                             fontSize: 16,
            //                                             fontWeight:
            //                                                 FontWeight.bold),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(5.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: Colors.amber.shade300,
            //                                 border: Border.all(
            //                                     color: CommonColors.mWhite,
            //                                     width: 2),
            //                                 borderRadius:
            //                                     BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8,
            //                                   right: 8,
            //                                   top: 5,
            //                                   bottom: 5),
            //                               child: Text(
            //                                 "24% off",
            //                                 style: getAppStyle(
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1,
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   kCommonSpaceH15,
            //                   Container(
            //                     width: 180,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(10)),
            //                     child: Stack(
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Image.network(
            //                                 "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "White crystel suger Loose 1 kg",
            //                                 maxLines: 2,
            //                                 overflow: TextOverflow.ellipsis,
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "1 Kg",
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     color: CommonColors.black54,
            //                                     fontWeight: FontWeight.w500,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Text(
            //                                         "₹ 45",
            //                                         style: getAppStyle(
            //                                             height: 1,
            //                                             fontWeight:
            //                                                 FontWeight.w500),
            //                                       ),
            //                                       Text(
            //                                         "₹59",
            //                                         style: getAppStyle(
            //                                             color: CommonColors
            //                                                 .black54,
            //                                             decoration:
            //                                                 TextDecoration
            //                                                     .lineThrough),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Container(
            //                                     width: 100,
            //                                     height: 35,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(8),
            //                                       border: Border.all(
            //                                           color: Colors.indigo,
            //                                           width: 1),
            //                                     ),
            //                                     child: Center(
            //                                       child: Text(
            //                                         "Add",
            //                                         style: getAppStyle(
            //                                             color: Colors.indigo,
            //                                             fontSize: 16,
            //                                             fontWeight:
            //                                                 FontWeight.bold),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(5.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: Colors.amber.shade300,
            //                                 border: Border.all(
            //                                     color: CommonColors.mWhite,
            //                                     width: 2),
            //                                 borderRadius:
            //                                     BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8,
            //                                   right: 8,
            //                                   top: 5,
            //                                   bottom: 5),
            //                               child: Text(
            //                                 "24% off",
            //                                 style: getAppStyle(
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1,
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   kCommonSpaceH15,
            //                   Container(
            //                     width: 180,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(10)),
            //                     child: Stack(
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Image.network(
            //                                 "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "White crystel suger Loose 1 kg",
            //                                 maxLines: 2,
            //                                 overflow: TextOverflow.ellipsis,
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "1 Kg",
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     color: CommonColors.black54,
            //                                     fontWeight: FontWeight.w500,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Text(
            //                                         "₹ 45",
            //                                         style: getAppStyle(
            //                                             height: 1,
            //                                             fontWeight:
            //                                                 FontWeight.w500),
            //                                       ),
            //                                       Text(
            //                                         "₹59",
            //                                         style: getAppStyle(
            //                                             color: CommonColors
            //                                                 .black54,
            //                                             decoration:
            //                                                 TextDecoration
            //                                                     .lineThrough),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Container(
            //                                     width: 100,
            //                                     height: 35,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(8),
            //                                       border: Border.all(
            //                                           color: Colors.indigo,
            //                                           width: 1),
            //                                     ),
            //                                     child: Center(
            //                                       child: Text(
            //                                         "Add",
            //                                         style: getAppStyle(
            //                                             color: Colors.indigo,
            //                                             fontSize: 16,
            //                                             fontWeight:
            //                                                 FontWeight.bold),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(5.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: Colors.amber.shade300,
            //                                 border: Border.all(
            //                                     color: CommonColors.mWhite,
            //                                     width: 2),
            //                                 borderRadius:
            //                                     BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8,
            //                                   right: 8,
            //                                   top: 5,
            //                                   bottom: 5),
            //                               child: Text(
            //                                 "24% off",
            //                                 style: getAppStyle(
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1,
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   kCommonSpaceH15,
            //                   Container(
            //                     width: 180,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(10)),
            //                     child: Stack(
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Image.network(
            //                                 "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "White crystel suger Loose 1 kg",
            //                                 maxLines: 2,
            //                                 overflow: TextOverflow.ellipsis,
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV5,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Text(
            //                                 "1 Kg",
            //                                 style: getAppStyle(
            //                                     fontSize: 15,
            //                                     color: CommonColors.black54,
            //                                     fontWeight: FontWeight.w500,
            //                                     height: 1.1),
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8, right: 8),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Text(
            //                                         "₹ 45",
            //                                         style: getAppStyle(
            //                                             height: 1,
            //                                             fontWeight:
            //                                                 FontWeight.w500),
            //                                       ),
            //                                       Text(
            //                                         "₹59",
            //                                         style: getAppStyle(
            //                                             color: CommonColors
            //                                                 .black54,
            //                                             decoration:
            //                                                 TextDecoration
            //                                                     .lineThrough),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Container(
            //                                     width: 100,
            //                                     height: 35,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(8),
            //                                       border: Border.all(
            //                                           color: Colors.indigo,
            //                                           width: 1),
            //                                     ),
            //                                     child: Center(
            //                                       child: Text(
            //                                         "Add",
            //                                         style: getAppStyle(
            //                                             color: Colors.indigo,
            //                                             fontSize: 16,
            //                                             fontWeight:
            //                                                 FontWeight.bold),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             kCommonSpaceV10,
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(5.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: Colors.amber.shade300,
            //                                 border: Border.all(
            //                                     color: CommonColors.mWhite,
            //                                     width: 2),
            //                                 borderRadius:
            //                                     BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 8,
            //                                   right: 8,
            //                                   top: 5,
            //                                   bottom: 5),
            //                               child: Text(
            //                                 "24% off",
            //                                 style: getAppStyle(
            //                                     fontWeight: FontWeight.bold,
            //                                     height: 1,
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             kCommonSpaceV20,
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     color: Color(0xff0c5027),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Padding(
            //           padding:
            //               const EdgeInsets.only(top: 12, bottom: 12, left: 15),
            //           child: Text(
            //             "View All Products",
            //             style: getAppStyle(
            //                 color: CommonColors.mWhite,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(right: 15),
            //           child: Icon(
            //             Icons.arrow_forward_ios_rounded,
            //             color: CommonColors.mWhite,
            //             size: 18,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Kids Colouring & toys",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 15,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://www.meethi.in/cdn/shop/files/25-pink.webp?v=1697779111",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://images.jdmagicbox.com/quickquotes/images_main/rectangle-sweet-box-2216891232-90jos1es.jpg",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 30,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 200,
            //     child: Stack(
            //       children: [
            //         Image.network(
            //             height: 200,
            //             width: kDeviceWidth,
            //             fit: BoxFit.fill,
            //             "https://i.pinimg.com/originals/b5/08/0a/b5080a3341b9046413ab1f7cd8b5f45a.png"),
            //         Center(
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 15, right: 15),
            //             child: GridView.builder(
            //               gridDelegate:
            //                   SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 4, // Number of items per row
            //                 crossAxisSpacing:
            //                     15.0, // Horizontal spacing between items
            //                 mainAxisSpacing:
            //                     10.0, // Vertical spacing between items
            //                 childAspectRatio:
            //                     0.7, // Aspect ratio for each item (adjust as needed)
            //               ),
            //               shrinkWrap: true,
            //               physics: NeverScrollableScrollPhysics(),
            //               itemCount: 4,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Column(
            //                   children: [
            //                     // Use Flexible to dynamically adjust height
            //                     Flexible(
            //                       flex: 4,
            //                       child: Container(
            //                         clipBehavior: Clip.antiAlias,
            //                         decoration: BoxDecoration(
            //                           color: Colors.blueAccent.shade100
            //                               .withOpacity(0.2),
            //                           borderRadius: BorderRadius.circular(15),
            //                           image: DecorationImage(
            //                             image: NetworkImage(images[index]),
            //                             fit: BoxFit.fill,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                         height: 5), // Space between image and text
            //
            //                     // Text that wraps and adjusts based on content
            //                     Flexible(
            //                       flex: 2,
            //                       child: Text(
            //                         text[index],
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold, height: 1),
            //                         textAlign: TextAlign.center,
            //                       ),
            //                     ),
            //                   ],
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Towels",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 15,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://www.meethi.in/cdn/shop/files/25-pink.webp?v=1697779111",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://images.jdmagicbox.com/quickquotes/images_main/rectangle-sweet-box-2216891232-90jos1es.jpg",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 40,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Center(
            //     child: Text(
            //       "---- BR❤️ND SPOTLIGHT ----",
            //       style: getAppStyle(
            //           letterSpacing: 5,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 18,
            //           height: 1.2),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 30,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 15, right: 15),
            //       child: GridView.builder(
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2, // Number of items per row
            //           crossAxisSpacing:
            //               15.0, // Horizontal spacing between items
            //           mainAxisSpacing: 10.0, // Vertical spacing between items
            //           childAspectRatio:
            //               0.9, // Aspect ratio for each item (adjust as needed)
            //         ),
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: 4,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Container(
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 color: Colors.pinkAccent.withOpacity(0.2),
            //                 borderRadius: BorderRadius.circular(15)),
            //             child: Container(
            //               clipBehavior: Clip.antiAlias,
            //               decoration: BoxDecoration(
            //                 color: Colors.blueAccent.shade100.withOpacity(0.2),
            //                 borderRadius: BorderRadius.circular(15),
            //                 image: DecorationImage(
            //                   image: NetworkImage(
            //                       "https://www.bigbasket.com/media/uploads/p/xl/40235864_1-don-monte-american-mix-dry-fruits-vitamins-minerals-fibre-rich-assorted-healthy-nuts.jpg"),
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 40,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Home Appliance",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               height: 1.2),
            //         ),
            //         Text(
            //           "View All >",
            //           style: getAppStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               height: 1.2,
            //               color: Colors.indigo),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 15,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://www.meethi.in/cdn/shop/files/25-pink.webp?v=1697779111",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Center(
            //                       child: Image.network(
            //                         "https://images.jdmagicbox.com/quickquotes/images_main/rectangle-sweet-box-2216891232-90jos1es.jpg",
            //                         height: 180,
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           kCommonSpaceH15,
            //           Container(
            //             width: 180,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Stack(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                         "https://vrmshoppe.com/wp-content/uploads/2021/05/white-sugar-500x500-1.jpg"),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "White crystel suger Loose 1 kg",
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV5,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Text(
            //                         "1 Kg",
            //                         style: getAppStyle(
            //                             fontSize: 15,
            //                             color: CommonColors.black54,
            //                             fontWeight: FontWeight.w500,
            //                             height: 1.1),
            //                       ),
            //                     ),
            //                     kCommonSpaceV10,
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 8, right: 8),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               Text(
            //                                 "₹ 45",
            //                                 style: getAppStyle(
            //                                     height: 1,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               Text(
            //                                 "₹59",
            //                                 style: getAppStyle(
            //                                     color: CommonColors.black54,
            //                                     decoration:
            //                                         TextDecoration.lineThrough),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             width: 100,
            //                             height: 35,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               border: Border.all(
            //                                   color: Colors.indigo, width: 1),
            //                             ),
            //                             child: Center(
            //                               child: Text(
            //                                 "Add",
            //                                 style: getAppStyle(
            //                                     color: Colors.indigo,
            //                                     fontSize: 16,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.amber.shade300,
            //                         border: Border.all(
            //                             color: CommonColors.mWhite, width: 2),
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           left: 8, right: 8, top: 5, bottom: 5),
            //                       child: Text(
            //                         "24% off",
            //                         style: getAppStyle(
            //                             fontWeight: FontWeight.bold,
            //                             height: 1,
            //                             fontSize: 12),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 40,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
