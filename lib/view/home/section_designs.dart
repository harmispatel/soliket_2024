import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:solikat_2024/view/home/sub_category/sub_category_view.dart';
import 'package:solikat_2024/widget/common_product_container_view.dart';

import '../../models/home_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/local_images.dart';

class Section1 extends StatelessWidget {
  final List<Section1Data> section1;

  const Section1({super.key, required this.section1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          itemCount: section1.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(section1[itemIndex].image),
                  fit: BoxFit.fill,
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
                  fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
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
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Image.network(
                        width: double.infinity,
                        section2[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    kCommonSpaceV5,
                    Text(
                      section2[index].title,
                      style: getAppStyle(
                          fontSize: 18,
                          color: const Color(0xff45461b),
                          fontWeight: FontWeight.w500),
                    ),
                    kCommonSpaceV3,
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
                  fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
            ),
            kCommonSpaceV15,
          ],
          GridView.builder(
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
                // onTap: () {
                //   showModalBottomSheet(
                //     context: context,
                //     isScrollControlled: true,
                //     useSafeArea: true,
                //     backgroundColor: Colors.white,
                //     builder: (_) {
                //       return FractionallySizedBox(
                //         heightFactor: 0.77,
                //         child: StatefulBuilder(
                //           builder: (BuildContext context,
                //               StateSetter setState) {
                //             return Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 20) +
                //                   const EdgeInsets.only(top: 10),
                //               child: Column(
                //                 children: [
                //                   Padding(
                //                     padding:
                //                     const EdgeInsets.only(
                //                         left: 12,
                //                         right: 12,
                //                         top: 12),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                       MainAxisAlignment
                //                           .spaceBetween,
                //                       children: [
                //                         Column(
                //                           crossAxisAlignment:
                //                           CrossAxisAlignment
                //                               .start,
                //                           children: [
                //                             Text(
                //                               'Review Cart',
                //                               style: getAppStyle(
                //                                   fontWeight:
                //                                   FontWeight
                //                                       .bold,
                //                                   fontSize: 18),
                //                             ),
                //                             Row(
                //                               children: [
                //                                 Text(
                //                                   "3 Items • Total",
                //                                   style: getAppStyle(
                //                                       color: CommonColors
                //                                           .black54),
                //                                 ),
                //                                 Text(
                //                                   " ₹542",
                //                                   style: getAppStyle(
                //                                       fontWeight:
                //                                       FontWeight
                //                                           .bold),
                //                                 ),
                //                               ],
                //                             )
                //                           ],
                //                         ),
                //                         InkWell(
                //                           onTap: () {
                //                             Navigator.pop(
                //                                 context);
                //                           },
                //                           child: Container(
                //                             decoration:
                //                             BoxDecoration(
                //                               shape:
                //                               BoxShape.circle,
                //                               boxShadow: [
                //                                 BoxShadow(
                //                                   color:
                //                                   Colors.grey,
                //                                   offset:
                //                                   const Offset(
                //                                     2.0,
                //                                     2.0,
                //                                   ),
                //                                   blurRadius: 5.0,
                //                                   spreadRadius:
                //                                   0.0,
                //                                 ), //BoxShadow
                //                                 BoxShadow(
                //                                   color: Colors
                //                                       .white,
                //                                   offset:
                //                                   const Offset(
                //                                       0.0,
                //                                       0.0),
                //                                   blurRadius: 0.0,
                //                                   spreadRadius:
                //                                   0.0,
                //                                 ), //BoxShadow
                //                               ],
                //                             ),
                //                             child: Padding(
                //                               padding:
                //                               const EdgeInsets
                //                                   .all(8.0),
                //                               child: Icon(
                //                                 Icons.close,
                //                                 size: 15,
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   kCommonSpaceV10,
                //                   kCommonSpaceV3,
                //                   Container(
                //                     height: 3,
                //                     color: CommonColors.mGrey300,
                //                   ),
                //                   Expanded(
                //                     child: ListView.builder(
                //                       padding:
                //                       const EdgeInsets.only(
                //                           top: 12),
                //                       physics:
                //                       const ClampingScrollPhysics(),
                //                       shrinkWrap: true,
                //                       scrollDirection:
                //                       Axis.vertical,
                //                       itemCount: 5,
                //                       itemBuilder:
                //                           (BuildContext context,
                //                           int index) {
                //                         return Column(
                //                           children: [
                //                             Row(
                //                               crossAxisAlignment:
                //                               CrossAxisAlignment
                //                                   .start,
                //                               children: [
                //                                 CachedNetworkImage(
                //                                   height: 80,
                //                                   width: 80,
                //                                   imageUrl:
                //                                   "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                   imageBuilder:
                //                                       (context,
                //                                       imageProvider) =>
                //                                       Container(
                //                                         decoration:
                //                                         BoxDecoration(
                //                                           image:
                //                                           DecorationImage(
                //                                             image:
                //                                             imageProvider,
                //                                             fit: BoxFit
                //                                                 .contain,
                //                                           ),
                //                                         ),
                //                                       ),
                //                                   placeholder: (context,
                //                                       url) =>
                //                                   const Padding(
                //                                     padding:
                //                                     EdgeInsets
                //                                         .all(
                //                                         12.0),
                //                                     child: Center(
                //                                       child:
                //                                       CircularProgressIndicator(
                //                                         strokeWidth:
                //                                         2,
                //                                         color: Colors
                //                                             .black,
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   errorWidget: (context,
                //                                       url,
                //                                       error) =>
                //                                   const Center(
                //                                     child: Icon(
                //                                       Icons
                //                                           .error_outline,
                //                                       color: Colors
                //                                           .red,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 const SizedBox(
                //                                     width: 14),
                //                                 Expanded(
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                     CrossAxisAlignment
                //                                         .start,
                //                                     mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .start,
                //                                     children: [
                //                                       Text(
                //                                         "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                //                                         maxLines:
                //                                         2,
                //                                         overflow:
                //                                         TextOverflow
                //                                             .ellipsis,
                //                                         style:
                //                                         getAppStyle(
                //                                           color: Colors
                //                                               .black,
                //                                           fontWeight:
                //                                           FontWeight.w600,
                //                                           fontSize:
                //                                           13,
                //                                         ),
                //                                       ),
                //                                       Padding(
                //                                         padding: const EdgeInsets
                //                                             .symmetric(
                //                                             vertical:
                //                                             02),
                //                                         child:
                //                                         Text(
                //                                           "250 g",
                //                                           style:
                //                                           getAppStyle(
                //                                             color:
                //                                             Colors.grey,
                //                                             fontWeight:
                //                                             FontWeight.w500,
                //                                             fontSize:
                //                                             12,
                //                                           ),
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ),
                //                                 const SizedBox(
                //                                     width: 8),
                //                                 Column(
                //                                   crossAxisAlignment:
                //                                   CrossAxisAlignment
                //                                       .start,
                //                                   mainAxisAlignment:
                //                                   MainAxisAlignment
                //                                       .start,
                //                                   children: [
                //                                     Container(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal:
                //                                           4,
                //                                           vertical:
                //                                           4),
                //                                       margin: const EdgeInsets
                //                                           .only(
                //                                           bottom:
                //                                           4),
                //                                       height: 30,
                //                                       width: 80,
                //                                       decoration:
                //                                       BoxDecoration(
                //                                         borderRadius:
                //                                         BorderRadius.circular(
                //                                             6),
                //                                         color: CommonColors
                //                                             .primaryColor,
                //                                       ),
                //                                       child: Row(
                //                                         mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceAround,
                //                                         children: [
                //                                           GestureDetector(
                //                                             onTap: () =>
                //                                                 decrementItem(),
                //                                             child:
                //                                             const Icon(
                //                                               Icons.remove,
                //                                               size:
                //                                               16,
                //                                               color:
                //                                               Colors.white,
                //                                             ),
                //                                           ),
                //                                           Text(
                //                                             itemCount
                //                                                 .toString(),
                //                                             style:
                //                                             getAppStyle(
                //                                               color:
                //                                               Colors.white,
                //                                               fontWeight:
                //                                               FontWeight.w500,
                //                                               fontSize:
                //                                               14,
                //                                             ),
                //                                           ),
                //                                           GestureDetector(
                //                                             onTap: () =>
                //                                                 incrementItem(),
                //                                             child:
                //                                             const Icon(
                //                                               Icons.add,
                //                                               size:
                //                                               16,
                //                                               color:
                //                                               Colors.white,
                //                                             ),
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                     Row(
                //                                       children: [
                //                                         Text(
                //                                           "₹${"80.0"}",
                //                                           style:
                //                                           getAppStyle(
                //                                             decoration:
                //                                             TextDecoration.lineThrough,
                //                                             color:
                //                                             Colors.grey,
                //                                             fontWeight:
                //                                             FontWeight.w500,
                //                                             fontSize:
                //                                             12,
                //                                           ),
                //                                         ),
                //                                         const SizedBox(
                //                                             width:
                //                                             4),
                //                                         Text(
                //                                           "₹${"250.0"}",
                //                                           style:
                //                                           getAppStyle(
                //                                             color:
                //                                             Colors.black,
                //                                             fontWeight:
                //                                             FontWeight.bold,
                //                                             fontSize:
                //                                             13,
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                             const SizedBox(
                //                                 height: 10)
                //                           ],
                //                         );
                //                       },
                //                     ),
                //                   ),
                //                   Row(
                //                     children: [
                //                       Container(
                //                         height: 48,
                //                         width: 60,
                //                         margin:
                //                         const EdgeInsets.only(
                //                             right: 6),
                //                         color: Colors.transparent,
                //                         child: Stack(
                //                           children: List.generate(
                //                             3,
                //                                 (index) => Positioned(
                //                               left: index * 6,
                //                               child: Container(
                //                                 height: 48,
                //                                 width: 48,
                //                                 padding:
                //                                 const EdgeInsets
                //                                     .symmetric(
                //                                     horizontal:
                //                                     6,
                //                                     vertical:
                //                                     2),
                //                                 decoration:
                //                                 BoxDecoration(
                //                                   color: Colors
                //                                       .white,
                //                                   border: Border.all(
                //                                       color: CommonColors
                //                                           .mGrey500),
                //                                   borderRadius:
                //                                   BorderRadius
                //                                       .circular(
                //                                       8),
                //                                 ),
                //                                 child:
                //                                 CachedNetworkImage(
                //                                   imageUrl:
                //                                   "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                   fit: BoxFit
                //                                       .cover,
                //                                   placeholder: (context, url) => const Center(
                //                                       child: SizedBox(
                //                                           height:
                //                                           10,
                //                                           width:
                //                                           10,
                //                                           child:
                //                                           CircularProgressIndicator())),
                //                                   errorWidget: (context,
                //                                       url,
                //                                       error) =>
                //                                   const Icon(
                //                                       Icons
                //                                           .error_outline,
                //                                       color: Colors
                //                                           .red),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "${itemCount - 1} Items",
                //                             style: getAppStyle(
                //                               color: CommonColors
                //                                   .blackColor,
                //                               fontWeight:
                //                               FontWeight.w500,
                //                               fontSize: 12,
                //                             ),
                //                           ),
                //                           const Icon(
                //                             Icons
                //                                 .arrow_drop_up_rounded,
                //                             color: CommonColors
                //                                 .primaryColor,
                //                             size: 30,
                //                           )
                //                         ],
                //                       ),
                //                       const SizedBox(width: 36),
                //                       Expanded(
                //                         child: PrimaryButton(
                //                           height: 55,
                //                           label: "View Cart",
                //                           buttonColor:
                //                           CommonColors
                //                               .primaryColor,
                //                           labelColor:
                //                           Colors.white,
                //                           borderRadius:
                //                           BorderRadius
                //                               .circular(14),
                //                           onPress: () {
                //                             showModalBottomSheet(
                //                               context: context,
                //                               isScrollControlled:
                //                               true,
                //                               useSafeArea: true,
                //                               backgroundColor:
                //                               Colors.white,
                //                               builder: (_) {
                //                                 return FractionallySizedBox(
                //                                   heightFactor:
                //                                   0.77,
                //                                   child:
                //                                   StatefulBuilder(
                //                                     builder: (BuildContext
                //                                     context,
                //                                         StateSetter
                //                                         setState) {
                //                                       return Padding(
                //                                         padding: const EdgeInsets
                //                                             .symmetric(
                //                                             horizontal:
                //                                             20) +
                //                                             const EdgeInsets
                //                                                 .only(
                //                                                 top: 10),
                //                                         child:
                //                                         Column(
                //                                           children: [
                //                                             Padding(
                //                                               padding: const EdgeInsets.only(
                //                                                   left: 12,
                //                                                   right: 12,
                //                                                   top: 12),
                //                                               child:
                //                                               Row(
                //                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                                 children: [
                //                                                   Column(
                //                                                     crossAxisAlignment: CrossAxisAlignment.start,
                //                                                     children: [
                //                                                       Text(
                //                                                         'Review Cart',
                //                                                         style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //                                                       ),
                //                                                       Row(
                //                                                         children: [
                //                                                           Text(
                //                                                             "3 Items • Total",
                //                                                             style: getAppStyle(color: CommonColors.black54),
                //                                                           ),
                //                                                           Text(
                //                                                             " ₹542",
                //                                                             style: getAppStyle(fontWeight: FontWeight.bold),
                //                                                           ),
                //                                                         ],
                //                                                       )
                //                                                     ],
                //                                                   ),
                //                                                   InkWell(
                //                                                     onTap: () {
                //                                                       Navigator.pop(context);
                //                                                     },
                //                                                     child: Container(
                //                                                       decoration: BoxDecoration(
                //                                                         shape: BoxShape.circle,
                //                                                         boxShadow: [
                //                                                           BoxShadow(
                //                                                             color: Colors.grey,
                //                                                             offset: const Offset(
                //                                                               2.0,
                //                                                               2.0,
                //                                                             ),
                //                                                             blurRadius: 5.0,
                //                                                             spreadRadius: 0.0,
                //                                                           ),
                //                                                           //BoxShadow
                //                                                           BoxShadow(
                //                                                             color: Colors.white,
                //                                                             offset: const Offset(0.0, 0.0),
                //                                                             blurRadius: 0.0,
                //                                                             spreadRadius: 0.0,
                //                                                           ),
                //                                                           //BoxShadow
                //                                                         ],
                //                                                       ),
                //                                                       child: Padding(
                //                                                         padding: const EdgeInsets.all(8.0),
                //                                                         child: Icon(
                //                                                           Icons.close,
                //                                                           size: 15,
                //                                                         ),
                //                                                       ),
                //                                                     ),
                //                                                   ),
                //                                                 ],
                //                                               ),
                //                                             ),
                //                                             kCommonSpaceV10,
                //                                             kCommonSpaceV3,
                //                                             Container(
                //                                               height:
                //                                               3,
                //                                               color:
                //                                               CommonColors.mGrey300,
                //                                             ),
                //                                             Container(
                //                                               height:
                //                                               MediaQuery.of(context).size.height / 1.88,
                //                                               padding:
                //                                               const EdgeInsets.symmetric(horizontal: 12),
                //                                               margin:
                //                                               const EdgeInsets.only(top: 12),
                //                                               decoration:
                //                                               BoxDecoration(
                //                                                 border: Border.all(color: CommonColors.mGrey300),
                //                                                 borderRadius: BorderRadius.circular(12),
                //                                               ),
                //                                               child:
                //                                               SingleChildScrollView(
                //                                                 child: Column(
                //                                                   children: [
                //                                                     Padding(
                //                                                       padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                //                                                       child: Column(
                //                                                         crossAxisAlignment: CrossAxisAlignment.start,
                //                                                         children: [
                //                                                           Row(
                //                                                             children: [
                //                                                               Text(
                //                                                                 'Delivery in',
                //                                                                 style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //                                                               ),
                //                                                               const Icon(
                //                                                                 Icons.electric_bolt_rounded,
                //                                                                 color: CommonColors.primaryColor,
                //                                                               ),
                //                                                               Text(
                //                                                                 '11 Min',
                //                                                                 style: getAppStyle(color: CommonColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
                //                                                               ),
                //                                                             ],
                //                                                           ),
                //                                                           Row(
                //                                                             children: [
                //                                                               Text(
                //                                                                 "From ",
                //                                                                 style: getAppStyle(color: CommonColors.black54),
                //                                                               ),
                //                                                               Text(
                //                                                                 "Soliket",
                //                                                                 style: getAppStyle(fontWeight: FontWeight.bold, color: CommonColors.blackColor),
                //                                                               ),
                //                                                               Text(
                //                                                                 " • ",
                //                                                                 style: getAppStyle(color: CommonColors.blackColor),
                //                                                               ),
                //                                                               Text(
                //                                                                 " 6 Items",
                //                                                                 style: getAppStyle(color: CommonColors.black54, fontWeight: FontWeight.bold),
                //                                                               ),
                //                                                               Text(
                //                                                                 " • ",
                //                                                                 style: getAppStyle(color: CommonColors.blackColor),
                //                                                               ),
                //                                                               Text(
                //                                                                 "Delivery 1",
                //                                                                 style: getAppStyle(color: CommonColors.black54, fontWeight: FontWeight.bold),
                //                                                               ),
                //                                                             ],
                //                                                           )
                //                                                         ],
                //                                                       ),
                //                                                     ),
                //                                                     ListView.builder(
                //                                                       padding: const EdgeInsets.only(top: 12),
                //                                                       physics: const ClampingScrollPhysics(),
                //                                                       shrinkWrap: true,
                //                                                       scrollDirection: Axis.vertical,
                //                                                       itemCount: 15,
                //                                                       itemBuilder: (BuildContext context, int index) {
                //                                                         return Column(
                //                                                           children: [
                //                                                             Row(
                //                                                               crossAxisAlignment: CrossAxisAlignment.start,
                //                                                               children: [
                //                                                                 CachedNetworkImage(
                //                                                                   height: 80,
                //                                                                   width: 80,
                //                                                                   imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                                                   imageBuilder: (context, imageProvider) => Container(
                //                                                                     decoration: BoxDecoration(
                //                                                                       image: DecorationImage(
                //                                                                         image: imageProvider,
                //                                                                         fit: BoxFit.contain,
                //                                                                       ),
                //                                                                     ),
                //                                                                   ),
                //                                                                   placeholder: (context, url) => const Padding(
                //                                                                     padding: EdgeInsets.all(12.0),
                //                                                                     child: Center(
                //                                                                       child: CircularProgressIndicator(
                //                                                                         strokeWidth: 2,
                //                                                                         color: Colors.black,
                //                                                                       ),
                //                                                                     ),
                //                                                                   ),
                //                                                                   errorWidget: (context, url, error) => const Center(
                //                                                                     child: Icon(
                //                                                                       Icons.error_outline,
                //                                                                       color: Colors.red,
                //                                                                     ),
                //                                                                   ),
                //                                                                 ),
                //                                                                 const SizedBox(width: 14),
                //                                                                 Expanded(
                //                                                                   child: Column(
                //                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                     mainAxisAlignment: MainAxisAlignment.start,
                //                                                                     children: [
                //                                                                       Text(
                //                                                                         "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                //                                                                         maxLines: 2,
                //                                                                         overflow: TextOverflow.ellipsis,
                //                                                                         style: getAppStyle(
                //                                                                           color: Colors.black,
                //                                                                           fontWeight: FontWeight.w600,
                //                                                                           fontSize: 13,
                //                                                                         ),
                //                                                                       ),
                //                                                                       Padding(
                //                                                                         padding: const EdgeInsets.symmetric(vertical: 02),
                //                                                                         child: Row(
                //                                                                           children: [
                //                                                                             Text(
                //                                                                               "250 g",
                //                                                                               style: getAppStyle(
                //                                                                                 color: Colors.grey,
                //                                                                                 fontWeight: FontWeight.w500,
                //                                                                                 fontSize: 12,
                //                                                                               ),
                //                                                                             ),
                //                                                                             Container(
                //                                                                               margin: const EdgeInsets.only(left: 8),
                //                                                                               padding: const EdgeInsets.only(left: 6, right: 8, top: 2, bottom: 2),
                //                                                                               decoration: BoxDecoration(
                //                                                                                 borderRadius: BorderRadius.circular(2),
                //                                                                                 color: CommonColors.primaryColor.withOpacity(0.1),
                //                                                                               ),
                //                                                                               child: Row(
                //                                                                                 children: [
                //                                                                                   const Icon(
                //                                                                                     Icons.percent_rounded,
                //                                                                                     color: CommonColors.primaryColor,
                //                                                                                     size: 14,
                //                                                                                   ),
                //                                                                                   Text(
                //                                                                                     "Deal Applied",
                //                                                                                     style: getAppStyle(
                //                                                                                       color: CommonColors.primaryColor,
                //                                                                                       fontWeight: FontWeight.w500,
                //                                                                                       fontSize: 10,
                //                                                                                     ),
                //                                                                                   )
                //                                                                                 ],
                //                                                                               ),
                //                                                                             )
                //                                                                           ],
                //                                                                         ),
                //                                                                       ),
                //                                                                     ],
                //                                                                   ),
                //                                                                 ),
                //                                                                 const SizedBox(width: 8),
                //                                                                 Column(
                //                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                   mainAxisAlignment: MainAxisAlignment.start,
                //                                                                   children: [
                //                                                                     Container(
                //                                                                       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                //                                                                       margin: const EdgeInsets.only(bottom: 4),
                //                                                                       height: 30,
                //                                                                       width: 80,
                //                                                                       decoration: BoxDecoration(
                //                                                                         borderRadius: BorderRadius.circular(6),
                //                                                                         color: CommonColors.primaryColor,
                //                                                                       ),
                //                                                                       child: Row(
                //                                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                                                                         children: [
                //                                                                           GestureDetector(
                //                                                                             onTap: () => decrementItem(),
                //                                                                             child: const Icon(
                //                                                                               Icons.remove,
                //                                                                               size: 16,
                //                                                                               color: Colors.white,
                //                                                                             ),
                //                                                                           ),
                //                                                                           Text(
                //                                                                             itemCount.toString(),
                //                                                                             style: getAppStyle(
                //                                                                               color: Colors.white,
                //                                                                               fontWeight: FontWeight.w500,
                //                                                                               fontSize: 14,
                //                                                                             ),
                //                                                                           ),
                //                                                                           GestureDetector(
                //                                                                             onTap: () => incrementItem(),
                //                                                                             child: const Icon(
                //                                                                               Icons.add,
                //                                                                               size: 16,
                //                                                                               color: Colors.white,
                //                                                                             ),
                //                                                                           ),
                //                                                                         ],
                //                                                                       ),
                //                                                                     ),
                //                                                                     Row(
                //                                                                       children: [
                //                                                                         Text(
                //                                                                           "₹${"80.0"}",
                //                                                                           style: getAppStyle(
                //                                                                             decoration: TextDecoration.lineThrough,
                //                                                                             color: Colors.grey,
                //                                                                             fontWeight: FontWeight.w500,
                //                                                                             fontSize: 12,
                //                                                                           ),
                //                                                                         ),
                //                                                                         const SizedBox(width: 4),
                //                                                                         Text(
                //                                                                           "₹${"250.0"}",
                //                                                                           style: getAppStyle(
                //                                                                             color: Colors.black,
                //                                                                             fontWeight: FontWeight.bold,
                //                                                                             fontSize: 13,
                //                                                                           ),
                //                                                                         ),
                //                                                                       ],
                //                                                                     ),
                //                                                                   ],
                //                                                                 ),
                //                                                               ],
                //                                                             ),
                //                                                             const SizedBox(height: 10)
                //                                                           ],
                //                                                         );
                //                                                       },
                //                                                     ),
                //                                                   ],
                //                                                 ),
                //                                               ),
                //                                             ),
                //                                             const Spacer(),
                //                                             Padding(
                //                                               padding:
                //                                               const EdgeInsets.only(bottom: 20),
                //                                               child:
                //                                               Row(
                //                                                 children: [
                //                                                   Container(
                //                                                     height: 48,
                //                                                     width: 60,
                //                                                     margin: const EdgeInsets.only(right: 6),
                //                                                     color: Colors.transparent,
                //                                                     child: Stack(
                //                                                       children: List.generate(
                //                                                         itemCount - 1 > 3 ? 3 : itemCount - 1,
                //                                                             (index) => Positioned(
                //                                                           left: index * 6,
                //                                                           child: Container(
                //                                                             height: 48,
                //                                                             width: 48,
                //                                                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                //                                                             decoration: BoxDecoration(
                //                                                               color: Colors.white,
                //                                                               border: Border.all(color: CommonColors.mGrey500),
                //                                                               borderRadius: BorderRadius.circular(8),
                //                                                             ),
                //                                                             child: CachedNetworkImage(
                //                                                               imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                                               fit: BoxFit.cover,
                //                                                               placeholder: (context, url) => const Center(child: SizedBox(height: 10, width: 10, child: CircularProgressIndicator())),
                //                                                               errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                //                                                             ),
                //                                                           ),
                //                                                         ),
                //                                                       ),
                //                                                     ),
                //                                                   ),
                //                                                   Row(
                //                                                     children: [
                //                                                       Text(
                //                                                         "${itemCount - 1} Items",
                //                                                         style: getAppStyle(
                //                                                           color: CommonColors.blackColor,
                //                                                           fontWeight: FontWeight.w500,
                //                                                           fontSize: 12,
                //                                                         ),
                //                                                       ),
                //                                                       const Icon(
                //                                                         Icons.arrow_drop_up_rounded,
                //                                                         color: CommonColors.primaryColor,
                //                                                         size: 30,
                //                                                       )
                //                                                     ],
                //                                                   ),
                //                                                   const SizedBox(width: 36),
                //                                                   Expanded(
                //                                                     child: PrimaryButton(
                //                                                       height: 55,
                //                                                       label: "View Cart",
                //                                                       buttonColor: CommonColors.primaryColor,
                //                                                       labelColor: Colors.white,
                //                                                       borderRadius: BorderRadius.circular(14),
                //                                                       onPress: () {
                //                                                         showModalBottomSheet(
                //                                                           context: context,
                //                                                           isScrollControlled: true,
                //                                                           useSafeArea: true,
                //                                                           backgroundColor: Colors.white,
                //                                                           builder: (_) {
                //                                                             return FractionallySizedBox(
                //                                                               heightFactor: 0.77,
                //                                                               child: StatefulBuilder(
                //                                                                 builder: (BuildContext context, StateSetter setState) {
                //                                                                   return Padding(
                //                                                                     padding: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 10),
                //                                                                     child: Column(
                //                                                                       children: [
                //                                                                         Padding(
                //                                                                           padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                //                                                                           child: Row(
                //                                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                                                             children: [
                //                                                                               Column(
                //                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                                 children: [
                //                                                                                   Text(
                //                                                                                     'Review Cart',
                //                                                                                     style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //                                                                                   ),
                //                                                                                   Row(
                //                                                                                     children: [
                //                                                                                       Text(
                //                                                                                         "3 Items • Total",
                //                                                                                         style: getAppStyle(color: CommonColors.black54),
                //                                                                                       ),
                //                                                                                       Text(
                //                                                                                         " ₹542",
                //                                                                                         style: getAppStyle(fontWeight: FontWeight.bold),
                //                                                                                       ),
                //                                                                                     ],
                //                                                                                   )
                //                                                                                 ],
                //                                                                               ),
                //                                                                               InkWell(
                //                                                                                 onTap: () {
                //                                                                                   Navigator.pop(context);
                //                                                                                 },
                //                                                                                 child: Container(
                //                                                                                   decoration: BoxDecoration(
                //                                                                                     shape: BoxShape.circle,
                //                                                                                     boxShadow: [
                //                                                                                       BoxShadow(
                //                                                                                         color: Colors.grey,
                //                                                                                         offset: const Offset(
                //                                                                                           2.0,
                //                                                                                           2.0,
                //                                                                                         ),
                //                                                                                         blurRadius: 5.0,
                //                                                                                         spreadRadius: 0.0,
                //                                                                                       ),
                //                                                                                       //BoxShadow
                //                                                                                       BoxShadow(
                //                                                                                         color: Colors.white,
                //                                                                                         offset: const Offset(0.0, 0.0),
                //                                                                                         blurRadius: 0.0,
                //                                                                                         spreadRadius: 0.0,
                //                                                                                       ),
                //                                                                                       //BoxShadow
                //                                                                                     ],
                //                                                                                   ),
                //                                                                                   child: Padding(
                //                                                                                     padding: const EdgeInsets.all(8.0),
                //                                                                                     child: Icon(
                //                                                                                       Icons.close,
                //                                                                                       size: 15,
                //                                                                                     ),
                //                                                                                   ),
                //                                                                                 ),
                //                                                                               ),
                //                                                                             ],
                //                                                                           ),
                //                                                                         ),
                //                                                                         kCommonSpaceV10,
                //                                                                         kCommonSpaceV3,
                //                                                                         Container(
                //                                                                           height: 3,
                //                                                                           color: CommonColors.mGrey300,
                //                                                                         ),
                //                                                                         Container(
                //                                                                           height: MediaQuery.of(context).size.height / 1.82,
                //                                                                           padding: const EdgeInsets.symmetric(horizontal: 12),
                //                                                                           margin: const EdgeInsets.only(top: 12),
                //                                                                           decoration: BoxDecoration(
                //                                                                             color: Colors.red,
                //                                                                             borderRadius: BorderRadius.circular(12),
                //                                                                           ),
                //                                                                           child: SingleChildScrollView(
                //                                                                             child: ListView.builder(
                //                                                                               padding: const EdgeInsets.only(top: 12),
                //                                                                               physics: const ClampingScrollPhysics(),
                //                                                                               shrinkWrap: true,
                //                                                                               scrollDirection: Axis.vertical,
                //                                                                               itemCount: 15,
                //                                                                               itemBuilder: (BuildContext context, int index) {
                //                                                                                 return Column(
                //                                                                                   children: [
                //                                                                                     Row(
                //                                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                                       children: [
                //                                                                                         CachedNetworkImage(
                //                                                                                           height: 80,
                //                                                                                           width: 80,
                //                                                                                           imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                                                                           imageBuilder: (context, imageProvider) => Container(
                //                                                                                             decoration: BoxDecoration(
                //                                                                                               image: DecorationImage(
                //                                                                                                 image: imageProvider,
                //                                                                                                 fit: BoxFit.contain,
                //                                                                                               ),
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                           placeholder: (context, url) => const Padding(
                //                                                                                             padding: EdgeInsets.all(12.0),
                //                                                                                             child: Center(
                //                                                                                               child: CircularProgressIndicator(
                //                                                                                                 strokeWidth: 2,
                //                                                                                                 color: Colors.black,
                //                                                                                               ),
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                           errorWidget: (context, url, error) => const Center(
                //                                                                                             child: Icon(
                //                                                                                               Icons.error_outline,
                //                                                                                               color: Colors.red,
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                         ),
                //                                                                                         const SizedBox(width: 14),
                //                                                                                         Expanded(
                //                                                                                           child: Column(
                //                                                                                             crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                                             mainAxisAlignment: MainAxisAlignment.start,
                //                                                                                             children: [
                //                                                                                               Text(
                //                                                                                                 "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                //                                                                                                 maxLines: 2,
                //                                                                                                 overflow: TextOverflow.ellipsis,
                //                                                                                                 style: getAppStyle(
                //                                                                                                   color: Colors.black,
                //                                                                                                   fontWeight: FontWeight.w600,
                //                                                                                                   fontSize: 13,
                //                                                                                                 ),
                //                                                                                               ),
                //                                                                                               Padding(
                //                                                                                                 padding: const EdgeInsets.symmetric(vertical: 02),
                //                                                                                                 child: Text(
                //                                                                                                   "250 g",
                //                                                                                                   style: getAppStyle(
                //                                                                                                     color: Colors.grey,
                //                                                                                                     fontWeight: FontWeight.w500,
                //                                                                                                     fontSize: 12,
                //                                                                                                   ),
                //                                                                                                 ),
                //                                                                                               ),
                //                                                                                             ],
                //                                                                                           ),
                //                                                                                         ),
                //                                                                                         const SizedBox(width: 8),
                //                                                                                         Column(
                //                                                                                           crossAxisAlignment: CrossAxisAlignment.start,
                //                                                                                           mainAxisAlignment: MainAxisAlignment.start,
                //                                                                                           children: [
                //                                                                                             Container(
                //                                                                                               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                //                                                                                               margin: const EdgeInsets.only(bottom: 4),
                //                                                                                               height: 30,
                //                                                                                               width: 80,
                //                                                                                               decoration: BoxDecoration(
                //                                                                                                 borderRadius: BorderRadius.circular(6),
                //                                                                                                 color: CommonColors.primaryColor,
                //                                                                                               ),
                //                                                                                               child: Row(
                //                                                                                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                                                                                                 children: [
                //                                                                                                   GestureDetector(
                //                                                                                                     onTap: () => decrementItem(),
                //                                                                                                     child: const Icon(
                //                                                                                                       Icons.remove,
                //                                                                                                       size: 16,
                //                                                                                                       color: Colors.white,
                //                                                                                                     ),
                //                                                                                                   ),
                //                                                                                                   Text(
                //                                                                                                     itemCount.toString(),
                //                                                                                                     style: getAppStyle(
                //                                                                                                       color: Colors.white,
                //                                                                                                       fontWeight: FontWeight.w500,
                //                                                                                                       fontSize: 14,
                //                                                                                                     ),
                //                                                                                                   ),
                //                                                                                                   GestureDetector(
                //                                                                                                     onTap: () => incrementItem(),
                //                                                                                                     child: const Icon(
                //                                                                                                       Icons.add,
                //                                                                                                       size: 16,
                //                                                                                                       color: Colors.white,
                //                                                                                                     ),
                //                                                                                                   ),
                //                                                                                                 ],
                //                                                                                               ),
                //                                                                                             ),
                //                                                                                             Row(
                //                                                                                               children: [
                //                                                                                                 Text(
                //                                                                                                   "₹${"80.0"}",
                //                                                                                                   style: getAppStyle(
                //                                                                                                     decoration: TextDecoration.lineThrough,
                //                                                                                                     color: Colors.grey,
                //                                                                                                     fontWeight: FontWeight.w500,
                //                                                                                                     fontSize: 12,
                //                                                                                                   ),
                //                                                                                                 ),
                //                                                                                                 const SizedBox(width: 4),
                //                                                                                                 Text(
                //                                                                                                   "₹${"250.0"}",
                //                                                                                                   style: getAppStyle(
                //                                                                                                     color: Colors.black,
                //                                                                                                     fontWeight: FontWeight.bold,
                //                                                                                                     fontSize: 13,
                //                                                                                                   ),
                //                                                                                                 ),
                //                                                                                               ],
                //                                                                                             ),
                //                                                                                           ],
                //                                                                                         ),
                //                                                                                       ],
                //                                                                                     ),
                //                                                                                     const SizedBox(height: 10)
                //                                                                                   ],
                //                                                                                 );
                //                                                                               },
                //                                                                             ),
                //                                                                           ),
                //                                                                         ),
                //                                                                         const Spacer(),
                //                                                                         Padding(
                //                                                                           padding: const EdgeInsets.only(top: 10, bottom: 20),
                //                                                                           child: Row(
                //                                                                             children: [
                //                                                                               Container(
                //                                                                                 height: 42,
                //                                                                                 width: 58,
                //                                                                                 margin: const EdgeInsets.only(right: 10),
                //                                                                                 color: Colors.transparent,
                //                                                                                 child: Stack(
                //                                                                                   children: [
                //                                                                                     Container(
                //                                                                                       height: 42,
                //                                                                                       width: 42,
                //                                                                                       decoration: BoxDecoration(
                //                                                                                         color: Colors.white,
                //                                                                                         border: Border.all(color: Colors.grey),
                //                                                                                         borderRadius: BorderRadius.circular(10),
                //                                                                                       ),
                //                                                                                     ),
                //                                                                                     Positioned(
                //                                                                                       left: 8,
                //                                                                                       child: Container(
                //                                                                                         height: 42,
                //                                                                                         width: 42,
                //                                                                                         decoration: BoxDecoration(
                //                                                                                           color: Colors.white,
                //                                                                                           border: Border.all(color: Colors.grey),
                //                                                                                           borderRadius: BorderRadius.circular(10),
                //                                                                                         ),
                //                                                                                       ),
                //                                                                                     ),
                //                                                                                     Positioned(
                //                                                                                       left: 16,
                //                                                                                       child: Container(
                //                                                                                         height: 42,
                //                                                                                         width: 42,
                //                                                                                         decoration: BoxDecoration(
                //                                                                                           color: Colors.white,
                //                                                                                           border: Border.all(color: Colors.grey),
                //                                                                                           borderRadius: BorderRadius.circular(10),
                //                                                                                         ),
                //                                                                                         child: CachedNetworkImage(
                //                                                                                           height: 80,
                //                                                                                           width: 80,
                //                                                                                           imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                                                                           imageBuilder: (context, imageProvider) => Container(
                //                                                                                             decoration: BoxDecoration(
                //                                                                                               image: DecorationImage(
                //                                                                                                 image: imageProvider,
                //                                                                                                 fit: BoxFit.contain,
                //                                                                                               ),
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                           placeholder: (context, url) => const Padding(
                //                                                                                             padding: EdgeInsets.all(12.0),
                //                                                                                             child: Center(
                //                                                                                               child: CircularProgressIndicator(
                //                                                                                                 strokeWidth: 2,
                //                                                                                                 color: Colors.black,
                //                                                                                               ),
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                           errorWidget: (context, url, error) => const Center(
                //                                                                                             child: Icon(
                //                                                                                               Icons.error_outline,
                //                                                                                               color: Colors.red,
                //                                                                                             ),
                //                                                                                           ),
                //                                                                                         ),
                //                                                                                       ),
                //                                                                                     ),
                //                                                                                   ],
                //                                                                                 ),
                //                                                                               ),
                //                                                                               InkWell(
                //                                                                                 onTap: () {
                //                                                                                   debugPrint("OnTap");
                //                                                                                 },
                //                                                                                 child: Row(
                //                                                                                   children: [
                //                                                                                     Text(
                //                                                                                       "6 Item",
                //                                                                                       style: getAppStyle(
                //                                                                                         color: Colors.black,
                //                                                                                         fontWeight: FontWeight.w500,
                //                                                                                         fontSize: 12,
                //                                                                                       ),
                //                                                                                     ),
                //                                                                                     const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                //                                                                                   ],
                //                                                                                 ),
                //                                                                               ),
                //                                                                               const SizedBox(width: 20),
                //                                                                               Expanded(
                //                                                                                 child: GestureDetector(
                //                                                                                   onTap: () {
                //                                                                                     debugPrint("On Tap Sub Product");
                //                                                                                   },
                //                                                                                   child: Container(
                //                                                                                     height: 40,
                //                                                                                     decoration: BoxDecoration(
                //                                                                                       borderRadius: BorderRadius.circular(6),
                //                                                                                       color: CommonColors.primaryColor,
                //                                                                                     ),
                //                                                                                     child: Center(
                //                                                                                       child: Text(
                //                                                                                         "View Cart",
                //                                                                                         style: getAppStyle(
                //                                                                                           color: Colors.white,
                //                                                                                           fontWeight: FontWeight.bold,
                //                                                                                           fontSize: 14,
                //                                                                                         ),
                //                                                                                       ),
                //                                                                                     ),
                //                                                                                   ),
                //                                                                                 ),
                //                                                                               ),
                //                                                                             ],
                //                                                                           ),
                //                                                                         ),
                //                                                                       ],
                //                                                                     ),
                //                                                                   );
                //                                                                 },
                //                                                               ),
                //                                                             );
                //                                                           },
                //                                                         );
                //
                //                                                         // showModalBottomSheet(
                //                                                         //   context: context,
                //                                                         //   builder: (BuildContext context) {
                //                                                         //     return Padding(
                //                                                         //       padding: const EdgeInsets.all(8.0),
                //                                                         //       child: Column(
                //                                                         //         crossAxisAlignment: CrossAxisAlignment.start,
                //                                                         //         children: [
                //                                                         //           Padding(
                //                                                         //             padding: const EdgeInsets.only(
                //                                                         //                 left: 12, right: 12, top: 12),
                //                                                         //             child: Row(
                //                                                         //               mainAxisAlignment:
                //                                                         //                   MainAxisAlignment.spaceBetween,
                //                                                         //               children: [
                //                                                         //                 Column(
                //                                                         //                   crossAxisAlignment:
                //                                                         //                       CrossAxisAlignment.start,
                //                                                         //                   children: [
                //                                                         //                     Text(
                //                                                         //                       'Review Cart',
                //                                                         //                       style: getAppStyle(
                //                                                         //                           fontWeight: FontWeight.bold,
                //                                                         //                           fontSize: 18),
                //                                                         //                     ),
                //                                                         //                     Row(
                //                                                         //                       children: [
                //                                                         //                         Text(
                //                                                         //                           "3 Items • Total",
                //                                                         //                           style: getAppStyle(
                //                                                         //                               color: CommonColors
                //                                                         //                                   .black54),
                //                                                         //                         ),
                //                                                         //                         Text(
                //                                                         //                           " ₹542",
                //                                                         //                           style: getAppStyle(
                //                                                         //                               fontWeight:
                //                                                         //                                   FontWeight.bold),
                //                                                         //                         ),
                //                                                         //                       ],
                //                                                         //                     )
                //                                                         //                   ],
                //                                                         //                 ),
                //                                                         //                 InkWell(
                //                                                         //                   onTap: () {
                //                                                         //                     Navigator.pop(context);
                //                                                         //                   },
                //                                                         //                   child: Container(
                //                                                         //                     decoration: BoxDecoration(
                //                                                         //                       shape: BoxShape.circle,
                //                                                         //                       boxShadow: [
                //                                                         //                         BoxShadow(
                //                                                         //                           color: Colors.grey,
                //                                                         //                           offset: const Offset(
                //                                                         //                             2.0,
                //                                                         //                             2.0,
                //                                                         //                           ),
                //                                                         //                           blurRadius: 5.0,
                //                                                         //                           spreadRadius: 0.0,
                //                                                         //                         ), //BoxShadow
                //                                                         //                         BoxShadow(
                //                                                         //                           color: Colors.white,
                //                                                         //                           offset:
                //                                                         //                               const Offset(0.0, 0.0),
                //                                                         //                           blurRadius: 0.0,
                //                                                         //                           spreadRadius: 0.0,
                //                                                         //                         ), //BoxShadow
                //                                                         //                       ],
                //                                                         //                     ),
                //                                                         //                     child: Padding(
                //                                                         //                       padding:
                //                                                         //                           const EdgeInsets.all(8.0),
                //                                                         //                       child: Icon(
                //                                                         //                         Icons.close,
                //                                                         //                         size: 15,
                //                                                         //                       ),
                //                                                         //                     ),
                //                                                         //                   ),
                //                                                         //                 ),
                //                                                         //               ],
                //                                                         //             ),
                //                                                         //           ),
                //                                                         //           kCommonSpaceV10,
                //                                                         //           kCommonSpaceV3,
                //                                                         //           Container(
                //                                                         //             height: 3,
                //                                                         //             color: CommonColors.mGrey300,
                //                                                         //           ),
                //                                                         //           Container(
                //                                                         //             height:
                //                                                         //                 MediaQuery.of(context).size.height /
                //                                                         //                     1.77,
                //                                                         //             padding: const EdgeInsets.symmetric(
                //                                                         //                 horizontal: 12),
                //                                                         //             margin: const EdgeInsets.only(
                //                                                         //                 top: 12),
                //                                                         //             decoration: BoxDecoration(
                //                                                         //               color: Colors.red,
                //                                                         //               borderRadius: BorderRadius.circular(12),
                //                                                         //             ),
                //                                                         //             child: SingleChildScrollView(
                //                                                         //               child: ListView.builder(
                //                                                         //                 padding:
                //                                                         //                     const EdgeInsets.only(top: 12),
                //                                                         //                 physics:
                //                                                         //                     const ClampingScrollPhysics(),
                //                                                         //                 shrinkWrap: true,
                //                                                         //                 scrollDirection: Axis.vertical,
                //                                                         //                 itemCount: 15,
                //                                                         //                 itemBuilder: (BuildContext context,
                //                                                         //                     int index) {
                //                                                         //                   return Column(
                //                                                         //                     children: [
                //                                                         //                       Row(
                //                                                         //                         crossAxisAlignment:
                //                                                         //                             CrossAxisAlignment.start,
                //                                                         //                         children: [
                //                                                         //                           CachedNetworkImage(
                //                                                         //                             height: 80,
                //                                                         //                             width: 80,
                //                                                         //                             imageUrl:
                //                                                         //                                 "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                                                         //                             imageBuilder: (context,
                //                                                         //                                     imageProvider) =>
                //                                                         //                                 Container(
                //                                                         //                               decoration:
                //                                                         //                                   BoxDecoration(
                //                                                         //                                 image:
                //                                                         //                                     DecorationImage(
                //                                                         //                                   image:
                //                                                         //                                       imageProvider,
                //                                                         //                                   fit: BoxFit.contain,
                //                                                         //                                 ),
                //                                                         //                               ),
                //                                                         //                             ),
                //                                                         //                             placeholder:
                //                                                         //                                 (context, url) =>
                //                                                         //                                     const Padding(
                //                                                         //                               padding: EdgeInsets.all(
                //                                                         //                                   12.0),
                //                                                         //                               child: Center(
                //                                                         //                                 child:
                //                                                         //                                     CircularProgressIndicator(
                //                                                         //                                   strokeWidth: 2,
                //                                                         //                                   color: Colors.black,
                //                                                         //                                 ),
                //                                                         //                               ),
                //                                                         //                             ),
                //                                                         //                             errorWidget: (context,
                //                                                         //                                     url, error) =>
                //                                                         //                                 const Center(
                //                                                         //                               child: Icon(
                //                                                         //                                 Icons.error_outline,
                //                                                         //                                 color: Colors.red,
                //                                                         //                               ),
                //                                                         //                             ),
                //                                                         //                           ),
                //                                                         //                           const SizedBox(width: 14),
                //                                                         //                           Expanded(
                //                                                         //                             child: Column(
                //                                                         //                               crossAxisAlignment:
                //                                                         //                                   CrossAxisAlignment
                //                                                         //                                       .start,
                //                                                         //                               mainAxisAlignment:
                //                                                         //                                   MainAxisAlignment
                //                                                         //                                       .start,
                //                                                         //                               children: [
                //                                                         //                                 Text(
                //                                                         //                                   "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                //                                                         //                                   maxLines: 2,
                //                                                         //                                   overflow:
                //                                                         //                                       TextOverflow
                //                                                         //                                           .ellipsis,
                //                                                         //                                   style: getAppStyle(
                //                                                         //                                     color:
                //                                                         //                                         Colors.black,
                //                                                         //                                     fontWeight:
                //                                                         //                                         FontWeight
                //                                                         //                                             .w600,
                //                                                         //                                     fontSize: 13,
                //                                                         //                                   ),
                //                                                         //                                 ),
                //                                                         //                                 Padding(
                //                                                         //                                   padding:
                //                                                         //                                       const EdgeInsets
                //                                                         //                                           .symmetric(
                //                                                         //                                           vertical:
                //                                                         //                                               02),
                //                                                         //                                   child: Text(
                //                                                         //                                     "250 g",
                //                                                         //                                     style:
                //                                                         //                                         getAppStyle(
                //                                                         //                                       color:
                //                                                         //                                           Colors.grey,
                //                                                         //                                       fontWeight:
                //                                                         //                                           FontWeight
                //                                                         //                                               .w500,
                //                                                         //                                       fontSize: 12,
                //                                                         //                                     ),
                //                                                         //                                   ),
                //                                                         //                                 ),
                //                                                         //                               ],
                //                                                         //                             ),
                //                                                         //                           ),
                //                                                         //                           const SizedBox(width: 8),
                //                                                         //                           Column(
                //                                                         //                             crossAxisAlignment:
                //                                                         //                                 CrossAxisAlignment
                //                                                         //                                     .start,
                //                                                         //                             mainAxisAlignment:
                //                                                         //                                 MainAxisAlignment
                //                                                         //                                     .start,
                //                                                         //                             children: [
                //                                                         //                               Container(
                //                                                         //                                 padding:
                //                                                         //                                     const EdgeInsets
                //                                                         //                                         .symmetric(
                //                                                         //                                         horizontal: 4,
                //                                                         //                                         vertical: 4),
                //                                                         //                                 margin:
                //                                                         //                                     const EdgeInsets
                //                                                         //                                         .only(
                //                                                         //                                         bottom: 4),
                //                                                         //                                 height: 30,
                //                                                         //                                 width: 80,
                //                                                         //                                 decoration:
                //                                                         //                                     BoxDecoration(
                //                                                         //                                   borderRadius:
                //                                                         //                                       BorderRadius
                //                                                         //                                           .circular(
                //                                                         //                                               6),
                //                                                         //                                   color: CommonColors
                //                                                         //                                       .primaryColor,
                //                                                         //                                 ),
                //                                                         //                                 child: Row(
                //                                                         //                                   mainAxisAlignment:
                //                                                         //                                       MainAxisAlignment
                //                                                         //                                           .spaceAround,
                //                                                         //                                   children: [
                //                                                         //                                     GestureDetector(
                //                                                         //                                       onTap: () =>
                //                                                         //                                           decrementItem(),
                //                                                         //                                       child:
                //                                                         //                                           const Icon(
                //                                                         //                                         Icons.remove,
                //                                                         //                                         size: 16,
                //                                                         //                                         color: Colors
                //                                                         //                                             .white,
                //                                                         //                                       ),
                //                                                         //                                     ),
                //                                                         //                                     Text(
                //                                                         //                                       itemCount
                //                                                         //                                           .toString(),
                //                                                         //                                       style:
                //                                                         //                                           getAppStyle(
                //                                                         //                                         color: Colors
                //                                                         //                                             .white,
                //                                                         //                                         fontWeight:
                //                                                         //                                             FontWeight
                //                                                         //                                                 .w500,
                //                                                         //                                         fontSize: 14,
                //                                                         //                                       ),
                //                                                         //                                     ),
                //                                                         //                                     GestureDetector(
                //                                                         //                                       onTap: () =>
                //                                                         //                                           incrementItem(),
                //                                                         //                                       child:
                //                                                         //                                           const Icon(
                //                                                         //                                         Icons.add,
                //                                                         //                                         size: 16,
                //                                                         //                                         color: Colors
                //                                                         //                                             .white,
                //                                                         //                                       ),
                //                                                         //                                     ),
                //                                                         //                                   ],
                //                                                         //                                 ),
                //                                                         //                               ),
                //                                                         //                               Row(
                //                                                         //                                 children: [
                //                                                         //                                   Text(
                //                                                         //                                     "₹${"80.0"}",
                //                                                         //                                     style:
                //                                                         //                                         getAppStyle(
                //                                                         //                                       decoration:
                //                                                         //                                           TextDecoration
                //                                                         //                                               .lineThrough,
                //                                                         //                                       color:
                //                                                         //                                           Colors.grey,
                //                                                         //                                       fontWeight:
                //                                                         //                                           FontWeight
                //                                                         //                                               .w500,
                //                                                         //                                       fontSize: 12,
                //                                                         //                                     ),
                //                                                         //                                   ),
                //                                                         //                                   const SizedBox(
                //                                                         //                                       width: 4),
                //                                                         //                                   Text(
                //                                                         //                                     "₹${"250.0"}",
                //                                                         //                                     style:
                //                                                         //                                         getAppStyle(
                //                                                         //                                       color: Colors
                //                                                         //                                           .black,
                //                                                         //                                       fontWeight:
                //                                                         //                                           FontWeight
                //                                                         //                                               .bold,
                //                                                         //                                       fontSize: 13,
                //                                                         //                                     ),
                //                                                         //                                   ),
                //                                                         //                                 ],
                //                                                         //                               ),
                //                                                         //                             ],
                //                                                         //                           ),
                //                                                         //                         ],
                //                                                         //                       ),
                //                                                         //                       const SizedBox(height: 10)
                //                                                         //                     ],
                //                                                         //                   );
                //                                                         //                 },
                //                                                         //               ),
                //                                                         //             ),
                //                                                         //           ),
                //                                                         //         ],
                //                                                         //       ),
                //                                                         //     );
                //                                                         //   },
                //                                                         // );
                //                                                       },
                //                                                     ),
                //                                                   ),
                //                                                 ],
                //                                               ),
                //                                             ),
                //                                           ],
                //                                         ),
                //                                       );
                //                                     },
                //                                   ),
                //                                 );
                //                               },
                //                             );
                //
                //                             // showModalBottomSheet(
                //                             //   context: context,
                //                             //   builder: (BuildContext context) {
                //                             //     return Padding(
                //                             //       padding: const EdgeInsets.all(8.0),
                //                             //       child: Column(
                //                             //         crossAxisAlignment: CrossAxisAlignment.start,
                //                             //         children: [
                //                             //           Padding(
                //                             //             padding: const EdgeInsets.only(
                //                             //                 left: 12, right: 12, top: 12),
                //                             //             child: Row(
                //                             //               mainAxisAlignment:
                //                             //                   MainAxisAlignment.spaceBetween,
                //                             //               children: [
                //                             //                 Column(
                //                             //                   crossAxisAlignment:
                //                             //                       CrossAxisAlignment.start,
                //                             //                   children: [
                //                             //                     Text(
                //                             //                       'Review Cart',
                //                             //                       style: getAppStyle(
                //                             //                           fontWeight: FontWeight.bold,
                //                             //                           fontSize: 18),
                //                             //                     ),
                //                             //                     Row(
                //                             //                       children: [
                //                             //                         Text(
                //                             //                           "3 Items • Total",
                //                             //                           style: getAppStyle(
                //                             //                               color: CommonColors
                //                             //                                   .black54),
                //                             //                         ),
                //                             //                         Text(
                //                             //                           " ₹542",
                //                             //                           style: getAppStyle(
                //                             //                               fontWeight:
                //                             //                                   FontWeight.bold),
                //                             //                         ),
                //                             //                       ],
                //                             //                     )
                //                             //                   ],
                //                             //                 ),
                //                             //                 InkWell(
                //                             //                   onTap: () {
                //                             //                     Navigator.pop(context);
                //                             //                   },
                //                             //                   child: Container(
                //                             //                     decoration: BoxDecoration(
                //                             //                       shape: BoxShape.circle,
                //                             //                       boxShadow: [
                //                             //                         BoxShadow(
                //                             //                           color: Colors.grey,
                //                             //                           offset: const Offset(
                //                             //                             2.0,
                //                             //                             2.0,
                //                             //                           ),
                //                             //                           blurRadius: 5.0,
                //                             //                           spreadRadius: 0.0,
                //                             //                         ), //BoxShadow
                //                             //                         BoxShadow(
                //                             //                           color: Colors.white,
                //                             //                           offset:
                //                             //                               const Offset(0.0, 0.0),
                //                             //                           blurRadius: 0.0,
                //                             //                           spreadRadius: 0.0,
                //                             //                         ), //BoxShadow
                //                             //                       ],
                //                             //                     ),
                //                             //                     child: Padding(
                //                             //                       padding:
                //                             //                           const EdgeInsets.all(8.0),
                //                             //                       child: Icon(
                //                             //                         Icons.close,
                //                             //                         size: 15,
                //                             //                       ),
                //                             //                     ),
                //                             //                   ),
                //                             //                 ),
                //                             //               ],
                //                             //             ),
                //                             //           ),
                //                             //           kCommonSpaceV10,
                //                             //           kCommonSpaceV3,
                //                             //           Container(
                //                             //             height: 3,
                //                             //             color: CommonColors.mGrey300,
                //                             //           ),
                //                             //           Container(
                //                             //             height:
                //                             //                 MediaQuery.of(context).size.height /
                //                             //                     1.77,
                //                             //             padding: const EdgeInsets.symmetric(
                //                             //                 horizontal: 12),
                //                             //             margin: const EdgeInsets.only(
                //                             //                 top: 12),
                //                             //             decoration: BoxDecoration(
                //                             //               color: Colors.red,
                //                             //               borderRadius: BorderRadius.circular(12),
                //                             //             ),
                //                             //             child: SingleChildScrollView(
                //                             //               child: ListView.builder(
                //                             //                 padding:
                //                             //                     const EdgeInsets.only(top: 12),
                //                             //                 physics:
                //                             //                     const ClampingScrollPhysics(),
                //                             //                 shrinkWrap: true,
                //                             //                 scrollDirection: Axis.vertical,
                //                             //                 itemCount: 15,
                //                             //                 itemBuilder: (BuildContext context,
                //                             //                     int index) {
                //                             //                   return Column(
                //                             //                     children: [
                //                             //                       Row(
                //                             //                         crossAxisAlignment:
                //                             //                             CrossAxisAlignment.start,
                //                             //                         children: [
                //                             //                           CachedNetworkImage(
                //                             //                             height: 80,
                //                             //                             width: 80,
                //                             //                             imageUrl:
                //                             //                                 "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                //                             //                             imageBuilder: (context,
                //                             //                                     imageProvider) =>
                //                             //                                 Container(
                //                             //                               decoration:
                //                             //                                   BoxDecoration(
                //                             //                                 image:
                //                             //                                     DecorationImage(
                //                             //                                   image:
                //                             //                                       imageProvider,
                //                             //                                   fit: BoxFit.contain,
                //                             //                                 ),
                //                             //                               ),
                //                             //                             ),
                //                             //                             placeholder:
                //                             //                                 (context, url) =>
                //                             //                                     const Padding(
                //                             //                               padding: EdgeInsets.all(
                //                             //                                   12.0),
                //                             //                               child: Center(
                //                             //                                 child:
                //                             //                                     CircularProgressIndicator(
                //                             //                                   strokeWidth: 2,
                //                             //                                   color: Colors.black,
                //                             //                                 ),
                //                             //                               ),
                //                             //                             ),
                //                             //                             errorWidget: (context,
                //                             //                                     url, error) =>
                //                             //                                 const Center(
                //                             //                               child: Icon(
                //                             //                                 Icons.error_outline,
                //                             //                                 color: Colors.red,
                //                             //                               ),
                //                             //                             ),
                //                             //                           ),
                //                             //                           const SizedBox(width: 14),
                //                             //                           Expanded(
                //                             //                             child: Column(
                //                             //                               crossAxisAlignment:
                //                             //                                   CrossAxisAlignment
                //                             //                                       .start,
                //                             //                               mainAxisAlignment:
                //                             //                                   MainAxisAlignment
                //                             //                                       .start,
                //                             //                               children: [
                //                             //                                 Text(
                //                             //                                   "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                //                             //                                   maxLines: 2,
                //                             //                                   overflow:
                //                             //                                       TextOverflow
                //                             //                                           .ellipsis,
                //                             //                                   style: getAppStyle(
                //                             //                                     color:
                //                             //                                         Colors.black,
                //                             //                                     fontWeight:
                //                             //                                         FontWeight
                //                             //                                             .w600,
                //                             //                                     fontSize: 13,
                //                             //                                   ),
                //                             //                                 ),
                //                             //                                 Padding(
                //                             //                                   padding:
                //                             //                                       const EdgeInsets
                //                             //                                           .symmetric(
                //                             //                                           vertical:
                //                             //                                               02),
                //                             //                                   child: Text(
                //                             //                                     "250 g",
                //                             //                                     style:
                //                             //                                         getAppStyle(
                //                             //                                       color:
                //                             //                                           Colors.grey,
                //                             //                                       fontWeight:
                //                             //                                           FontWeight
                //                             //                                               .w500,
                //                             //                                       fontSize: 12,
                //                             //                                     ),
                //                             //                                   ),
                //                             //                                 ),
                //                             //                               ],
                //                             //                             ),
                //                             //                           ),
                //                             //                           const SizedBox(width: 8),
                //                             //                           Column(
                //                             //                             crossAxisAlignment:
                //                             //                                 CrossAxisAlignment
                //                             //                                     .start,
                //                             //                             mainAxisAlignment:
                //                             //                                 MainAxisAlignment
                //                             //                                     .start,
                //                             //                             children: [
                //                             //                               Container(
                //                             //                                 padding:
                //                             //                                     const EdgeInsets
                //                             //                                         .symmetric(
                //                             //                                         horizontal: 4,
                //                             //                                         vertical: 4),
                //                             //                                 margin:
                //                             //                                     const EdgeInsets
                //                             //                                         .only(
                //                             //                                         bottom: 4),
                //                             //                                 height: 30,
                //                             //                                 width: 80,
                //                             //                                 decoration:
                //                             //                                     BoxDecoration(
                //                             //                                   borderRadius:
                //                             //                                       BorderRadius
                //                             //                                           .circular(
                //                             //                                               6),
                //                             //                                   color: CommonColors
                //                             //                                       .primaryColor,
                //                             //                                 ),
                //                             //                                 child: Row(
                //                             //                                   mainAxisAlignment:
                //                             //                                       MainAxisAlignment
                //                             //                                           .spaceAround,
                //                             //                                   children: [
                //                             //                                     GestureDetector(
                //                             //                                       onTap: () =>
                //                             //                                           decrementItem(),
                //                             //                                       child:
                //                             //                                           const Icon(
                //                             //                                         Icons.remove,
                //                             //                                         size: 16,
                //                             //                                         color: Colors
                //                             //                                             .white,
                //                             //                                       ),
                //                             //                                     ),
                //                             //                                     Text(
                //                             //                                       itemCount
                //                             //                                           .toString(),
                //                             //                                       style:
                //                             //                                           getAppStyle(
                //                             //                                         color: Colors
                //                             //                                             .white,
                //                             //                                         fontWeight:
                //                             //                                             FontWeight
                //                             //                                                 .w500,
                //                             //                                         fontSize: 14,
                //                             //                                       ),
                //                             //                                     ),
                //                             //                                     GestureDetector(
                //                             //                                       onTap: () =>
                //                             //                                           incrementItem(),
                //                             //                                       child:
                //                             //                                           const Icon(
                //                             //                                         Icons.add,
                //                             //                                         size: 16,
                //                             //                                         color: Colors
                //                             //                                             .white,
                //                             //                                       ),
                //                             //                                     ),
                //                             //                                   ],
                //                             //                                 ),
                //                             //                               ),
                //                             //                               Row(
                //                             //                                 children: [
                //                             //                                   Text(
                //                             //                                     "₹${"80.0"}",
                //                             //                                     style:
                //                             //                                         getAppStyle(
                //                             //                                       decoration:
                //                             //                                           TextDecoration
                //                             //                                               .lineThrough,
                //                             //                                       color:
                //                             //                                           Colors.grey,
                //                             //                                       fontWeight:
                //                             //                                           FontWeight
                //                             //                                               .w500,
                //                             //                                       fontSize: 12,
                //                             //                                     ),
                //                             //                                   ),
                //                             //                                   const SizedBox(
                //                             //                                       width: 4),
                //                             //                                   Text(
                //                             //                                     "₹${"250.0"}",
                //                             //                                     style:
                //                             //                                         getAppStyle(
                //                             //                                       color: Colors
                //                             //                                           .black,
                //                             //                                       fontWeight:
                //                             //                                           FontWeight
                //                             //                                               .bold,
                //                             //                                       fontSize: 13,
                //                             //                                     ),
                //                             //                                   ),
                //                             //                                 ],
                //                             //                               ),
                //                             //                             ],
                //                             //                           ),
                //                             //                         ],
                //                             //                       ),
                //                             //                       const SizedBox(height: 10)
                //                             //                     ],
                //                             //                   );
                //                             //                 },
                //                             //               ),
                //                             //             ),
                //                             //           ),
                //                             //         ],
                //                             //       ),
                //                             //     );
                //                             //   },
                //                             // );
                //                           },
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   );
                // },
                onTap: () {
                  print("Category id...... ${section3[index].categoryId}");
                  push(SubCategoryViewRedesign(
                    categoryId: section3[index].categoryId,
                  ));
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
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(section3[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
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

  const Section4({
    super.key,
    required this.section4,
    required this.section4Title,
    required this.onAddItem,
    required this.onRemoveItem,
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
    } else {
      print(
          ".......Sorry this product have only ${widget.section4[index].stock} in a stock......");
      String msg =
          "Only ${widget.section4[index].stock} product available in stock";
      CommonUtils.showSnackBar(msg, color: CommonColors.mRed);
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
                      fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
                ),
                Text(
                  "View All >",
                  style: getAppStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.2,
                      color: CommonColors.primaryColor),
                ),
              ],
            ),
          ),
          kCommonSpaceV15,
        ],
        SizedBox(
          height: kDeviceHeight / 3.2,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.section4.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductContainer(
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
                    ),
                  ),
                );
              },
            ),
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
          Image.network(section5.first.image),
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
          height: 300,
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(section6
                                          .first.categories[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                section6.first.categories[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: getAppStyle(
                                    fontWeight: FontWeight.w500, height: 1),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section7Title.isNotEmpty) ...[
            Image.asset(LocalImages.img_brand_spotlight),
            kCommonSpaceV20,
          ],
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 15.0, // Horizontal spacing between items
              mainAxisSpacing: 15.0, // Vertical spacing between items
              childAspectRatio:
                  1.1, // Aspect ratio for each item (adjust as needed)
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: section7.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffffdbdd),
                      Color(0xffffdbdd),
                      Color(0xffffbfc0)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    section7[index].image,
                    fit: BoxFit.contain,
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
                  fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
            ),
          ),
          kCommonSpaceV15,
        ],
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: FittedBox(
            child: Row(
              children: [
                Container(
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
                kCommonSpaceH10,
                Container(
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
                kCommonSpaceH10,
                Container(
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

  const Section9({super.key, required this.section9});

  @override
  State<Section9> createState() => _Section9State();
}

class _Section9State extends State<Section9> {
  int itemCount = 0;

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
              Spacer(),
              SizedBox(
                height: kDeviceHeight / 3.2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.section9[0].products.length,
                    shrinkWrap: true,
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
                                      Center(
                                        child: Image.network(
                                          widget.section9[0].products[index]
                                              .image,
                                          fit: BoxFit.contain,
                                          height: 170,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            widget.section9[0].products[index]
                                                .productName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: getAppStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          widget.section9[0].products[index]
                                              .variantName,
                                          style: getAppStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
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
                                                  widget
                                                      .section9[0]
                                                      .products[index]
                                                      .discountPrice
                                                      .toString(),
                                                  style: getAppStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  widget
                                                      .section9[0]
                                                      .products[index]
                                                      .productPrice
                                                      .toString(),
                                                  style: getAppStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                          BorderRadius.circular(
                                                              8),
                                                      color: CommonColors
                                                          .primaryColor,
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
                                                                FontWeight.bold,
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
                                        "${widget.section9[0].products[index].discountPer}% off",
                                        style: getAppStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
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
              ),
              kCommonSpaceV15,
            ],
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
