import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:solikat_2024/view/home/sub_brand/sub_brand_view.dart';
import 'package:solikat_2024/view/home/sub_category/sub_category_view.dart';
import 'package:solikat_2024/view/home/sub_offer/sub_offer_view.dart';
import 'package:solikat_2024/view/home/view_all_products/view_all_products_view.dart';
import 'package:solikat_2024/widget/common_product_container_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/home_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';

class Section1 extends StatefulWidget {
  final List<Section1Data> section1;

  const Section1({super.key, required this.section1});

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          itemCount: widget.section1.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return GestureDetector(
              onTap: () {
                if (widget.section1[itemIndex].url.isNotEmpty) {
                  _launchURL(widget.section1[itemIndex].url);
                } else {
                  push(
                    SubCategoryView(
                      categoryId: widget.section1[itemIndex].categoryId,
                      title: 'Products',
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: kDeviceWidth,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  // image: DecorationImage(
                  //   image: NetworkImage(widget.section1[itemIndex].image),
                  //   fit: BoxFit.fill,
                  // ),
                ),
                child: FancyShimmerImage(
                  shimmerBaseColor: Colors.white30,
                  imageUrl: widget.section1[itemIndex].image,
                  boxFit: BoxFit.fill,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: false,
            viewportFraction: 1.0,
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  final List<Section2Data> section2;
  final String section2Title;

  const Section2(
      {super.key, required this.section2, required this.section2Title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section2Title.isNotEmpty) ...[
            Text(
              section2Title,
              style: getAppStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, height: 1.2),
            ),
            kCommonSpaceV15,
          ],
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 1.3,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section2.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  push(
                    SubCategoryView(
                      categoryId: section2[index].categoryId,
                      title: section2[index].title,
                    ),
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    // color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FancyShimmerImage(
                          shimmerBaseColor: Colors.white30,
                          imageUrl: section2[index].image,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      // Expanded(
                      //   child: Image.network(
                      //     width: double.infinity,
                      //     section2[index].image,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      kCommonSpaceV5,
                      Text(
                        section2[index].title,
                        style: getAppStyle(
                            fontSize: 16,
                            color: const Color(0xff45461b),
                            fontWeight: FontWeight.w500),
                      ),
                      kCommonSpaceV3,
                    ],
                  ),
                ),
              );
            },
          ),
          kCommonSpaceV15,
        ],
      ),
    );
  }
}

class Section3 extends StatelessWidget {
  final List<Section3Data> section3;
  final String section3Title;

  const Section3({
    super.key,
    required this.section3,
    required this.section3Title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section3Title.isNotEmpty) ...[
            Text(
              section3Title,
              style: getAppStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.2,
                  color: Colors.black54),
            ),
            kCommonSpaceV15,
          ],
          GridView.builder(
            cacheExtent: 9999.0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section3.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("Category id...... ${section3[index].categoryId}");
                  push(
                    SubCategoryView(
                      categoryId: section3[index].categoryId.toString(),
                      title: section3[index].title,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.orange.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle),
                        child: FancyShimmerImage(
                          shimmerBaseColor: Colors.white30,
                          imageUrl: section3[index].image,
                          boxFit: BoxFit.fill,
                        ),
                        // Container(
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: NetworkImage(section3[index].image),
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      flex: 2,
                      child: Text(
                        section3[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getAppStyle(
                            fontWeight: FontWeight.w500,
                            height: 1,
                            color: Colors.black87.withOpacity(0.6),
                            fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          kCommonSpaceV15,
        ],
      ),
    );
  }
}

class Section4 extends StatefulWidget {
  final List<Section4Data> section4;
  final String section4Title;
  final Function onAddItem;
  final Function onRemoveItem;
  final Function? onTapProDetails;

  const Section4({
    super.key,
    required this.section4,
    required this.section4Title,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onTapProDetails,
  });

