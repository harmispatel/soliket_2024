import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/local_images.dart';
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
              kCommonSpaceV15,
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: CommonTextField(
                  hintText: "Search",
                  isPrefixIconButton: true,
                  suffixIcon: Icons.mic,
                  isIconButton: true,
                ),
              ),
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              CarouselSlider.builder(
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
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Grocery",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Dairy & Breakfast",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Snacks & Drinks",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Beauty & Personal Care",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
              ),
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              Padding(
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
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductContainer(),
                      kCommonSpaceH10,
                      ProductContainer(),
                      kCommonSpaceH10,
                      ProductContainer(),
                      kCommonSpaceH10,
                      ProductContainer(),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV15,
              Stack(
                children: [
                  Image.asset(LocalImages.img_bg_cleaning),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, top: 160),
                    child: FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                // Use Flexible to dynamically adjust height
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                SizedBox(
                                    height: 5), // Space between image and text

                                // Text that wraps and adjusts based on content
                                Text(
                                  "Dry & Fruits",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w500, height: 1),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceH10,
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                // Use Flexible to dynamically adjust height
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                SizedBox(
                                    height: 5), // Space between image and text

                                // Text that wraps and adjusts based on content
                                Text(
                                  "Dry & Fruits and Nuts",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w500, height: 1),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceH10,
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                // Use Flexible to dynamically adjust height
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                SizedBox(
                                    height: 5), // Space between image and text

                                // Text that wraps and adjusts based on content
                                Text(
                                  "Dry & Fruits",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w500, height: 1),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceH10,
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                // Use Flexible to dynamically adjust height
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                SizedBox(
                                    height: 5), // Space between image and text

                                // Text that wraps and adjusts based on content
                                Text(
                                  "Dry & Fruits",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w500, height: 1),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              kCommonSpaceV15,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(LocalImages.img_masala_banner),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              kCommonSpaceV15,
            ],
          ),
        ),
      ),
    );
  }
}

class ProductContainer extends StatefulWidget {
  final String? imgUrl;
  final String? productName;

  const ProductContainer({super.key, this.imgUrl, this.productName});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.imgUrl ??
                    "https://www.consciousfood.com/cdn/shop/products/split_bengal_gram_chana_dal_i_1920.jpg?v=1684915570&width=1946"),
                kCommonSpaceV5,
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.productName ?? "Chana dal Loose 2 kg with ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getAppStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, height: 1.1),
                  ),
                ),
                kCommonSpaceV5,
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
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
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.indigo, width: 1),
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
                  border: Border.all(color: CommonColors.mWhite, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Text(
                  "24% off",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold, height: 1, fontSize: 12),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
