import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/view/home/home_view_model.dart';
import 'package:solikat_2024/view/home/profile/edit_account/edit_account_view.dart';
import 'package:solikat_2024/view/home/profile/edit_account/edit_account_view_model.dart';
import 'package:solikat_2024/view/home/section_designs.dart';
import 'package:solikat_2024/view/home/shimmer_effect.dart';
import 'package:solikat_2024/widget/common_text_field.dart';
import 'package:solikat_2024/widget/primary_button.dart';

import '../../models/home_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';
import '../../utils/global_variables.dart';
import '../common_view/bottom_navbar/bottom_navbar_view_model.dart';

class HomeView extends StatefulWidget {
  final String? location;

  const HomeView({super.key, this.location});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  final ScrollController _scrollController = ScrollController();
  late FocusNode _searchFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  String imagePath = "";
  DateTime? selectedDate;
  late EditAccountViewModel mProfileViewModel;
  late HomeViewModel mViewModel;

  bool _isStickyVisible = false;

  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mProfileViewModel.attachedContext(context);
      mViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      if (!mViewModel.isPageFinish) {
        mViewModel.getHomePageApi(latitude: gUserLat, longitude: gUserLong);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
        checkProfileDone();
      });
      _scrollController.addListener(
        () {
          if (_scrollController.offset > 80 && !_isStickyVisible) {
            setState(() {
              _isStickyVisible = true;
            });
          } else if (_scrollController.offset <= 80 && _isStickyVisible) {
            setState(
              () {
                _isStickyVisible = false;
              },
            );
          }
        },
      );
    });
  }

  void incrementItem() {
    setState(
      () {
        itemCount++;
      },
    );
  }

  void decrementItem() {
    setState(
      () {
        if (itemCount > 0) {
          itemCount--;
        }
      },
    );
  }

  // void _scrollListener() {
  //   _searchFocusNode.unfocus();
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     if (!mViewModel.isPageFinish) {
  //       mViewModel.getHomePageApi(latitude: gUserLat, longitude: gUserLong);
  //     }
  //   }
  // }

  void _scrollListener() {
    final mViewModel = context.read<HomeViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isLoadingMore &&
        !mViewModel.isPageFinish) {
      // Trigger pagination
      mViewModel.getHomePageApi(
        latitude: gUserLat,
        longitude: gUserLong,
      );
    }
  }

  void checkProfileDone() {
    if (globalUserMaster?.isProfileComplete == "n") {
      profileDialog(context);
    }
  }

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  // @override
  // void dispose() {
  //   // _scrollController.dispose();
  //   // mViewModel.resetPage();
  //   super.dispose();
  // }

  Future<void> profileDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: CommonColors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Dialog(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Container(
                          decoration: BoxDecoration(
                              color: CommonColors.mWhite,
                              borderRadius: BorderRadius.circular(26)),
                          child: Padding(
                            padding: kCommonScreenPadding,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  kCommonSpaceV15,
                                  GestureDetector(
                                    onTap: () async {
                                      final image = await pickSinglePhoto();
                                      if (image != null) {
                                        setState(() {
                                          selectedImage = image;
                                          imagePath = image.path;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 110,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: (() {
                                        if (selectedImage != null) {
                                          // Display the selected image if available
                                          return Image.file(
                                            selectedImage!,
                                            fit: BoxFit.contain,
                                          );
                                        } else if (globalUserMaster?.profile !=
                                            null) {
                                          // Display the user's stored image if available
                                          return Image.network(
                                            globalUserMaster!.profile!,
                                            fit: BoxFit.contain,
                                          );
                                        }
                                        // else {
                                        //   // Display a default icon if no image is available
                                        //   return const Icon(
                                        //     Icons.collections,
                                        //     size: 30,
                                        //     color: CommonColors.primaryColor,
                                        //   );
                                        // }
                                      })(),
                                    ),
                                  ),
                                  kCommonSpaceV20,
                                  TextFormFieldCustom(
                                    textInputType: TextInputType.emailAddress,
                                    controller: nameController,
                                    hintText: "Your Name",
                                    labelText: "Your Name",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (_formKey.currentState?.validate() ==
                                          true) {
                                        _formKey.currentState!.validate();
                                      }
                                    },
                                  ),
                                  kCommonSpaceV10,
                                  TextFormFieldCustom(
                                    textInputType: TextInputType.emailAddress,
                                    controller: emailController,
                                    hintText: "Email",
                                    labelText: "Email",
                                  ),
                                  kCommonSpaceV10,
                                  TextFormFieldCustom(
                                    onTap: () {
                                      selectBirthDate(context);
                                    },
                                    textInputType: TextInputType.emailAddress,
                                    controller: birthDateController,
                                    hintText: "Birth Date",
                                    labelText: "Birth Date",
                                    readOnly: true,
                                  ),
                                  kCommonSpaceV10,
                                  PrimaryButton(
                                    label: "Update",
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        mProfileViewModel.updateProfileApi(
                                            name: nameController.text,
                                            email: emailController.text,
                                            birthday: birthDateController.text,
                                            profile: imagePath);
                                      }
                                    },
                                  ),
                                  kCommonSpaceV15,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    fetchAll("On Refresh");
  }

  fetchAll(String from) {
    // mViewModel.resetPage();
    if (!mViewModel.isPageFinish) {
      mViewModel.getHomePageApi(latitude: gUserLat, longitude: gUserLong);
    }
  }

  @override
  Widget build(BuildContext context) {
    mProfileViewModel = Provider.of<EditAccountViewModel>(context);
    mViewModel = Provider.of<HomeViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: CommonColors.grayShade200,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: CommonColors.grayShade200),
    );
    return SafeArea(
      child: RefreshIndicator(
        color: CommonColors.blackColor,
        backgroundColor: Colors.white,
        onRefresh: _onRefresh,
        displacement: 0,
        child: Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
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
                                            gUserLocation,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: getAppStyle(
                                                fontSize: 14,
                                                height: 1.2,
                                                color: CommonColors.black54),
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_down,
                                            color: CommonColors.black54),
                                        kCommonSpaceH15,
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // profileDialog(context);
                                  mainNavKey.currentContext!
                                      .read<BottomNavbarViewModel>()
                                      .onMenuTapped(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CommonColors.mGrey200),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
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
                        kCommonSpaceV10,
                        const Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: CommonTextField(
                            hintText: "Search",
                            isPrefixIconButton: true,
                            suffixIcon: Icons.mic,
                            isIconButton: true,
                          ),
                        ),
                        kCommonSpaceV10,
                        if (mViewModel.isInitialLoading) ShimmerEffect(),
                        if (!mViewModel.isInitialLoading) ...[
                          for (var section in mViewModel.homePageData)
                            buildSection(section),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
              if (_isStickyVisible == true)
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 4),
                        child: CommonTextField(
                          hintText: "Search",
                          isPrefixIconButton: true,
                          suffixIcon: Icons.mic,
                          isIconButton: true,
                        ),
                      ),
                    ),
                    Container(
                      height: 3,
                      color: CommonColors.mGrey300,
                    )
                  ],
                ),
            ],
          ),
          bottomNavigationBar: itemCount > 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15) +
                      const EdgeInsets.only(top: 14, bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 48,
                        width: 60,
                        margin: const EdgeInsets.only(right: 6),
                        color: Colors.transparent,
                        child: Stack(
                          children: List.generate(
                            itemCount - 1 > 3 ? 3 : itemCount - 1,
                            (index) => Positioned(
                              left: index * 6,
                              child: Container(
                                height: 48,
                                width: 48,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: CommonColors.mGrey500),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error_outline,
                                          color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${itemCount - 1} Items",
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
                      const SizedBox(width: 36),
                      Expanded(
                        child: PrimaryButton(
                          height: 55,
                          label: "View Cart",
                          buttonColor: CommonColors.primaryColor,
                          labelColor: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          onPress: () {
                            // showModalBottomSheet(
                            //   context: context,
                            //   isScrollControlled: true,
                            //   useSafeArea: true,
                            //   backgroundColor: Colors.white,
                            //   builder: (_) {
                            //     return FractionallySizedBox(
                            //       heightFactor: 0.77,
                            //       child: StatefulBuilder(
                            //         builder: (BuildContext context,
                            //             StateSetter setState) {
                            //           return Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                     horizontal: 20) +
                            //                 const EdgeInsets.only(top: 10),
                            //             child: Column(
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       left: 12, right: 12, top: 12),
                            //                   child: Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment
                            //                             .spaceBetween,
                            //                     children: [
                            //                       Column(
                            //                         crossAxisAlignment:
                            //                             CrossAxisAlignment.start,
                            //                         children: [
                            //                           Text(
                            //                             'Review Cart',
                            //                             style: getAppStyle(
                            //                                 fontWeight:
                            //                                     FontWeight.bold,
                            //                                 fontSize: 18),
                            //                           ),
                            //                           Row(
                            //                             children: [
                            //                               Text(
                            //                                 "3 Items • Total",
                            //                                 style: getAppStyle(
                            //                                     color:
                            //                                         CommonColors
                            //                                             .black54),
                            //                               ),
                            //                               Text(
                            //                                 " ₹542",
                            //                                 style: getAppStyle(
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .bold),
                            //                               ),
                            //                             ],
                            //                           )
                            //                         ],
                            //                       ),
                            //                       InkWell(
                            //                         onTap: () {
                            //                           Navigator.pop(context);
                            //                         },
                            //                         child: Container(
                            //                           decoration: BoxDecoration(
                            //                             shape: BoxShape.circle,
                            //                             boxShadow: [
                            //                               BoxShadow(
                            //                                 color: Colors.grey,
                            //                                 offset: const Offset(
                            //                                   2.0,
                            //                                   2.0,
                            //                                 ),
                            //                                 blurRadius: 5.0,
                            //                                 spreadRadius: 0.0,
                            //                               ), //BoxShadow
                            //                               BoxShadow(
                            //                                 color: Colors.white,
                            //                                 offset: const Offset(
                            //                                     0.0, 0.0),
                            //                                 blurRadius: 0.0,
                            //                                 spreadRadius: 0.0,
                            //                               ), //BoxShadow
                            //                             ],
                            //                           ),
                            //                           child: Padding(
                            //                             padding:
                            //                                 const EdgeInsets.all(
                            //                                     8.0),
                            //                             child: Icon(
                            //                               Icons.close,
                            //                               size: 15,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 kCommonSpaceV10,
                            //                 kCommonSpaceV3,
                            //                 Container(
                            //                   height: 3,
                            //                   color: CommonColors.mGrey300,
                            //                 ),
                            //                 Container(
                            //                   height: MediaQuery.of(context)
                            //                           .size
                            //                           .height /
                            //                       1.88,
                            //                   padding: const EdgeInsets.symmetric(
                            //                       horizontal: 12),
                            //                   margin:
                            //                       const EdgeInsets.only(top: 12),
                            //                   decoration: BoxDecoration(
                            //                     border: Border.all(
                            //                         color: CommonColors.mGrey300),
                            //                     borderRadius:
                            //                         BorderRadius.circular(12),
                            //                   ),
                            //                   child: SingleChildScrollView(
                            //                     child: Column(
                            //                       children: [
                            //                         Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                                   left: 12,
                            //                                   right: 12,
                            //                                   top: 12),
                            //                           child: Column(
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment
                            //                                     .start,
                            //                             children: [
                            //                               Row(
                            //                                 children: [
                            //                                   Text(
                            //                                     'Delivery in',
                            //                                     style: getAppStyle(
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold,
                            //                                         fontSize: 18),
                            //                                   ),
                            //                                   const Icon(
                            //                                     Icons
                            //                                         .electric_bolt_rounded,
                            //                                     color: CommonColors
                            //                                         .primaryColor,
                            //                                   ),
                            //                                   Text(
                            //                                     '11 Min',
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .primaryColor,
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold,
                            //                                         fontSize: 18),
                            //                                   ),
                            //                                 ],
                            //                               ),
                            //                               Row(
                            //                                 children: [
                            //                                   Text(
                            //                                     "From ",
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .black54),
                            //                                   ),
                            //                                   Text(
                            //                                     "Soliket",
                            //                                     style: getAppStyle(
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold,
                            //                                         color: CommonColors
                            //                                             .blackColor),
                            //                                   ),
                            //                                   Text(
                            //                                     " • ",
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .blackColor),
                            //                                   ),
                            //                                   Text(
                            //                                     " 6 Items",
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .black54,
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold),
                            //                                   ),
                            //                                   Text(
                            //                                     " • ",
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .blackColor),
                            //                                   ),
                            //                                   Text(
                            //                                     "Delivery 1",
                            //                                     style: getAppStyle(
                            //                                         color: CommonColors
                            //                                             .black54,
                            //                                         fontWeight:
                            //                                             FontWeight
                            //                                                 .bold),
                            //                                   ),
                            //                                 ],
                            //                               )
                            //                             ],
                            //                           ),
                            //                         ),
                            //                         ListView.builder(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                                   top: 12),
                            //                           physics:
                            //                               const ClampingScrollPhysics(),
                            //                           shrinkWrap: true,
                            //                           scrollDirection:
                            //                               Axis.vertical,
                            //                           itemCount: 15,
                            //                           itemBuilder:
                            //                               (BuildContext context,
                            //                                   int index) {
                            //                             return Column(
                            //                               children: [
                            //                                 Row(
                            //                                   crossAxisAlignment:
                            //                                       CrossAxisAlignment
                            //                                           .start,
                            //                                   children: [
                            //                                     CachedNetworkImage(
                            //                                       height: 80,
                            //                                       width: 80,
                            //                                       imageUrl:
                            //                                           "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                            //                                       imageBuilder:
                            //                                           (context,
                            //                                                   imageProvider) =>
                            //                                               Container(
                            //                                         decoration:
                            //                                             BoxDecoration(
                            //                                           image:
                            //                                               DecorationImage(
                            //                                             image:
                            //                                                 imageProvider,
                            //                                             fit: BoxFit
                            //                                                 .contain,
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                       placeholder: (context,
                            //                                               url) =>
                            //                                           const Padding(
                            //                                         padding:
                            //                                             EdgeInsets
                            //                                                 .all(
                            //                                                     12.0),
                            //                                         child: Center(
                            //                                           child:
                            //                                               CircularProgressIndicator(
                            //                                             strokeWidth:
                            //                                                 2,
                            //                                             color: Colors
                            //                                                 .black,
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                       errorWidget: (context,
                            //                                               url,
                            //                                               error) =>
                            //                                           const Center(
                            //                                         child: Icon(
                            //                                           Icons
                            //                                               .error_outline,
                            //                                           color: Colors
                            //                                               .red,
                            //                                         ),
                            //                                       ),
                            //                                     ),
                            //                                     const SizedBox(
                            //                                         width: 14),
                            //                                     Expanded(
                            //                                       child: Column(
                            //                                         crossAxisAlignment:
                            //                                             CrossAxisAlignment
                            //                                                 .start,
                            //                                         mainAxisAlignment:
                            //                                             MainAxisAlignment
                            //                                                 .start,
                            //                                         children: [
                            //                                           Text(
                            //                                             "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                            //                                             maxLines:
                            //                                                 2,
                            //                                             overflow:
                            //                                                 TextOverflow
                            //                                                     .ellipsis,
                            //                                             style:
                            //                                                 getAppStyle(
                            //                                               color: Colors
                            //                                                   .black,
                            //                                               fontWeight:
                            //                                                   FontWeight.w600,
                            //                                               fontSize:
                            //                                                   13,
                            //                                             ),
                            //                                           ),
                            //                                           Padding(
                            //                                             padding: const EdgeInsets
                            //                                                 .symmetric(
                            //                                                 vertical:
                            //                                                     02),
                            //                                             child:
                            //                                                 Row(
                            //                                               children: [
                            //                                                 Text(
                            //                                                   "250 g",
                            //                                                   style:
                            //                                                       getAppStyle(
                            //                                                     color: Colors.grey,
                            //                                                     fontWeight: FontWeight.w500,
                            //                                                     fontSize: 12,
                            //                                                   ),
                            //                                                 ),
                            //                                                 Container(
                            //                                                   margin:
                            //                                                       const EdgeInsets.only(left: 8),
                            //                                                   padding: const EdgeInsets.only(
                            //                                                       left: 6,
                            //                                                       right: 8,
                            //                                                       top: 2,
                            //                                                       bottom: 2),
                            //                                                   decoration:
                            //                                                       BoxDecoration(
                            //                                                     borderRadius: BorderRadius.circular(2),
                            //                                                     color: CommonColors.primaryColor.withOpacity(0.1),
                            //                                                   ),
                            //                                                   child:
                            //                                                       Row(
                            //                                                     children: [
                            //                                                       const Icon(
                            //                                                         Icons.percent_rounded,
                            //                                                         color: CommonColors.primaryColor,
                            //                                                         size: 14,
                            //                                                       ),
                            //                                                       Text(
                            //                                                         "Deal Applied",
                            //                                                         style: getAppStyle(
                            //                                                           color: CommonColors.primaryColor,
                            //                                                           fontWeight: FontWeight.w500,
                            //                                                           fontSize: 10,
                            //                                                         ),
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 )
                            //                                               ],
                            //                                             ),
                            //                                           ),
                            //                                         ],
                            //                                       ),
                            //                                     ),
                            //                                     const SizedBox(
                            //                                         width: 8),
                            //                                     Column(
                            //                                       crossAxisAlignment:
                            //                                           CrossAxisAlignment
                            //                                               .start,
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment
                            //                                               .start,
                            //                                       children: [
                            //                                         Container(
                            //                                           padding: const EdgeInsets
                            //                                               .symmetric(
                            //                                               horizontal:
                            //                                                   4,
                            //                                               vertical:
                            //                                                   4),
                            //                                           margin: const EdgeInsets
                            //                                               .only(
                            //                                               bottom:
                            //                                                   4),
                            //                                           height: 30,
                            //                                           width: 80,
                            //                                           decoration:
                            //                                               BoxDecoration(
                            //                                             borderRadius:
                            //                                                 BorderRadius.circular(
                            //                                                     6),
                            //                                             color: CommonColors
                            //                                                 .primaryColor,
                            //                                           ),
                            //                                           child: Row(
                            //                                             mainAxisAlignment:
                            //                                                 MainAxisAlignment
                            //                                                     .spaceAround,
                            //                                             children: [
                            //                                               GestureDetector(
                            //                                                 onTap: () =>
                            //                                                     decrementItem(),
                            //                                                 child:
                            //                                                     const Icon(
                            //                                                   Icons.remove,
                            //                                                   size:
                            //                                                       16,
                            //                                                   color:
                            //                                                       Colors.white,
                            //                                                 ),
                            //                                               ),
                            //                                               Text(
                            //                                                 itemCount
                            //                                                     .toString(),
                            //                                                 style:
                            //                                                     getAppStyle(
                            //                                                   color:
                            //                                                       Colors.white,
                            //                                                   fontWeight:
                            //                                                       FontWeight.w500,
                            //                                                   fontSize:
                            //                                                       14,
                            //                                                 ),
                            //                                               ),
                            //                                               GestureDetector(
                            //                                                 onTap: () =>
                            //                                                     incrementItem(),
                            //                                                 child:
                            //                                                     const Icon(
                            //                                                   Icons.add,
                            //                                                   size:
                            //                                                       16,
                            //                                                   color:
                            //                                                       Colors.white,
                            //                                                 ),
                            //                                               ),
                            //                                             ],
                            //                                           ),
                            //                                         ),
                            //                                         Row(
                            //                                           children: [
                            //                                             Text(
                            //                                               "₹${"80.0"}",
                            //                                               style:
                            //                                                   getAppStyle(
                            //                                                 decoration:
                            //                                                     TextDecoration.lineThrough,
                            //                                                 color:
                            //                                                     Colors.grey,
                            //                                                 fontWeight:
                            //                                                     FontWeight.w500,
                            //                                                 fontSize:
                            //                                                     12,
                            //                                               ),
                            //                                             ),
                            //                                             const SizedBox(
                            //                                                 width:
                            //                                                     4),
                            //                                             Text(
                            //                                               "₹${"250.0"}",
                            //                                               style:
                            //                                                   getAppStyle(
                            //                                                 color:
                            //                                                     Colors.black,
                            //                                                 fontWeight:
                            //                                                     FontWeight.bold,
                            //                                                 fontSize:
                            //                                                     13,
                            //                                               ),
                            //                                             ),
                            //                                           ],
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ],
                            //                                 ),
                            //                                 const SizedBox(
                            //                                     height: 10)
                            //                               ],
                            //                             );
                            //                           },
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 const Spacer(),
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: 20),
                            //                   child: Row(
                            //                     children: [
                            //                       Container(
                            //                         height: 48,
                            //                         width: 60,
                            //                         margin: const EdgeInsets.only(
                            //                             right: 6),
                            //                         color: Colors.transparent,
                            //                         child: Stack(
                            //                           children: List.generate(
                            //                             itemCount - 1 > 3
                            //                                 ? 3
                            //                                 : itemCount - 1,
                            //                             (index) => Positioned(
                            //                               left: index * 6,
                            //                               child: Container(
                            //                                 height: 48,
                            //                                 width: 48,
                            //                                 padding:
                            //                                     const EdgeInsets
                            //                                         .symmetric(
                            //                                         horizontal: 6,
                            //                                         vertical: 2),
                            //                                 decoration:
                            //                                     BoxDecoration(
                            //                                   color: Colors.white,
                            //                                   border: Border.all(
                            //                                       color: CommonColors
                            //                                           .mGrey500),
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               8),
                            //                                 ),
                            //                                 child:
                            //                                     CachedNetworkImage(
                            //                                   imageUrl:
                            //                                       "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                            //                                   fit: BoxFit.cover,
                            //                                   placeholder: (context,
                            //                                           url) =>
                            //                                       const Center(
                            //                                           child: SizedBox(
                            //                                               height:
                            //                                                   10,
                            //                                               width:
                            //                                                   10,
                            //                                               child:
                            //                                                   CircularProgressIndicator())),
                            //                                   errorWidget: (context,
                            //                                           url,
                            //                                           error) =>
                            //                                       const Icon(
                            //                                           Icons
                            //                                               .error_outline,
                            //                                           color: Colors
                            //                                               .red),
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
                            //                                   FontWeight.w500,
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
                            //                           buttonColor: CommonColors
                            //                               .primaryColor,
                            //                           labelColor: Colors.white,
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   14),
                            //                           onPress: () {
                            //                             showModalBottomSheet(
                            //                               context: context,
                            //                               isScrollControlled:
                            //                                   true,
                            //                               useSafeArea: true,
                            //                               backgroundColor:
                            //                                   Colors.white,
                            //                               builder: (_) {
                            //                                 return FractionallySizedBox(
                            //                                   heightFactor: 0.77,
                            //                                   child:
                            //                                       StatefulBuilder(
                            //                                     builder: (BuildContext
                            //                                             context,
                            //                                         StateSetter
                            //                                             setState) {
                            //                                       return Padding(
                            //                                         padding: const EdgeInsets
                            //                                                 .symmetric(
                            //                                                 horizontal:
                            //                                                     20) +
                            //                                             const EdgeInsets
                            //                                                 .only(
                            //                                                 top:
                            //                                                     10),
                            //                                         child: Column(
                            //                                           children: [
                            //                                             Padding(
                            //                                               padding: const EdgeInsets
                            //                                                   .only(
                            //                                                   left:
                            //                                                       12,
                            //                                                   right:
                            //                                                       12,
                            //                                                   top:
                            //                                                       12),
                            //                                               child:
                            //                                                   Row(
                            //                                                 mainAxisAlignment:
                            //                                                     MainAxisAlignment.spaceBetween,
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
                            //                                                   3,
                            //                                               color: CommonColors
                            //                                                   .mGrey300,
                            //                                             ),
                            //                                             Container(
                            //                                               height: MediaQuery.of(context).size.height /
                            //                                                   1.82,
                            //                                               padding: const EdgeInsets
                            //                                                   .symmetric(
                            //                                                   horizontal:
                            //                                                       12),
                            //                                               margin: const EdgeInsets
                            //                                                   .only(
                            //                                                   top:
                            //                                                       12),
                            //                                               decoration:
                            //                                                   BoxDecoration(
                            //                                                 color:
                            //                                                     Colors.red,
                            //                                                 borderRadius:
                            //                                                     BorderRadius.circular(12),
                            //                                               ),
                            //                                               child:
                            //                                                   SingleChildScrollView(
                            //                                                 child:
                            //                                                     ListView.builder(
                            //                                                   padding:
                            //                                                       const EdgeInsets.only(top: 12),
                            //                                                   physics:
                            //                                                       const ClampingScrollPhysics(),
                            //                                                   shrinkWrap:
                            //                                                       true,
                            //                                                   scrollDirection:
                            //                                                       Axis.vertical,
                            //                                                   itemCount:
                            //                                                       15,
                            //                                                   itemBuilder:
                            //                                                       (BuildContext context, int index) {
                            //                                                     return Column(
                            //                                                       children: [
                            //                                                         Row(
                            //                                                           crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                           children: [
                            //                                                             CachedNetworkImage(
                            //                                                               height: 80,
                            //                                                               width: 80,
                            //                                                               imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                            //                                                               imageBuilder: (context, imageProvider) => Container(
                            //                                                                 decoration: BoxDecoration(
                            //                                                                   image: DecorationImage(
                            //                                                                     image: imageProvider,
                            //                                                                     fit: BoxFit.contain,
                            //                                                                   ),
                            //                                                                 ),
                            //                                                               ),
                            //                                                               placeholder: (context, url) => const Padding(
                            //                                                                 padding: EdgeInsets.all(12.0),
                            //                                                                 child: Center(
                            //                                                                   child: CircularProgressIndicator(
                            //                                                                     strokeWidth: 2,
                            //                                                                     color: Colors.black,
                            //                                                                   ),
                            //                                                                 ),
                            //                                                               ),
                            //                                                               errorWidget: (context, url, error) => const Center(
                            //                                                                 child: Icon(
                            //                                                                   Icons.error_outline,
                            //                                                                   color: Colors.red,
                            //                                                                 ),
                            //                                                               ),
                            //                                                             ),
                            //                                                             const SizedBox(width: 14),
                            //                                                             Expanded(
                            //                                                               child: Column(
                            //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                                 mainAxisAlignment: MainAxisAlignment.start,
                            //                                                                 children: [
                            //                                                                   Text(
                            //                                                                     "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
                            //                                                                     maxLines: 2,
                            //                                                                     overflow: TextOverflow.ellipsis,
                            //                                                                     style: getAppStyle(
                            //                                                                       color: Colors.black,
                            //                                                                       fontWeight: FontWeight.w600,
                            //                                                                       fontSize: 13,
                            //                                                                     ),
                            //                                                                   ),
                            //                                                                   Padding(
                            //                                                                     padding: const EdgeInsets.symmetric(vertical: 02),
                            //                                                                     child: Text(
                            //                                                                       "250 g",
                            //                                                                       style: getAppStyle(
                            //                                                                         color: Colors.grey,
                            //                                                                         fontWeight: FontWeight.w500,
                            //                                                                         fontSize: 12,
                            //                                                                       ),
                            //                                                                     ),
                            //                                                                   ),
                            //                                                                 ],
                            //                                                               ),
                            //                                                             ),
                            //                                                             const SizedBox(width: 8),
                            //                                                             Column(
                            //                                                               crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                               mainAxisAlignment: MainAxisAlignment.start,
                            //                                                               children: [
                            //                                                                 Container(
                            //                                                                   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            //                                                                   margin: const EdgeInsets.only(bottom: 4),
                            //                                                                   height: 30,
                            //                                                                   width: 80,
                            //                                                                   decoration: BoxDecoration(
                            //                                                                     borderRadius: BorderRadius.circular(6),
                            //                                                                     color: CommonColors.primaryColor,
                            //                                                                   ),
                            //                                                                   child: Row(
                            //                                                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                                                                     children: [
                            //                                                                       GestureDetector(
                            //                                                                         onTap: () => decrementItem(),
                            //                                                                         child: const Icon(
                            //                                                                           Icons.remove,
                            //                                                                           size: 16,
                            //                                                                           color: Colors.white,
                            //                                                                         ),
                            //                                                                       ),
                            //                                                                       Text(
                            //                                                                         itemCount.toString(),
                            //                                                                         style: getAppStyle(
                            //                                                                           color: Colors.white,
                            //                                                                           fontWeight: FontWeight.w500,
                            //                                                                           fontSize: 14,
                            //                                                                         ),
                            //                                                                       ),
                            //                                                                       GestureDetector(
                            //                                                                         onTap: () => incrementItem(),
                            //                                                                         child: const Icon(
                            //                                                                           Icons.add,
                            //                                                                           size: 16,
                            //                                                                           color: Colors.white,
                            //                                                                         ),
                            //                                                                       ),
                            //                                                                     ],
                            //                                                                   ),
                            //                                                                 ),
                            //                                                                 Row(
                            //                                                                   children: [
                            //                                                                     Text(
                            //                                                                       "₹${"80.0"}",
                            //                                                                       style: getAppStyle(
                            //                                                                         decoration: TextDecoration.lineThrough,
                            //                                                                         color: Colors.grey,
                            //                                                                         fontWeight: FontWeight.w500,
                            //                                                                         fontSize: 12,
                            //                                                                       ),
                            //                                                                     ),
                            //                                                                     const SizedBox(width: 4),
                            //                                                                     Text(
                            //                                                                       "₹${"250.0"}",
                            //                                                                       style: getAppStyle(
                            //                                                                         color: Colors.black,
                            //                                                                         fontWeight: FontWeight.bold,
                            //                                                                         fontSize: 13,
                            //                                                                       ),
                            //                                                                     ),
                            //                                                                   ],
                            //                                                                 ),
                            //                                                               ],
                            //                                                             ),
                            //                                                           ],
                            //                                                         ),
                            //                                                         const SizedBox(height: 10)
                            //                                                       ],
                            //                                                     );
                            //                                                   },
                            //                                                 ),
                            //                                               ),
                            //                                             ),
                            //                                             const Spacer(),
                            //                                             Padding(
                            //                                               padding: const EdgeInsets
                            //                                                   .only(
                            //                                                   top:
                            //                                                       10,
                            //                                                   bottom:
                            //                                                       20),
                            //                                               child:
                            //                                                   Row(
                            //                                                 children: [
                            //                                                   Container(
                            //                                                     height: 42,
                            //                                                     width: 58,
                            //                                                     margin: const EdgeInsets.only(right: 10),
                            //                                                     color: Colors.transparent,
                            //                                                     child: Stack(
                            //                                                       children: [
                            //                                                         Container(
                            //                                                           height: 42,
                            //                                                           width: 42,
                            //                                                           decoration: BoxDecoration(
                            //                                                             color: Colors.white,
                            //                                                             border: Border.all(color: Colors.grey),
                            //                                                             borderRadius: BorderRadius.circular(10),
                            //                                                           ),
                            //                                                         ),
                            //                                                         Positioned(
                            //                                                           left: 8,
                            //                                                           child: Container(
                            //                                                             height: 42,
                            //                                                             width: 42,
                            //                                                             decoration: BoxDecoration(
                            //                                                               color: Colors.white,
                            //                                                               border: Border.all(color: Colors.grey),
                            //                                                               borderRadius: BorderRadius.circular(10),
                            //                                                             ),
                            //                                                           ),
                            //                                                         ),
                            //                                                         Positioned(
                            //                                                           left: 16,
                            //                                                           child: Container(
                            //                                                             height: 42,
                            //                                                             width: 42,
                            //                                                             decoration: BoxDecoration(
                            //                                                               color: Colors.white,
                            //                                                               border: Border.all(color: Colors.grey),
                            //                                                               borderRadius: BorderRadius.circular(10),
                            //                                                             ),
                            //                                                             child: CachedNetworkImage(
                            //                                                               height: 80,
                            //                                                               width: 80,
                            //                                                               imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
                            //                                                               imageBuilder: (context, imageProvider) => Container(
                            //                                                                 decoration: BoxDecoration(
                            //                                                                   image: DecorationImage(
                            //                                                                     image: imageProvider,
                            //                                                                     fit: BoxFit.contain,
                            //                                                                   ),
                            //                                                                 ),
                            //                                                               ),
                            //                                                               placeholder: (context, url) => const Padding(
                            //                                                                 padding: EdgeInsets.all(12.0),
                            //                                                                 child: Center(
                            //                                                                   child: CircularProgressIndicator(
                            //                                                                     strokeWidth: 2,
                            //                                                                     color: Colors.black,
                            //                                                                   ),
                            //                                                                 ),
                            //                                                               ),
                            //                                                               errorWidget: (context, url, error) => const Center(
                            //                                                                 child: Icon(
                            //                                                                   Icons.error_outline,
                            //                                                                   color: Colors.red,
                            //                                                                 ),
                            //                                                               ),
                            //                                                             ),
                            //                                                           ),
                            //                                                         ),
                            //                                                       ],
                            //                                                     ),
                            //                                                   ),
                            //                                                   InkWell(
                            //                                                     onTap: () {
                            //                                                       debugPrint("OnTap");
                            //                                                     },
                            //                                                     child: Row(
                            //                                                       children: [
                            //                                                         Text(
                            //                                                           "6 Item",
                            //                                                           style: getAppStyle(
                            //                                                             color: Colors.black,
                            //                                                             fontWeight: FontWeight.w500,
                            //                                                             fontSize: 12,
                            //                                                           ),
                            //                                                         ),
                            //                                                         const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                            //                                                       ],
                            //                                                     ),
                            //                                                   ),
                            //                                                   const SizedBox(width: 20),
                            //                                                   Expanded(
                            //                                                     child: GestureDetector(
                            //                                                       onTap: () {
                            //                                                         debugPrint("On Tap Sub Product");
                            //                                                       },
                            //                                                       child: Container(
                            //                                                         height: 40,
                            //                                                         decoration: BoxDecoration(
                            //                                                           borderRadius: BorderRadius.circular(6),
                            //                                                           color: CommonColors.primaryColor,
                            //                                                         ),
                            //                                                         child: Center(
                            //                                                           child: Text(
                            //                                                             "View Cart",
                            //                                                             style: getAppStyle(
                            //                                                               color: Colors.white,
                            //                                                               fontWeight: FontWeight.bold,
                            //                                                               fontSize: 14,
                            //                                                             ),
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
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
                            //                           },
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget buildSection(Section sectionData) {
    switch (sectionData.type) {
      case 'section_10':
        return Section10(title: mViewModel.section10Text);

      case 'section_1':
        return Section1(
          section1: sectionData.data,
        );

      case 'section_2':
        return Section2(
          section2: sectionData.data,
          section2Title: sectionData.sectionTitle,
        );

      case 'section_3':
        return Section3(
          section3: sectionData.data,
          section3Title: sectionData.sectionTitle,
        );

      case 'section_4':
        return Section4(
          section4: sectionData.data,
          section4Title: sectionData.sectionTitle,
          // onAddItem: incrementItem,
          // onRemoveItem: decrementItem,
          onAddItem: (variantId) async {
            await mViewModel.addToCartApi(
                variantId: variantId.toString(), type: 'p');
          },
          onRemoveItem: (variantId) async {
            await mViewModel.addToCartApi(
                variantId: variantId.toString(), type: 'm');
          },
        );

      case 'section_5':
        return Section5(
          section5: sectionData.data,
        );

      case 'section_6':
        if (sectionData.data is Section6Data) {
          var section6Data = sectionData.data;
          return Section6(
            section6: [section6Data],
          );
        }
        break;

      case 'section_7':
        return Section7(
          section7: sectionData.data,
          section7Title: sectionData.sectionTitle,
        );

      case 'section_8':
        return Section8(
          section8: sectionData.data,
          section8Title: sectionData.sectionTitle,
        );

      case 'section_9':
        if (sectionData.data is Section9Data) {
          var section9Data = sectionData.data;
          return Section9(
            section9: [section9Data],
          );
        }
        break;
    }

    return Container();
  }
}