  @override
  State<Section4> createState() => _Section4State();
}

class _Section4State extends State<Section4> {
  void incrementItem(int index) {
    if (widget.section4[index].cartCount < widget.section4[index].stock) {
      setState(() {
        widget.section4[index].cartCount++;
      });
      widget.onAddItem(widget.section4[index].variantId);
    } else if (widget.section4[index].stock != 0) {
      print(
          ".......Sorry this product have only ${widget.section4[index].stock} in a stock......");
      String msg =
          "Only ${widget.section4[index].stock} product available in stock";

      // CommonUtils.showRedToastMessage(msg);
      CommonUtils.showCustomToast(context, msg);
    } else if (widget.section4[index].stock == 0) {
      print(".......Sorry this item is sold out......");
      String msg = "Sorry this item is sold out";
      // CommonUtils.showRedToastMessage(msg);
      CommonUtils.showCustomToast(context, msg);
    }
  }

  void decrementItem(int index) {
    if (widget.section4[index].cartCount > 0) {
      setState(() {
        widget.section4[index].cartCount--;
      });
      widget.onRemoveItem(widget.section4[index].variantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.section4Title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.section4Title,
                  style: getAppStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.2,
                      color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    /// Important note :: in this only for section 4 in isDeal parameter get category id and that category id
                    /// used for get view all products.
                    push(
                      SubCategoryView(
                        categoryId: widget.section4[0].isDeal.toString(),
                        title: widget.section4Title,
                      ),
                    );
                  },
                  child: Text(
                    "View All >",
                    style: getAppStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.2,
                        color: CommonColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          kCommonSpaceV15,
        ],
        SizedBox(
          height: kDeviceHeight / 3.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.section4.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 10),
            itemBuilder: (context, index) {
              return FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ProductContainer(
                    onTapProduct: () {
                      if (widget.onTapProDetails != null) {
                        widget
                            .onTapProDetails!(widget.section4[index].variantId);
                      }
                    },
                    imgUrl: widget.section4[index].image,
                    productName: widget.section4[index].productName,
                    onIncrement: () => incrementItem(index),
                    onDecrement: () => decrementItem(index),
                    stock: widget.section4[index].stock,
                    variantName: widget.section4[index].variantName,
                    discountPrice: widget.section4[index].discountPrice,
                    productPrice: widget.section4[index].productPrice,
                    discountPer: widget.section4[index].discountPer,
                    cartCount: widget.section4[index].cartCount,
                    productId: widget.section4[index].productId.toString(),
                    variantId: widget.section4[index].variantId.toString(),
                  ),
                ),
              );
            },
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section5 extends StatelessWidget {
  final List<Section5Data> section5;

  const Section5({super.key, required this.section5});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                push(
                  SubCategoryView(
                    categoryId: section5.first.categoryId,
                    title: 'Product',
                  ),
                );
              },
              child: Image.network(section5.first.image)),
          kCommonSpaceV15,
        ],
      ),
    );
  }
}

class Section6 extends StatelessWidget {
  final List<Section6Data> section6;