/// another bottom sheet top and bottom fixed and middle scrolled

// onTap: () {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.white,
//     builder: (_) {
//       return StatefulBuilder(
//         builder: (BuildContext context,
//             StateSetter setState) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                     horizontal: 20) +
//                 const EdgeInsets.only(top: 10),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 12, right: 12, top: 12),
//                   child: Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment
//                             .spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Review Cart',
//                             style: getAppStyle(
//                                 fontWeight:
//                                     FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "3 Items • Total",
//                                 style: getAppStyle(
//                                     color:
//                                         CommonColors
//                                             .black54),
//                               ),
//                               Text(
//                                 " ₹542",
//                                 style: getAppStyle(
//                                     fontWeight:
//                                         FontWeight
//                                             .bold),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 offset: const Offset(
//                                   2.0,
//                                   2.0,
//                                 ),
//                                 blurRadius: 5.0,
//                                 spreadRadius: 0.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: const Offset(
//                                     0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ), //BoxShadow
//                             ],
//                           ),
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.all(
//                                     8.0),
//                             child: Icon(
//                               Icons.close,
//                               size: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 kCommonSpaceV10,
//                 kCommonSpaceV3,
//                 Container(
//                   height: 3,
//                   color: CommonColors.mGrey300,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.only(
//                           top: 12),
//                       physics:
//                           NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: 6,
//                       itemBuilder:
//                           (BuildContext context,
//                               int index) {
//                         return Column(
//                           children: [
//                             Row(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                               children: [
//                                 CachedNetworkImage(
//                                   height: 80,
//                                   width: 80,
//                                   imageUrl:
//                                       "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                   imageBuilder: (context,
//                                           imageProvider) =>
//                                       Container(
//                                     decoration:
//                                         BoxDecoration(
//                                       image:
//                                           DecorationImage(
//                                         image:
//                                             imageProvider,
//                                         fit: BoxFit
//                                             .contain,
//                                       ),
//                                     ),
//                                   ),
//                                   placeholder: (context,
//                                           url) =>
//                                       const Padding(
//                                     padding:
//                                         EdgeInsets
//                                             .all(
//                                                 12.0),
//                                     child: Center(
//                                       child:
//                                           CircularProgressIndicator(
//                                         strokeWidth:
//                                             2,
//                                         color: Colors
//                                             .black,
//                                       ),
//                                     ),
//                                   ),
//                                   errorWidget: (context,
//                                           url,
//                                           error) =>
//                                       const Center(
//                                     child: Icon(
//                                       Icons
//                                           .error_outline,
//                                       color:
//                                           Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                     width: 14),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .start,
//                                     children: [
//                                       Text(
//                                         "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
//                                         maxLines: 2,
//                                         overflow:
//                                             TextOverflow
//                                                 .ellipsis,
//                                         style:
//                                             getAppStyle(
//                                           color: Colors
//                                               .black,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               13,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets
//                                             .symmetric(
//                                             vertical:
//                                                 02),
//                                         child: Text(
//                                           "250 g",
//                                           style:
//                                               getAppStyle(
//                                             color: Colors
//                                                 .grey,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w500,
//                                             fontSize:
//                                                 12,
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
//                                       CrossAxisAlignment
//                                           .start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .start,
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets
//                                           .symmetric(
//                                           horizontal:
//                                               4,
//                                           vertical:
//                                               4),
//                                       margin:
//                                           const EdgeInsets
//                                               .only(
//                                               bottom:
//                                                   4),
//                                       height: 30,
//                                       width: 80,
//                                       decoration:
//                                           BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius
//                                                 .circular(
//                                                     6),
//                                         color: CommonColors
//                                             .primaryColor,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceAround,
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () =>
//                                                 decrementItem(),
//                                             child:
//                                                 const Icon(
//                                               Icons
//                                                   .remove,
//                                               size:
//                                                   16,
//                                               color: Colors
//                                                   .white,
//                                             ),
//                                           ),
//                                           Text(
//                                             itemCount
//                                                 .toString(),
//                                             style:
//                                                 getAppStyle(
//                                               color: Colors
//                                                   .white,
//                                               fontWeight:
//                                                   FontWeight.w500,
//                                               fontSize:
//                                                   14,
//                                             ),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () =>
//                                                 incrementItem(),
//                                             child:
//                                                 const Icon(
//                                               Icons
//                                                   .add,
//                                               size:
//                                                   16,
//                                               color: Colors
//                                                   .white,
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
//                                               getAppStyle(
//                                             decoration:
//                                                 TextDecoration
//                                                     .lineThrough,
//                                             color: Colors
//                                                 .grey,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w500,
//                                             fontSize:
//                                                 12,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                             width: 4),
//                                         Text(
//                                           "₹${"250.0"}",
//                                           style:
//                                               getAppStyle(
//                                             color: Colors
//                                                 .black,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .bold,
//                                             fontSize:
//                                                 13,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10)
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       height: 48,
//                       width: 60,
//                       margin: const EdgeInsets.only(
//                           right: 6),
//                       color: Colors.transparent,
//                       child: Stack(
//                         children: List.generate(
//                           3,
//                           (index) => Positioned(
//                             left: index * 6,
//                             child: Container(
//                               height: 48,
//                               width: 48,
//                               padding:
//                                   const EdgeInsets
//                                       .symmetric(
//                                       horizontal: 6,
//                                       vertical: 2),
//                               decoration:
//                                   BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: CommonColors
//                                         .mGrey500),
//                                 borderRadius:
//                                     BorderRadius
//                                         .circular(8),
//                               ),
//                               child:
//                                   CachedNetworkImage(
//                                 imageUrl:
//                                     "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                 fit: BoxFit.cover,
//                                 placeholder: (context,
//                                         url) =>
//                                     const Center(
//                                         child: SizedBox(
//                                             height:
//                                                 10,
//                                             width: 10,
//                                             child:
//                                                 CircularProgressIndicator())),
//                                 errorWidget: (context,
//                                         url, error) =>
//                                     const Icon(
//                                         Icons
//                                             .error_outline,
//                                         color: Colors
//                                             .red),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "${itemCount - 1} Items",
//                           style: getAppStyle(
//                             color: CommonColors
//                                 .blackColor,
//                             fontWeight:
//                                 FontWeight.w500,
//                             fontSize: 12,
//                           ),
//                         ),
//                         const Icon(
//                           Icons.arrow_drop_up_rounded,
//                           color: CommonColors
//                               .primaryColor,
//                           size: 30,
//                         )
//                       ],
//                     ),
//                     const SizedBox(width: 36),
//                     Expanded(
//                       child: PrimaryButton(
//                         height: 55,
//                         label: "View Cart",
//                         buttonColor:
//                             CommonColors.primaryColor,
//                         labelColor: Colors.white,
//                         borderRadius:
//                             BorderRadius.circular(14),
//                         onPress: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             useSafeArea: true,
//                             backgroundColor:
//                                 Colors.white,
//                             builder: (_) {
//                               return FractionallySizedBox(
//                                 heightFactor: 0.77,
//                                 child:
//                                     StatefulBuilder(
//                                   builder: (BuildContext
//                                           context,
//                                       StateSetter
//                                           setState) {
//                                     return Padding(
//                                       padding: const EdgeInsets
//                                               .symmetric(
//                                               horizontal:
//                                                   20) +
//                                           const EdgeInsets
//                                               .only(
//                                               top:
//                                                   10),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets
//                                                 .only(
//                                                 left:
//                                                     12,
//                                                 right:
//                                                     12,
//                                                 top:
//                                                     12),
//                                             child:
//                                                 Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       'Review Cart',
//                                                       style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Text(
//                                                           "3 Items • Total",
//                                                           style: getAppStyle(color: CommonColors.black54),
//                                                         ),
//                                                         Text(
//                                                           " ₹542",
//                                                           style: getAppStyle(fontWeight: FontWeight.bold),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                                 InkWell(
//                                                   onTap:
//                                                       () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child:
//                                                       Container(
//                                                     decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Colors.grey,
//                                                           offset: const Offset(
//                                                             2.0,
//                                                             2.0,
//                                                           ),
//                                                           blurRadius: 5.0,
//                                                           spreadRadius: 0.0,
//                                                         ), //BoxShadow
//                                                         BoxShadow(
//                                                           color: Colors.white,
//                                                           offset: const Offset(0.0, 0.0),
//                                                           blurRadius: 0.0,
//                                                           spreadRadius: 0.0,
//                                                         ), //BoxShadow
//                                                       ],
//                                                     ),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.all(8.0),
//                                                       child: Icon(
//                                                         Icons.close,
//                                                         size: 15,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           kCommonSpaceV10,
//                                           kCommonSpaceV3,
//                                           Container(
//                                             height: 3,
//                                             color: CommonColors
//                                                 .mGrey300,
//                                           ),
//                                           Container(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 1.88,
//                                             padding: const EdgeInsets
//                                                 .symmetric(
//                                                 horizontal:
//                                                     12),
//                                             margin: const EdgeInsets
//                                                 .only(
//                                                 top:
//                                                     12),
//                                             decoration:
//                                                 BoxDecoration(
//                                               border: Border.all(
//                                                   color:
//                                                       CommonColors.mGrey300),
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                             child:
//                                                 SingleChildScrollView(
//                                               child:
//                                                   Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             Text(
//                                                               'Delivery in',
//                                                               style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                                                             ),
//                                                             const Icon(
//                                                               Icons.electric_bolt_rounded,
//                                                               color: CommonColors.primaryColor,
//                                                             ),
//                                                             Text(
//                                                               '11 Min',
//                                                               style: getAppStyle(color: CommonColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Text(
//                                                               "From ",
//                                                               style: getAppStyle(color: CommonColors.black54),
//                                                             ),
//                                                             Text(
//                                                               "Soliket",
//                                                               style: getAppStyle(fontWeight: FontWeight.bold, color: CommonColors.blackColor),
//                                                             ),
//                                                             Text(
//                                                               " • ",
//                                                               style: getAppStyle(color: CommonColors.blackColor),
//                                                             ),
//                                                             Text(
//                                                               " 6 Items",
//                                                               style: getAppStyle(color: CommonColors.black54, fontWeight: FontWeight.bold),
//                                                             ),
//                                                             Text(
//                                                               " • ",
//                                                               style: getAppStyle(color: CommonColors.blackColor),
//                                                             ),
//                                                             Text(
//                                                               "Delivery 1",
//                                                               style: getAppStyle(color: CommonColors.black54, fontWeight: FontWeight.bold),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   ListView.builder(
//                                                     padding: const EdgeInsets.only(top: 12),
//                                                     physics: const ClampingScrollPhysics(),
//                                                     shrinkWrap: true,
//                                                     scrollDirection: Axis.vertical,
//                                                     itemCount: 15,
//                                                     itemBuilder: (BuildContext context, int index) {
//                                                       return Column(
//                                                         children: [
//                                                           Row(
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               CachedNetworkImage(
//                                                                 height: 80,
//                                                                 width: 80,
//                                                                 imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                                                 imageBuilder: (context, imageProvider) => Container(
//                                                                   decoration: BoxDecoration(
//                                                                     image: DecorationImage(
//                                                                       image: imageProvider,
//                                                                       fit: BoxFit.contain,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 placeholder: (context, url) => const Padding(
//                                                                   padding: EdgeInsets.all(12.0),
//                                                                   child: Center(
//                                                                     child: CircularProgressIndicator(
//                                                                       strokeWidth: 2,
//                                                                       color: Colors.black,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 errorWidget: (context, url, error) => const Center(
//                                                                   child: Icon(
//                                                                     Icons.error_outline,
//                                                                     color: Colors.red,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(width: 14),
//                                                               Expanded(
//                                                                 child: Column(
//                                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                   children: [
//                                                                     Text(
//                                                                       "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
//                                                                       maxLines: 2,
//                                                                       overflow: TextOverflow.ellipsis,
//                                                                       style: getAppStyle(
//                                                                         color: Colors.black,
//                                                                         fontWeight: FontWeight.w600,
//                                                                         fontSize: 13,
//                                                                       ),
//                                                                     ),
//                                                                     Padding(
//                                                                       padding: const EdgeInsets.symmetric(vertical: 02),
//                                                                       child: Row(
//                                                                         children: [
//                                                                           Text(
//                                                                             "250 g",
//                                                                             style: getAppStyle(
//                                                                               color: Colors.grey,
//                                                                               fontWeight: FontWeight.w500,
//                                                                               fontSize: 12,
//                                                                             ),
//                                                                           ),
//                                                                           Container(
//                                                                             margin: const EdgeInsets.only(left: 8),
//                                                                             padding: const EdgeInsets.only(left: 6, right: 8, top: 2, bottom: 2),
//                                                                             decoration: BoxDecoration(
//                                                                               borderRadius: BorderRadius.circular(2),
//                                                                               color: CommonColors.primaryColor.withOpacity(0.1),
//                                                                             ),
//                                                                             child: Row(
//                                                                               children: [
//                                                                                 const Icon(
//                                                                                   Icons.percent_rounded,
//                                                                                   color: CommonColors.primaryColor,
//                                                                                   size: 14,
//                                                                                 ),
//                                                                                 Text(
//                                                                                   "Deal Applied",
//                                                                                   style: getAppStyle(
//                                                                                     color: CommonColors.primaryColor,
//                                                                                     fontWeight: FontWeight.w500,
//                                                                                     fontSize: 10,
//                                                                                   ),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               const SizedBox(width: 8),
//                                                               Column(
//                                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                                 children: [
//                                                                   Container(
//                                                                     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                                                                     margin: const EdgeInsets.only(bottom: 4),
//                                                                     height: 30,
//                                                                     width: 80,
//                                                                     decoration: BoxDecoration(
//                                                                       borderRadius: BorderRadius.circular(6),
//                                                                       color: CommonColors.primaryColor,
//                                                                     ),
//                                                                     child: Row(
//                                                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                       children: [
//                                                                         GestureDetector(
//                                                                           onTap: () => decrementItem(),
//                                                                           child: const Icon(
//                                                                             Icons.remove,
//                                                                             size: 16,
//                                                                             color: Colors.white,
//                                                                           ),
//                                                                         ),
//                                                                         Text(
//                                                                           itemCount.toString(),
//                                                                           style: getAppStyle(
//                                                                             color: Colors.white,
//                                                                             fontWeight: FontWeight.w500,
//                                                                             fontSize: 14,
//                                                                           ),
//                                                                         ),
//                                                                         GestureDetector(
//                                                                           onTap: () => incrementItem(),
//                                                                           child: const Icon(
//                                                                             Icons.add,
//                                                                             size: 16,
//                                                                             color: Colors.white,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Row(
//                                                                     children: [
//                                                                       Text(
//                                                                         "₹${"80.0"}",
//                                                                         style: getAppStyle(
//                                                                           decoration: TextDecoration.lineThrough,
//                                                                           color: Colors.grey,
//                                                                           fontWeight: FontWeight.w500,
//                                                                           fontSize: 12,
//                                                                         ),
//                                                                       ),
//                                                                       const SizedBox(width: 4),
//                                                                       Text(
//                                                                         "₹${"250.0"}",
//                                                                         style: getAppStyle(
//                                                                           color: Colors.black,
//                                                                           fontWeight: FontWeight.bold,
//                                                                           fontSize: 13,
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           const SizedBox(height: 10)
//                                                         ],
//                                                       );
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           Padding(
//                                             padding: const EdgeInsets
//                                                 .only(
//                                                 bottom:
//                                                     20),
//                                             child:
//                                                 Row(
//                                               children: [
//                                                 Container(
//                                                   height:
//                                                       48,
//                                                   width:
//                                                       60,
//                                                   margin:
//                                                       const EdgeInsets.only(right: 6),
//                                                   color:
//                                                       Colors.transparent,
//                                                   child:
//                                                       Stack(
//                                                     children: List.generate(
//                                                       itemCount - 1 > 3 ? 3 : itemCount - 1,
//                                                       (index) => Positioned(
//                                                         left: index * 6,
//                                                         child: Container(
//                                                           height: 48,
//                                                           width: 48,
//                                                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                                           decoration: BoxDecoration(
//                                                             color: Colors.white,
//                                                             border: Border.all(color: CommonColors.mGrey500),
//                                                             borderRadius: BorderRadius.circular(8),
//                                                           ),
//                                                           child: CachedNetworkImage(
//                                                             imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                                             fit: BoxFit.cover,
//                                                             placeholder: (context, url) => const Center(child: SizedBox(height: 10, width: 10, child: CircularProgressIndicator())),
//                                                             errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       "${itemCount - 1} Items",
//                                                       style: getAppStyle(
//                                                         color: CommonColors.blackColor,
//                                                         fontWeight: FontWeight.w500,
//                                                         fontSize: 12,
//                                                       ),
//                                                     ),
//                                                     const Icon(
//                                                       Icons.arrow_drop_up_rounded,
//                                                       color: CommonColors.primaryColor,
//                                                       size: 30,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 const SizedBox(
//                                                     width: 36),
//                                                 Expanded(
//                                                   child:
//                                                       PrimaryButton(
//                                                     height: 55,
//                                                     label: "View Cart",
//                                                     buttonColor: CommonColors.primaryColor,
//                                                     labelColor: Colors.white,
//                                                     borderRadius: BorderRadius.circular(14),
//                                                     onPress: () {
//                                                       showModalBottomSheet(
//                                                         context: context,
//                                                         isScrollControlled: true,
//                                                         useSafeArea: true,
//                                                         backgroundColor: Colors.white,
//                                                         builder: (_) {
//                                                           return FractionallySizedBox(
//                                                             heightFactor: 0.77,
//                                                             child: StatefulBuilder(
//                                                               builder: (BuildContext context, StateSetter setState) {
//                                                                 return Padding(
//                                                                   padding: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 10),
//                                                                   child: Column(
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
//                                                                         child: Row(
//                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                           children: [
//                                                                             Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                                               children: [
//                                                                                 Text(
//                                                                                   'Review Cart',
//                                                                                   style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                                                                                 ),
//                                                                                 Row(
//                                                                                   children: [
//                                                                                     Text(
//                                                                                       "3 Items • Total",
//                                                                                       style: getAppStyle(color: CommonColors.black54),
//                                                                                     ),
//                                                                                     Text(
//                                                                                       " ₹542",
//                                                                                       style: getAppStyle(fontWeight: FontWeight.bold),
//                                                                                     ),
//                                                                                   ],
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                             InkWell(
//                                                                               onTap: () {
//                                                                                 Navigator.pop(context);
//                                                                               },
//                                                                               child: Container(
//                                                                                 decoration: BoxDecoration(
//                                                                                   shape: BoxShape.circle,
//                                                                                   boxShadow: [
//                                                                                     BoxShadow(
//                                                                                       color: Colors.grey,
//                                                                                       offset: const Offset(
//                                                                                         2.0,
//                                                                                         2.0,
//                                                                                       ),
//                                                                                       blurRadius: 5.0,
//                                                                                       spreadRadius: 0.0,
//                                                                                     ), //BoxShadow
//                                                                                     BoxShadow(
//                                                                                       color: Colors.white,
//                                                                                       offset: const Offset(0.0, 0.0),
//                                                                                       blurRadius: 0.0,
//                                                                                       spreadRadius: 0.0,
//                                                                                     ), //BoxShadow
//                                                                                   ],
//                                                                                 ),
//                                                                                 child: Padding(
//                                                                                   padding: const EdgeInsets.all(8.0),
//                                                                                   child: Icon(
//                                                                                     Icons.close,
//                                                                                     size: 15,
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                       kCommonSpaceV10,
//                                                                       kCommonSpaceV3,
//                                                                       Container(
//                                                                         height: 3,
//                                                                         color: CommonColors.mGrey300,
//                                                                       ),
//                                                                       Container(
//                                                                         height: MediaQuery.of(context).size.height / 1.82,
//                                                                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                                                                         margin: const EdgeInsets.only(top: 12),
//                                                                         decoration: BoxDecoration(
//                                                                           color: Colors.red,
//                                                                           borderRadius: BorderRadius.circular(12),
//                                                                         ),
//                                                                         child: SingleChildScrollView(
//                                                                           child: ListView.builder(
//                                                                             padding: const EdgeInsets.only(top: 12),
//                                                                             physics: const ClampingScrollPhysics(),
//                                                                             shrinkWrap: true,
//                                                                             scrollDirection: Axis.vertical,
//                                                                             itemCount: 15,
//                                                                             itemBuilder: (BuildContext context, int index) {
//                                                                               return Column(
//                                                                                 children: [
//                                                                                   Row(
//                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                     children: [
//                                                                                       CachedNetworkImage(
//                                                                                         height: 80,
//                                                                                         width: 80,
//                                                                                         imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                                                                         imageBuilder: (context, imageProvider) => Container(
//                                                                                           decoration: BoxDecoration(
//                                                                                             image: DecorationImage(
//                                                                                               image: imageProvider,
//                                                                                               fit: BoxFit.contain,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         placeholder: (context, url) => const Padding(
//                                                                                           padding: EdgeInsets.all(12.0),
//                                                                                           child: Center(
//                                                                                             child: CircularProgressIndicator(
//                                                                                               strokeWidth: 2,
//                                                                                               color: Colors.black,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         errorWidget: (context, url, error) => const Center(
//                                                                                           child: Icon(
//                                                                                             Icons.error_outline,
//                                                                                             color: Colors.red,
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                       const SizedBox(width: 14),
//                                                                                       Expanded(
//                                                                                         child: Column(
//                                                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                                                           children: [
//                                                                                             Text(
//                                                                                               "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
//                                                                                               maxLines: 2,
//                                                                                               overflow: TextOverflow.ellipsis,
//                                                                                               style: getAppStyle(
//                                                                                                 color: Colors.black,
//                                                                                                 fontWeight: FontWeight.w600,
//                                                                                                 fontSize: 13,
//                                                                                               ),
//                                                                                             ),
//                                                                                             Padding(
//                                                                                               padding: const EdgeInsets.symmetric(vertical: 02),
//                                                                                               child: Text(
//                                                                                                 "250 g",
//                                                                                                 style: getAppStyle(
//                                                                                                   color: Colors.grey,
//                                                                                                   fontWeight: FontWeight.w500,
//                                                                                                   fontSize: 12,
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ],
//                                                                                         ),
//                                                                                       ),
//                                                                                       const SizedBox(width: 8),
//                                                                                       Column(
//                                                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                         mainAxisAlignment: MainAxisAlignment.start,
//                                                                                         children: [
//                                                                                           Container(
//                                                                                             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                                                                                             margin: const EdgeInsets.only(bottom: 4),
//                                                                                             height: 30,
//                                                                                             width: 80,
//                                                                                             decoration: BoxDecoration(
//                                                                                               borderRadius: BorderRadius.circular(6),
//                                                                                               color: CommonColors.primaryColor,
//                                                                                             ),
//                                                                                             child: Row(
//                                                                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                                               children: [
//                                                                                                 GestureDetector(
//                                                                                                   onTap: () => decrementItem(),
//                                                                                                   child: const Icon(
//                                                                                                     Icons.remove,
//                                                                                                     size: 16,
//                                                                                                     color: Colors.white,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                                 Text(
//                                                                                                   itemCount.toString(),
//                                                                                                   style: getAppStyle(
//                                                                                                     color: Colors.white,
//                                                                                                     fontWeight: FontWeight.w500,
//                                                                                                     fontSize: 14,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                                 GestureDetector(
//                                                                                                   onTap: () => incrementItem(),
//                                                                                                   child: const Icon(
//                                                                                                     Icons.add,
//                                                                                                     size: 16,
//                                                                                                     color: Colors.white,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ],
//                                                                                             ),
//                                                                                           ),
//                                                                                           Row(
//                                                                                             children: [
//                                                                                               Text(
//                                                                                                 "₹${"80.0"}",
//                                                                                                 style: getAppStyle(
//                                                                                                   decoration: TextDecoration.lineThrough,
//                                                                                                   color: Colors.grey,
//                                                                                                   fontWeight: FontWeight.w500,
//                                                                                                   fontSize: 12,
//                                                                                                 ),
//                                                                                               ),
//                                                                                               const SizedBox(width: 4),
//                                                                                               Text(
//                                                                                                 "₹${"250.0"}",
//                                                                                                 style: getAppStyle(
//                                                                                                   color: Colors.black,
//                                                                                                   fontWeight: FontWeight.bold,
//                                                                                                   fontSize: 13,
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),
//                                                                                         ],
//                                                                                       ),
//                                                                                     ],
//                                                                                   ),
//                                                                                   const SizedBox(height: 10)
//                                                                                 ],
//                                                                               );
//                                                                             },
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       const Spacer(),
//                                                                       Padding(
//                                                                         padding: const EdgeInsets.only(top: 10, bottom: 20),
//                                                                         child: Row(
//                                                                           children: [
//                                                                             Container(
//                                                                               height: 42,
//                                                                               width: 58,
//                                                                               margin: const EdgeInsets.only(right: 10),
//                                                                               color: Colors.transparent,
//                                                                               child: Stack(
//                                                                                 children: [
//                                                                                   Container(
//                                                                                     height: 42,
//                                                                                     width: 42,
//                                                                                     decoration: BoxDecoration(
//                                                                                       color: Colors.white,
//                                                                                       border: Border.all(color: Colors.grey),
//                                                                                       borderRadius: BorderRadius.circular(10),
//                                                                                     ),
//                                                                                   ),
//                                                                                   Positioned(
//                                                                                     left: 8,
//                                                                                     child: Container(
//                                                                                       height: 42,
//                                                                                       width: 42,
//                                                                                       decoration: BoxDecoration(
//                                                                                         color: Colors.white,
//                                                                                         border: Border.all(color: Colors.grey),
//                                                                                         borderRadius: BorderRadius.circular(10),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                   Positioned(
//                                                                                     left: 16,
//                                                                                     child: Container(
//                                                                                       height: 42,
//                                                                                       width: 42,
//                                                                                       decoration: BoxDecoration(
//                                                                                         color: Colors.white,
//                                                                                         border: Border.all(color: Colors.grey),
//                                                                                         borderRadius: BorderRadius.circular(10),
//                                                                                       ),
//                                                                                       child: CachedNetworkImage(
//                                                                                         height: 80,
//                                                                                         width: 80,
//                                                                                         imageUrl: "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                                                                         imageBuilder: (context, imageProvider) => Container(
//                                                                                           decoration: BoxDecoration(
//                                                                                             image: DecorationImage(
//                                                                                               image: imageProvider,
//                                                                                               fit: BoxFit.contain,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         placeholder: (context, url) => const Padding(
//                                                                                           padding: EdgeInsets.all(12.0),
//                                                                                           child: Center(
//                                                                                             child: CircularProgressIndicator(
//                                                                                               strokeWidth: 2,
//                                                                                               color: Colors.black,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         errorWidget: (context, url, error) => const Center(
//                                                                                           child: Icon(
//                                                                                             Icons.error_outline,
//                                                                                             color: Colors.red,
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                             InkWell(
//                                                                               onTap: () {
//                                                                                 debugPrint("OnTap");
//                                                                               },
//                                                                               child: Row(
//                                                                                 children: [
//                                                                                   Text(
//                                                                                     "6 Item",
//                                                                                     style: getAppStyle(
//                                                                                       color: Colors.black,
//                                                                                       fontWeight: FontWeight.w500,
//                                                                                       fontSize: 12,
//                                                                                     ),
//                                                                                   ),
//                                                                                   const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(width: 20),
//                                                                             Expanded(
//                                                                               child: GestureDetector(
//                                                                                 onTap: () {
//                                                                                   debugPrint("On Tap Sub Product");
//                                                                                 },
//                                                                                 child: Container(
//                                                                                   height: 40,
//                                                                                   decoration: BoxDecoration(
//                                                                                     borderRadius: BorderRadius.circular(6),
//                                                                                     color: CommonColors.primaryColor,
//                                                                                   ),
//                                                                                   child: Center(
//                                                                                     child: Text(
//                                                                                       "View Cart",
//                                                                                       style: getAppStyle(
//                                                                                         color: Colors.white,
//                                                                                         fontWeight: FontWeight.bold,
//                                                                                         fontSize: 14,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 );
//                                                               },
//                                                             ),
//                                                           );
//                                                         },
//                                                       );
//
//                                                       // showModalBottomSheet(
//                                                       //   context: context,
//                                                       //   builder: (BuildContext context) {
//                                                       //     return Padding(
//                                                       //       padding: const EdgeInsets.all(8.0),
//                                                       //       child: Column(
//                                                       //         crossAxisAlignment: CrossAxisAlignment.start,
//                                                       //         children: [
//                                                       //           Padding(
//                                                       //             padding: const EdgeInsets.only(
//                                                       //                 left: 12, right: 12, top: 12),
//                                                       //             child: Row(
//                                                       //               mainAxisAlignment:
//                                                       //                   MainAxisAlignment.spaceBetween,
//                                                       //               children: [
//                                                       //                 Column(
//                                                       //                   crossAxisAlignment:
//                                                       //                       CrossAxisAlignment.start,
//                                                       //                   children: [
//                                                       //                     Text(
//                                                       //                       'Review Cart',
//                                                       //                       style: getAppStyle(
//                                                       //                           fontWeight: FontWeight.bold,
//                                                       //                           fontSize: 18),
//                                                       //                     ),
//                                                       //                     Row(
//                                                       //                       children: [
//                                                       //                         Text(
//                                                       //                           "3 Items • Total",
//                                                       //                           style: getAppStyle(
//                                                       //                               color: CommonColors
//                                                       //                                   .black54),
//                                                       //                         ),
//                                                       //                         Text(
//                                                       //                           " ₹542",
//                                                       //                           style: getAppStyle(
//                                                       //                               fontWeight:
//                                                       //                                   FontWeight.bold),
//                                                       //                         ),
//                                                       //                       ],
//                                                       //                     )
//                                                       //                   ],
//                                                       //                 ),
//                                                       //                 InkWell(
//                                                       //                   onTap: () {
//                                                       //                     Navigator.pop(context);
//                                                       //                   },
//                                                       //                   child: Container(
//                                                       //                     decoration: BoxDecoration(
//                                                       //                       shape: BoxShape.circle,
//                                                       //                       boxShadow: [
//                                                       //                         BoxShadow(
//                                                       //                           color: Colors.grey,
//                                                       //                           offset: const Offset(
//                                                       //                             2.0,
//                                                       //                             2.0,
//                                                       //                           ),
//                                                       //                           blurRadius: 5.0,
//                                                       //                           spreadRadius: 0.0,
//                                                       //                         ), //BoxShadow
//                                                       //                         BoxShadow(
//                                                       //                           color: Colors.white,
//                                                       //                           offset:
//                                                       //                               const Offset(0.0, 0.0),
//                                                       //                           blurRadius: 0.0,
//                                                       //                           spreadRadius: 0.0,
//                                                       //                         ), //BoxShadow
//                                                       //                       ],
//                                                       //                     ),
//                                                       //                     child: Padding(
//                                                       //                       padding:
//                                                       //                           const EdgeInsets.all(8.0),
//                                                       //                       child: Icon(
//                                                       //                         Icons.close,
//                                                       //                         size: 15,
//                                                       //                       ),
//                                                       //                     ),
//                                                       //                   ),
//                                                       //                 ),
//                                                       //               ],
//                                                       //             ),
//                                                       //           ),
//                                                       //           kCommonSpaceV10,
//                                                       //           kCommonSpaceV3,
//                                                       //           Container(
//                                                       //             height: 3,
//                                                       //             color: CommonColors.mGrey300,
//                                                       //           ),
//                                                       //           Container(
//                                                       //             height:
//                                                       //                 MediaQuery.of(context).size.height /
//                                                       //                     1.77,
//                                                       //             padding: const EdgeInsets.symmetric(
//                                                       //                 horizontal: 12),
//                                                       //             margin: const EdgeInsets.only(
//                                                       //                 top: 12),
//                                                       //             decoration: BoxDecoration(
//                                                       //               color: Colors.red,
//                                                       //               borderRadius: BorderRadius.circular(12),
//                                                       //             ),
//                                                       //             child: SingleChildScrollView(
//                                                       //               child: ListView.builder(
//                                                       //                 padding:
//                                                       //                     const EdgeInsets.only(top: 12),
//                                                       //                 physics:
//                                                       //                     const ClampingScrollPhysics(),
//                                                       //                 shrinkWrap: true,
//                                                       //                 scrollDirection: Axis.vertical,
//                                                       //                 itemCount: 15,
//                                                       //                 itemBuilder: (BuildContext context,
//                                                       //                     int index) {
//                                                       //                   return Column(
//                                                       //                     children: [
//                                                       //                       Row(
//                                                       //                         crossAxisAlignment:
//                                                       //                             CrossAxisAlignment.start,
//                                                       //                         children: [
//                                                       //                           CachedNetworkImage(
//                                                       //                             height: 80,
//                                                       //                             width: 80,
//                                                       //                             imageUrl:
//                                                       //                                 "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                                                       //                             imageBuilder: (context,
//                                                       //                                     imageProvider) =>
//                                                       //                                 Container(
//                                                       //                               decoration:
//                                                       //                                   BoxDecoration(
//                                                       //                                 image:
//                                                       //                                     DecorationImage(
//                                                       //                                   image:
//                                                       //                                       imageProvider,
//                                                       //                                   fit: BoxFit.contain,
//                                                       //                                 ),
//                                                       //                               ),
//                                                       //                             ),
//                                                       //                             placeholder:
//                                                       //                                 (context, url) =>
//                                                       //                                     const Padding(
//                                                       //                               padding: EdgeInsets.all(
//                                                       //                                   12.0),
//                                                       //                               child: Center(
//                                                       //                                 child:
//                                                       //                                     CircularProgressIndicator(
//                                                       //                                   strokeWidth: 2,
//                                                       //                                   color: Colors.black,
//                                                       //                                 ),
//                                                       //                               ),
//                                                       //                             ),
//                                                       //                             errorWidget: (context,
//                                                       //                                     url, error) =>
//                                                       //                                 const Center(
//                                                       //                               child: Icon(
//                                                       //                                 Icons.error_outline,
//                                                       //                                 color: Colors.red,
//                                                       //                               ),
//                                                       //                             ),
//                                                       //                           ),
//                                                       //                           const SizedBox(width: 14),
//                                                       //                           Expanded(
//                                                       //                             child: Column(
//                                                       //                               crossAxisAlignment:
//                                                       //                                   CrossAxisAlignment
//                                                       //                                       .start,
//                                                       //                               mainAxisAlignment:
//                                                       //                                   MainAxisAlignment
//                                                       //                                       .start,
//                                                       //                               children: [
//                                                       //                                 Text(
//                                                       //                                   "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
//                                                       //                                   maxLines: 2,
//                                                       //                                   overflow:
//                                                       //                                       TextOverflow
//                                                       //                                           .ellipsis,
//                                                       //                                   style: getAppStyle(
//                                                       //                                     color:
//                                                       //                                         Colors.black,
//                                                       //                                     fontWeight:
//                                                       //                                         FontWeight
//                                                       //                                             .w600,
//                                                       //                                     fontSize: 13,
//                                                       //                                   ),
//                                                       //                                 ),
//                                                       //                                 Padding(
//                                                       //                                   padding:
//                                                       //                                       const EdgeInsets
//                                                       //                                           .symmetric(
//                                                       //                                           vertical:
//                                                       //                                               02),
//                                                       //                                   child: Text(
//                                                       //                                     "250 g",
//                                                       //                                     style:
//                                                       //                                         getAppStyle(
//                                                       //                                       color:
//                                                       //                                           Colors.grey,
//                                                       //                                       fontWeight:
//                                                       //                                           FontWeight
//                                                       //                                               .w500,
//                                                       //                                       fontSize: 12,
//                                                       //                                     ),
//                                                       //                                   ),
//                                                       //                                 ),
//                                                       //                               ],
//                                                       //                             ),
//                                                       //                           ),
//                                                       //                           const SizedBox(width: 8),
//                                                       //                           Column(
//                                                       //                             crossAxisAlignment:
//                                                       //                                 CrossAxisAlignment
//                                                       //                                     .start,
//                                                       //                             mainAxisAlignment:
//                                                       //                                 MainAxisAlignment
//                                                       //                                     .start,
//                                                       //                             children: [
//                                                       //                               Container(
//                                                       //                                 padding:
//                                                       //                                     const EdgeInsets
//                                                       //                                         .symmetric(
//                                                       //                                         horizontal: 4,
//                                                       //                                         vertical: 4),
//                                                       //                                 margin:
//                                                       //                                     const EdgeInsets
//                                                       //                                         .only(
//                                                       //                                         bottom: 4),
//                                                       //                                 height: 30,
//                                                       //                                 width: 80,
//                                                       //                                 decoration:
//                                                       //                                     BoxDecoration(
//                                                       //                                   borderRadius:
//                                                       //                                       BorderRadius
//                                                       //                                           .circular(
//                                                       //                                               6),
//                                                       //                                   color: CommonColors
//                                                       //                                       .primaryColor,
//                                                       //                                 ),
//                                                       //                                 child: Row(
//                                                       //                                   mainAxisAlignment:
//                                                       //                                       MainAxisAlignment
//                                                       //                                           .spaceAround,
//                                                       //                                   children: [
//                                                       //                                     GestureDetector(
//                                                       //                                       onTap: () =>
//                                                       //                                           decrementItem(),
//                                                       //                                       child:
//                                                       //                                           const Icon(
//                                                       //                                         Icons.remove,
//                                                       //                                         size: 16,
//                                                       //                                         color: Colors
//                                                       //                                             .white,
//                                                       //                                       ),
//                                                       //                                     ),
//                                                       //                                     Text(
//                                                       //                                       itemCount
//                                                       //                                           .toString(),
//                                                       //                                       style:
//                                                       //                                           getAppStyle(
//                                                       //                                         color: Colors
//                                                       //                                             .white,
//                                                       //                                         fontWeight:
//                                                       //                                             FontWeight
//                                                       //                                                 .w500,
//                                                       //                                         fontSize: 14,
//                                                       //                                       ),
//                                                       //                                     ),
//                                                       //                                     GestureDetector(
//                                                       //                                       onTap: () =>
//                                                       //                                           incrementItem(),
//                                                       //                                       child:
//                                                       //                                           const Icon(
//                                                       //                                         Icons.add,
//                                                       //                                         size: 16,
//                                                       //                                         color: Colors
//                                                       //                                             .white,
//                                                       //                                       ),
//                                                       //                                     ),
//                                                       //                                   ],
//                                                       //                                 ),
//                                                       //                               ),
//                                                       //                               Row(
//                                                       //                                 children: [
//                                                       //                                   Text(
//                                                       //                                     "₹${"80.0"}",
//                                                       //                                     style:
//                                                       //                                         getAppStyle(
//                                                       //                                       decoration:
//                                                       //                                           TextDecoration
//                                                       //                                               .lineThrough,
//                                                       //                                       color:
//                                                       //                                           Colors.grey,
//                                                       //                                       fontWeight:
//                                                       //                                           FontWeight
//                                                       //                                               .w500,
//                                                       //                                       fontSize: 12,
//                                                       //                                     ),
//                                                       //                                   ),
//                                                       //                                   const SizedBox(
//                                                       //                                       width: 4),
//                                                       //                                   Text(
//                                                       //                                     "₹${"250.0"}",
//                                                       //                                     style:
//                                                       //                                         getAppStyle(
//                                                       //                                       color: Colors
//                                                       //                                           .black,
//                                                       //                                       fontWeight:
//                                                       //                                           FontWeight
//                                                       //                                               .bold,
//                                                       //                                       fontSize: 13,
//                                                       //                                     ),
//                                                       //                                   ),
//                                                       //                                 ],
//                                                       //                               ),
//                                                       //                             ],
//                                                       //                           ),
//                                                       //                         ],
//                                                       //                       ),
//                                                       //                       const SizedBox(height: 10)
//                                                       //                     ],
//                                                       //                   );
//                                                       //                 },
//                                                       //               ),
//                                                       //             ),
//                                                       //           ),
//                                                       //         ],
//                                                       //       ),
//                                                       //     );
//                                                       //   },
//                                                       // );
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           );
//
//                           // showModalBottomSheet(
//                           //   context: context,
//                           //   builder: (BuildContext context) {
//                           //     return Padding(
//                           //       padding: const EdgeInsets.all(8.0),
//                           //       child: Column(
//                           //         crossAxisAlignment: CrossAxisAlignment.start,
//                           //         children: [
//                           //           Padding(
//                           //             padding: const EdgeInsets.only(
//                           //                 left: 12, right: 12, top: 12),
//                           //             child: Row(
//                           //               mainAxisAlignment:
//                           //                   MainAxisAlignment.spaceBetween,
//                           //               children: [
//                           //                 Column(
//                           //                   crossAxisAlignment:
//                           //                       CrossAxisAlignment.start,
//                           //                   children: [
//                           //                     Text(
//                           //                       'Review Cart',
//                           //                       style: getAppStyle(
//                           //                           fontWeight: FontWeight.bold,
//                           //                           fontSize: 18),
//                           //                     ),
//                           //                     Row(
//                           //                       children: [
//                           //                         Text(
//                           //                           "3 Items • Total",
//                           //                           style: getAppStyle(
//                           //                               color: CommonColors
//                           //                                   .black54),
//                           //                         ),
//                           //                         Text(
//                           //                           " ₹542",
//                           //                           style: getAppStyle(
//                           //                               fontWeight:
//                           //                                   FontWeight.bold),
//                           //                         ),
//                           //                       ],
//                           //                     )
//                           //                   ],
//                           //                 ),
//                           //                 InkWell(
//                           //                   onTap: () {
//                           //                     Navigator.pop(context);
//                           //                   },
//                           //                   child: Container(
//                           //                     decoration: BoxDecoration(
//                           //                       shape: BoxShape.circle,
//                           //                       boxShadow: [
//                           //                         BoxShadow(
//                           //                           color: Colors.grey,
//                           //                           offset: const Offset(
//                           //                             2.0,
//                           //                             2.0,
//                           //                           ),
//                           //                           blurRadius: 5.0,
//                           //                           spreadRadius: 0.0,
//                           //                         ), //BoxShadow
//                           //                         BoxShadow(
//                           //                           color: Colors.white,
//                           //                           offset:
//                           //                               const Offset(0.0, 0.0),
//                           //                           blurRadius: 0.0,
//                           //                           spreadRadius: 0.0,
//                           //                         ), //BoxShadow
//                           //                       ],
//                           //                     ),
//                           //                     child: Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(8.0),
//                           //                       child: Icon(
//                           //                         Icons.close,
//                           //                         size: 15,
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //               ],
//                           //             ),
//                           //           ),
//                           //           kCommonSpaceV10,
//                           //           kCommonSpaceV3,
//                           //           Container(
//                           //             height: 3,
//                           //             color: CommonColors.mGrey300,
//                           //           ),
//                           //           Container(
//                           //             height:
//                           //                 MediaQuery.of(context).size.height /
//                           //                     1.77,
//                           //             padding: const EdgeInsets.symmetric(
//                           //                 horizontal: 12),
//                           //             margin: const EdgeInsets.only(
//                           //                 top: 12),
//                           //             decoration: BoxDecoration(
//                           //               color: Colors.red,
//                           //               borderRadius: BorderRadius.circular(12),
//                           //             ),
//                           //             child: SingleChildScrollView(
//                           //               child: ListView.builder(
//                           //                 padding:
//                           //                     const EdgeInsets.only(top: 12),
//                           //                 physics:
//                           //                     const ClampingScrollPhysics(),
//                           //                 shrinkWrap: true,
//                           //                 scrollDirection: Axis.vertical,
//                           //                 itemCount: 15,
//                           //                 itemBuilder: (BuildContext context,
//                           //                     int index) {
//                           //                   return Column(
//                           //                     children: [
//                           //                       Row(
//                           //                         crossAxisAlignment:
//                           //                             CrossAxisAlignment.start,
//                           //                         children: [
//                           //                           CachedNetworkImage(
//                           //                             height: 80,
//                           //                             width: 80,
//                           //                             imageUrl:
//                           //                                 "https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2024/7/18/510edaab-8c6a-4a47-a1d4-7aa2c539d6cf_chipsnachosandpopcorn_G6YR13TFQG_MN.png",
//                           //                             imageBuilder: (context,
//                           //                                     imageProvider) =>
//                           //                                 Container(
//                           //                               decoration:
//                           //                                   BoxDecoration(
//                           //                                 image:
//                           //                                     DecorationImage(
//                           //                                   image:
//                           //                                       imageProvider,
//                           //                                   fit: BoxFit.contain,
//                           //                                 ),
//                           //                               ),
//                           //                             ),
//                           //                             placeholder:
//                           //                                 (context, url) =>
//                           //                                     const Padding(
//                           //                               padding: EdgeInsets.all(
//                           //                                   12.0),
//                           //                               child: Center(
//                           //                                 child:
//                           //                                     CircularProgressIndicator(
//                           //                                   strokeWidth: 2,
//                           //                                   color: Colors.black,
//                           //                                 ),
//                           //                               ),
//                           //                             ),
//                           //                             errorWidget: (context,
//                           //                                     url, error) =>
//                           //                                 const Center(
//                           //                               child: Icon(
//                           //                                 Icons.error_outline,
//                           //                                 color: Colors.red,
//                           //                               ),
//                           //                             ),
//                           //                           ),
//                           //                           const SizedBox(width: 14),
//                           //                           Expanded(
//                           //                             child: Column(
//                           //                               crossAxisAlignment:
//                           //                                   CrossAxisAlignment
//                           //                                       .start,
//                           //                               mainAxisAlignment:
//                           //                                   MainAxisAlignment
//                           //                                       .start,
//                           //                               children: [
//                           //                                 Text(
//                           //                                   "Bolas Cashew Nuts 250 Bolas Cashew Nuts 250",
//                           //                                   maxLines: 2,
//                           //                                   overflow:
//                           //                                       TextOverflow
//                           //                                           .ellipsis,
//                           //                                   style: getAppStyle(
//                           //                                     color:
//                           //                                         Colors.black,
//                           //                                     fontWeight:
//                           //                                         FontWeight
//                           //                                             .w600,
//                           //                                     fontSize: 13,
//                           //                                   ),
//                           //                                 ),
//                           //                                 Padding(
//                           //                                   padding:
//                           //                                       const EdgeInsets
//                           //                                           .symmetric(
//                           //                                           vertical:
//                           //                                               02),
//                           //                                   child: Text(
//                           //                                     "250 g",
//                           //                                     style:
//                           //                                         getAppStyle(
//                           //                                       color:
//                           //                                           Colors.grey,
//                           //                                       fontWeight:
//                           //                                           FontWeight
//                           //                                               .w500,
//                           //                                       fontSize: 12,
//                           //                                     ),
//                           //                                   ),
//                           //                                 ),
//                           //                               ],
//                           //                             ),
//                           //                           ),
//                           //                           const SizedBox(width: 8),
//                           //                           Column(
//                           //                             crossAxisAlignment:
//                           //                                 CrossAxisAlignment
//                           //                                     .start,
//                           //                             mainAxisAlignment:
//                           //                                 MainAxisAlignment
//                           //                                     .start,
//                           //                             children: [
//                           //                               Container(
//                           //                                 padding:
//                           //                                     const EdgeInsets
//                           //                                         .symmetric(
//                           //                                         horizontal: 4,
//                           //                                         vertical: 4),
//                           //                                 margin:
//                           //                                     const EdgeInsets
//                           //                                         .only(
//                           //                                         bottom: 4),
//                           //                                 height: 30,
//                           //                                 width: 80,
//                           //                                 decoration:
//                           //                                     BoxDecoration(
//                           //                                   borderRadius:
//                           //                                       BorderRadius
//                           //                                           .circular(
//                           //                                               6),
//                           //                                   color: CommonColors
//                           //                                       .primaryColor,
//                           //                                 ),
//                           //                                 child: Row(
//                           //                                   mainAxisAlignment:
//                           //                                       MainAxisAlignment
//                           //                                           .spaceAround,
//                           //                                   children: [
//                           //                                     GestureDetector(
//                           //                                       onTap: () =>
//                           //                                           decrementItem(),
//                           //                                       child:
//                           //                                           const Icon(
//                           //                                         Icons.remove,
//                           //                                         size: 16,
//                           //                                         color: Colors
//                           //                                             .white,
//                           //                                       ),
//                           //                                     ),
//                           //                                     Text(
//                           //                                       itemCount
//                           //                                           .toString(),
//                           //                                       style:
//                           //                                           getAppStyle(
//                           //                                         color: Colors
//                           //                                             .white,
//                           //                                         fontWeight:
//                           //                                             FontWeight
//                           //                                                 .w500,
//                           //                                         fontSize: 14,
//                           //                                       ),
//                           //                                     ),
//                           //                                     GestureDetector(
//                           //                                       onTap: () =>
//                           //                                           incrementItem(),
//                           //                                       child:
//                           //                                           const Icon(
//                           //                                         Icons.add,
//                           //                                         size: 16,
//                           //                                         color: Colors
//                           //                                             .white,
//                           //                                       ),
//                           //                                     ),
//                           //                                   ],
//                           //                                 ),
//                           //                               ),
//                           //                               Row(
//                           //                                 children: [
//                           //                                   Text(
//                           //                                     "₹${"80.0"}",
//                           //                                     style:
//                           //                                         getAppStyle(
//                           //                                       decoration:
//                           //                                           TextDecoration
//                           //                                               .lineThrough,
//                           //                                       color:
//                           //                                           Colors.grey,
//                           //                                       fontWeight:
//                           //                                           FontWeight
//                           //                                               .w500,
//                           //                                       fontSize: 12,
//                           //                                     ),
//                           //                                   ),
//                           //                                   const SizedBox(
//                           //                                       width: 4),
//                           //                                   Text(
//                           //                                     "₹${"250.0"}",
//                           //                                     style:
//                           //                                         getAppStyle(
//                           //                                       color: Colors
//                           //                                           .black,
//                           //                                       fontWeight:
//                           //                                           FontWeight
//                           //                                               .bold,
//                           //                                       fontSize: 13,
//                           //                                     ),
//                           //                                   ),
//                           //                                 ],
//                           //                               ),
//                           //                             ],
//                           //                           ),
//                           //                         ],
//                           //                       ),
//                           //                       const SizedBox(height: 10)
//                           //                     ],
//                           //                   );
//                           //                 },
//                           //               ),
//                           //             ),
//                           //           ),
//                           //         ],
//                           //       ),
//                           //     );
//                           //   },
//                           // );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// },