  const Section6({
    super.key,
    required this.section6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(section6.first.setting.backgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GridView.builder(
                    cacheExtent: 9999,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: section6.first.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FittedBox(
                        child: GestureDetector(
                          onTap: () {
                            push(
                              SubCategoryView(
                                categoryId: section6
                                    .first.categories[index].categoryId
                                    .toString(),
                                title: section6.first.categories[index].title,
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FancyShimmerImage(
                                    shimmerBaseColor: Colors.white30,
                                    imageUrl:
                                        section6.first.categories[index].image,
                                    boxFit: BoxFit.fill,
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(section6
                                  //           .first.categories[index].image),
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  child: Text(
                                    section6.first.categories[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getAppStyle(
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        color: Color(int.parse(
                                            section6.first.setting.textColor)),
                                        fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section7 extends StatelessWidget {
  final List<Section7Data> section7;
  final String section7Title;

  const Section7(
      {super.key, required this.section7, required this.section7Title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section7Title.isNotEmpty) ...[
          Image.asset(LocalImages.img_brand_spotlight),
          kCommonSpaceV20,
        ],
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 1.1,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: section7.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("Brand id...... ${section7[index].brandId}");
                  push(
                    SubBrandView(
                      brandId: section7[index].brandId,
                      title: section7[index].title,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.pinkAccent,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Color(0xffffdbdd),
                    //     Color(0xffffdbdd),
                    //     Color(0xffffbfc0)
                    //   ],
                    // ),
                    image: DecorationImage(
                        image: NetworkImage(section7[index].image),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              );
            },
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section8 extends StatelessWidget {
  final List<Section8Data> section8;
  final String section8Title;

  const Section8(
      {super.key, required this.section8, required this.section8Title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section8Title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              section8Title,
              style: getAppStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.2,
                  color: Colors.black54),
            ),
          ),
          kCommonSpaceV15,
        ],
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: FittedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Category id...... ${section8[0].offerId}");
                    push(SubOfferView(
                      offerId: section8[0].offerId,
                      title: section8Title,
                    ));
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(section8[0].image),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                kCommonSpaceH10,
                GestureDetector(
                  onTap: () {
                    print("Category id...... ${section8[1].offerId}");
                    push(SubOfferView(
                      offerId: section8[1].offerId,
                      title: section8Title,
                    ));
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(section8[1].image),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                kCommonSpaceH10,
                GestureDetector(
                  onTap: () {
                    print("Category id...... ${section8[2].offerId}");
                    push(SubOfferView(
                      offerId: section8[2].offerId,
                      title: section8Title,
                    ));
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(section8[2].image),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section9 extends StatefulWidget {
  final List<Section9Data> section9;
  final String section4Title;
  final Function onAddItem;
  final Function onRemoveItem;
  final Function? onTapProDetails;

  const Section9({
    super.key,
    required this.section9,
    required this.section4Title,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onTapProDetails,
  });

  @override
  State<Section9> createState() => _Section9State();
}

class _Section9State extends State<Section9> {
  void incrementItem(int sectionIndex, int productIndex) {
    if (widget.section9[sectionIndex].products[productIndex].cartCount <
        widget.section9[sectionIndex].products[productIndex].stock) {
      setState(() {
        widget.section9[sectionIndex].products[productIndex].cartCount++;
      });
      widget.onAddItem(
          widget.section9[sectionIndex].products[productIndex].variantId);
    } else {
      print(
          ".......Sorry this product have only ${widget.section9[sectionIndex].products[productIndex].stock} in stock......");
      String msg =
          "Only ${widget.section9[sectionIndex].products[productIndex].stock} product available in stock";
      CommonUtils.showCustomToast(context, msg);
    }
  }

  void decrementItem(int sectionIndex, int productIndex) {
    if (widget.section9[sectionIndex].products[productIndex].cartCount > 0) {
      setState(() {
        widget.section9[sectionIndex].products[productIndex].cartCount--;
      });
      widget.onRemoveItem(
          widget.section9[sectionIndex].products[productIndex].variantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 420,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.section9[0].setting.backgroundImage),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              SizedBox(
                height: kDeviceHeight / 3.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.section9.first.products.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 10),
                    itemBuilder: (context, index) {
                      var product = widget.section9.first.products[index];
                      return FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ProductContainer(
                            onTapProduct: () {
                              if (widget.onTapProDetails != null) {
                                widget.onTapProDetails!(product.variantId);
                              }
                            },
                            imgUrl: product.image,
                            productName: product.productName,
                            onIncrement: () => incrementItem(0, index),
                            onDecrement: () => decrementItem(0, index),
                            stock: product.stock,
                            variantName: product.variantName,
                            discountPrice: product.discountPrice,
                            productPrice: product.productPrice,
                            discountPer: product.discountPer,
                            cartCount: product.cartCount,
                            productId: product.productId.toString(),
                            variantId: product.variantId.toString(),
                          ),
                        ),
                      );
                    }),
              ),
              kCommonSpaceV15,
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            push(
                ViewAllProductsView(id: widget.section9[0].setting.categoryId));
          },
          child: Container(
            color: Color(int.parse(widget.section9[0].setting.buttonColor)),
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "View All",
                    style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: CommonColors.mWhite,
                  ),
                ],
              ),
            ),
          ),
        ),
        kCommonSpaceV15,
      ],
    );
  }
}

class Section10 extends StatelessWidget {
  final String title;

  const Section10({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return title.isNotEmpty
        ? FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                title,
                maxLines: 1,
                style: getAppStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
