import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/view/cart/cart_view_model.dart';
import 'package:solikat_2024/view/home/home_view_model.dart';
import 'package:solikat_2024/view/home/search/search_view.dart';
import 'package:solikat_2024/view/home/search/search_view_model.dart';
import 'package:solikat_2024/view/home/section_designs.dart';
import 'package:solikat_2024/view/home/shimmer_effect.dart';
import 'package:solikat_2024/view/home/sub_brand/sub_brand_view_model.dart';
import 'package:solikat_2024/view/home/sub_category/sub_category_view_model.dart';
import 'package:solikat_2024/view/home/sub_offer/sub_offer_view_model.dart';
import 'package:solikat_2024/view/home/view_all_products/view_all_products_view_model.dart';
import 'package:solikat_2024/widget/common_text_field.dart';
import 'package:solikat_2024/widget/primary_button.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../models/home_master.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';
import '../../utils/global_variables.dart';
import '../../utils/local_images.dart';
import '../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../common_view/common_img_slider/common_img_slider_view.dart';
import '../profile/edit_account/edit_account_view.dart';
import '../profile/edit_account/edit_account_view_model.dart';

class HomeView extends StatefulWidget {
  final String? location;

  const HomeView({super.key, this.location});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
  late CartViewModel mCartViewModel;
  late SubCategoryViewModel mSubCategoryViewModel;
  late SubOfferViewModel mOfferViewModel;
  late SubBrandViewModel mBrandViewModel;
  late SearchViewModel mSearchViewModel;
  late ViewAllProductsViewModel mAllProductViewModel;
  stt.SpeechToText _speechToText = stt.SpeechToText();
  TextEditingController searchController = TextEditingController();
  bool _isListening = false;
  bool _isSpeaking = false;
  late BuildContext _bottomSheetContext;
  bool _isStickyVisible = false;
  bool isBottomSheetOpen = false;

  // int itemCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mProfileViewModel.attachedContext(context);
      mViewModel.attachedContext(context);
      _pageController = PageController();
      mCartViewModel.attachedContext(context);
      mSubCategoryViewModel.attachedContext(context);
      mBrandViewModel.attachedContext(context);
      mOfferViewModel.attachedContext(context);
      mSearchViewModel.attachedContext(context);
      mAllProductViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      _initializeSpeechRecognition();

      mViewModel.getCartApi();
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
    if (!mViewModel.isPageFinish) {
      mViewModel.getHomePageApi(latitude: gUserLat, longitude: gUserLong);
    }
  }

  late final PageController _pageController;
  int currentPageIndex = 0;
  bool isExpanded = false;

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

  int itemCount = 1;

  void incrementItem(int index) {
    setState(() {
      itemCount++;
    });
  }

  void decrementItem(int index) {
    setState(() {
      if (itemCount > 1) {
        itemCount--;
      }
    });
  }

  void _initializeSpeechRecognition() async {
    bool available = await _speechToText.initialize();
    if (available) {
      print("Speech recognition is available");
    } else {
      print("Speech recognition not available.");
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

      _showSpeakingDialog(context);

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
          if (searchController.text.isNotEmpty) {
            push(SearchView(
              voiceText: searchController.text,
            )).then((_) {
              searchController.clear();
            });
          }
        }
      });
    } else {
      print("Speech recognition not available.");
      // Permission.microphone.request().then((status) {
      //   if (status.isGranted) {
      //     print("Microphone permission granted.");
      //   } else if (status.isDenied) {
      //     print("Microphone permission denied.");
      //     Permission.microphone.request();
      //   } else if (status.isPermanentlyDenied) {
      //     print(
      //         "Microphone permission permanently denied. Please enable it from settings.");
      //   }
      // });
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

  Future<void> _showSpeakingDialog(BuildContext context) {
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
    mProfileViewModel = Provider.of<EditAccountViewModel>(context);
    mCartViewModel = Provider.of<CartViewModel>(context);
    mSubCategoryViewModel = Provider.of<SubCategoryViewModel>(context);
    mViewModel = Provider.of<HomeViewModel>(context);
    mBrandViewModel = Provider.of<SubBrandViewModel>(context);
    mOfferViewModel = Provider.of<SubOfferViewModel>(context);
    mSearchViewModel = Provider.of<SearchViewModel>(context);
    mAllProductViewModel = Provider.of<ViewAllProductsViewModel>(context);
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
                                  //push(HomeScreen());
                                  // profileDialog(context);
                                  mainNavKey.currentContext!
                                      .read<BottomNavbarViewModel>()
                                      .onMenuTapped(4);
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
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: CommonTextField(
                            controller: searchController,
                            hintText: "Search",
                            isPrefixIconButton: true,
                            suffixIcon: Icons.mic,
                            readOnly: true,
                            onSuffixIconPressed: () {
                              if (_isListening) {
                                _stopListening();
                              } else {
                                _startListening();
                              }
                            },
                            onTap: () {
                              push(SearchView(
                                voiceText: '',
                              ));
                            },
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 4),
                        child: CommonTextField(
                          hintText: "Search",
                          isPrefixIconButton: true,
                          suffixIcon: Icons.mic,
                          readOnly: true,
                          onSuffixIconPressed: () {
                            if (_isListening) {
                              _stopListening();
                            } else {
                              _startListening();
                            }
                          },
                          onTap: () {
                            push(
                              SearchView(
                                voiceText: '',
                              ),
                            );
                          },
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
          bottomNavigationBar: Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              return mViewModel.cartDataList.isNotEmpty
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
                                    mViewModel.cartDataList.length > 3
                                        ? 3
                                        : mViewModel.cartDataList.length,
                                    (index) {
                                      // Calculate the index from the end of the list
                                      int reverseIndex =
                                          mViewModel.cartDataList.length -
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
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
                                    if ((homeViewModel.cartDataList[index]
                                                .cartCount ??
                                            0) <
                                        (mViewModel.cartDataList[index].stock ??
                                            0)) {
                                      setState(() {
                                        for (var item
                                            in mViewModel.section4DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) + 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mViewModel.section9DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) + 1;
                                            break;
                                          }
                                        }

                                        for (var item in mBrandViewModel
                                            .brandProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) + 1;
                                            break;
                                          }
                                        }

                                        for (var item in mOfferViewModel
                                            .offerProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) + 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mSearchViewModel.productList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) + 1;
                                            break;
                                          }
                                        }

                                        mViewModel.cartDataList[index]
                                            .cartCount = (homeViewModel
                                                    .cartDataList[index]
                                                    .cartCount ??
                                                0) +
                                            1;
                                      });

                                      mViewModel.addToCartApi(
                                        variantId: homeViewModel
                                            .cartDataList[index].variantId
                                            .toString(),
                                        type: 'p',
                                      );
                                    } else {
                                      print(
                                          ".......Sorry this product have only ${mViewModel.cartDataList[index].stock} in stock......");
                                      String msg =
                                          "Only ${mViewModel.cartDataList[index].stock} product available in stock";
                                      CommonUtils.showCustomToast(context, msg);
                                    }
                                  }

                                  void decrementItem(int index) {
                                    if ((homeViewModel.cartDataList[index]
                                                .cartCount ??
                                            0) >
                                        1) {
                                      setState(() {
                                        for (var item
                                            in mViewModel.section4DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mViewModel.section9DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item in mBrandViewModel
                                            .brandProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item in mOfferViewModel
                                            .offerProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mSearchViewModel.productList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        mViewModel.cartDataList[index]
                                            .cartCount = (homeViewModel
                                                    .cartDataList[index]
                                                    .cartCount ??
                                                0) -
                                            1;
                                      });

                                      mViewModel.addToCartApi(
                                          variantId: homeViewModel
                                              .cartDataList[index].variantId
                                              .toString(),
                                          type: 'm');
                                    } else if (homeViewModel
                                            .cartDataList[index].cartCount ==
                                        1) {
                                      mViewModel.addToCartApi(
                                          variantId: homeViewModel
                                              .cartDataList[index].variantId
                                              .toString(),
                                          type: 'm');

                                      setState(() {
                                        for (var item
                                            in mViewModel.section4DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount = item.cartCount - 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mViewModel.section9DataList) {
                                          if (mViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item in mBrandViewModel
                                            .brandProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item in mOfferViewModel
                                            .offerProductList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        for (var item
                                            in mSearchViewModel.productList) {
                                          if (homeViewModel
                                                  .cartDataList[index].variantId
                                                  ?.toString()
                                                  .trim() ==
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
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
                                              item.variantId
                                                  .toString()
                                                  .trim()) {
                                            item.cartCount =
                                                (item.cartCount ?? 0) - 1;
                                            break;
                                          }
                                        }

                                        mViewModel.cartDataList.removeAt(index);
                                      });

                                      if (homeViewModel.cartDataList.length ==
                                          0) {
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
                                                    left: 15,
                                                    right: 15,
                                                    top: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Review Cart',
                                                          style: getAppStyle(
                                                              color: CommonColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${mViewModel.cartDataList.length} Items • Total ",
                                                              style: getAppStyle(
                                                                  color: CommonColors
                                                                      .black54),
                                                            ),
                                                            Text(
                                                              "₹${mViewModel.cartTotalPrice}",
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
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset:
                                                                  const Offset(
                                                                2.0,
                                                                2.0,
                                                              ),
                                                              blurRadius: 5.0,
                                                              spreadRadius: 0.0,
                                                            ), //BoxShadow
                                                            BoxShadow(
                                                              color: CommonColors
                                                                  .primaryColor,
                                                              offset:
                                                                  const Offset(
                                                                      0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              spreadRadius: 0.0,
                                                            ), //BoxShadow
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 15,
                                                            color: CommonColors
                                                                .mWhite,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                    child: Container(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 18,
                                                                  right: 18,
                                                                  top: 18),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              homeViewModel
                                                                  .cartDataList
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CachedNetworkImage(
                                                                      height:
                                                                          60,
                                                                      width: 70,
                                                                      imageUrl:
                                                                          mViewModel.cartDataList[index].image ??
                                                                              '',
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(12.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            strokeWidth:
                                                                                2,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .error_outline,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            14),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            mViewModel.cartDataList[index].productName ??
                                                                                '',
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                getAppStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 13,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 02),
                                                                            child:
                                                                                Text(
                                                                              mViewModel.cartDataList[index].variantName ?? '',
                                                                              style: getAppStyle(
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
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
                                                                              horizontal: 4,
                                                                              vertical: 4),
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              bottom: 4),
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6),
                                                                            color:
                                                                                CommonColors.primaryColor,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  decrementItem(index);
                                                                                  setState(() {});
                                                                                },
                                                                                child: const Icon(
                                                                                  Icons.remove,
                                                                                  size: 16,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                mViewModel.cartDataList[index].cartCount.toString(),
                                                                                style: getAppStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  incrementItem(index);
                                                                                  setState(() {});
                                                                                },
                                                                                child: const Icon(
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
                                                                              "₹${mViewModel.cartDataList[index].productPrice}",
                                                                              style: getAppStyle(
                                                                                decoration: TextDecoration.lineThrough,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 4),
                                                                            Text(
                                                                              "₹${mViewModel.cartDataList[index].discountPrice}",
                                                                              style: getAppStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 13,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 6),
                                                          color: Colors
                                                              .transparent,
                                                          child: Stack(
                                                            children:
                                                                List.generate(
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
                                                                  left:
                                                                      index * 6,
                                                                  child:
                                                                      Container(
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
                                                                          color:
                                                                              CommonColors.mGrey500),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          mViewModel.cartDataList[reverseIndex].image ??
                                                                              '',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              const Center(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              10,
                                                                          width:
                                                                              10,
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
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${mViewModel.cartDataList.length} Items",
                                                                style:
                                                                    getAppStyle(
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
                                                          buttonColor:
                                                              CommonColors
                                                                  .primaryColor,
                                                          labelColor:
                                                              Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          onPress: () {
                                                            Navigator.pop(
                                                                context);
                                                            mainNavKey
                                                                .currentContext!
                                                                .read<
                                                                    BottomNavbarViewModel>()
                                                                .onMenuTapped(
                                                                    3);
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
                                      "${mViewModel.cartDataList.length} Items",
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
          onTapProDetails: (variantId) async {
            if (!isBottomSheetOpen) {
              isBottomSheetOpen = true;
              await mViewModel.getProductDetailsApi(
                  variantId: variantId.toString());
              if (mViewModel.productDetailsData != null) {
                productDetailsBottomSheet(variantId);
              }
            }
            // await mViewModel.getProductDetailsApi(
            //     variantId: variantId.toString());
            // if (mViewModel.productDetailsData != null) {
            //   productDetailsBottomSheet(variantId);
            // }
          },
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
            onTapProDetails: (variantId) async {
              if (!isBottomSheetOpen) {
                isBottomSheetOpen = true;
                await mViewModel.getProductDetailsApi(
                    variantId: variantId.toString());
                if (mViewModel.productDetailsData != null) {
                  productDetailsBottomSheet(variantId);
                }
              }
              // await mViewModel.getProductDetailsApi(
              //     variantId: variantId.toString());
              // if (mViewModel.productDetailsData != null) {
              //   productDetailsBottomSheet(variantId);
              // }
            },
            section9: [section9Data],
            section4Title: sectionData.sectionTitle,
            onAddItem: (variantId) async {
              await mViewModel.addToCartApi(
                  variantId: variantId.toString(), type: 'p');
            },
            onRemoveItem: (variantId) async {
              await mViewModel.addToCartApi(
                  variantId: variantId.toString(), type: 'm');
            },
          );
          // return Section9(
          //   section9: [section9Data],
          // );
        }
        break;
    }

    return Container();
  }

  void productDetailsBottomSheet(int variantId) {
    isBottomSheetOpen = false;
    mViewModel.getProductDetailsApi(variantId: variantId.toString());
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
                              imgUrls: mViewModel.productDetailsData![0].image!
                                  .map((imageData) => imageData.image ?? "")
                                  .toList(),
                            ),
                            Text(
                              mViewModel.productDetailsData?.isNotEmpty == true
                                  ? mViewModel
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
                              mViewModel.productDetailsData?.isNotEmpty == true
                                  ? mViewModel
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
                                  "₹${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].discountPrice.toString() : "No product details available"}",
                                  style: getAppStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "₹${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].productPrice.toString() : "No product details available"}",
                                  style: getAppStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                mViewModel.productDetailsData![0].discountPer
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
                                          "${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].discountPer.toString() : "No product details available"}% off",
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
                              mViewModel.productDetailsData![0].description!
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
                              mViewModel.productDetailsData![0].description ??
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
                                  //   mViewModel.productDetailsData?.isNotEmpty ==
                                  //           true
                                  //       ? mViewModel.productDetailsData![0]
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
                                        "₹${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].discountPrice.toString() : "No product details available"}",
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "₹${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].productPrice.toString() : "No product details available"}",
                                        style: getAppStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      mViewModel.productDetailsData![0]
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
                                                "${mViewModel.productDetailsData?.isNotEmpty == true ? mViewModel.productDetailsData![0].discountPer.toString() : "No product details available"}% off",
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
                              if (mViewModel.productDetailsData![0].stock !=
                                  0) ...[
                                mViewModel.productDetailsData![0].cartCount! > 0
                                    ? Container(
                                        height: 55,
                                        width: 240,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CommonColors.primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (mViewModel
                                                        .productDetailsData![0]
                                                        .cartCount! >
                                                    0) {
                                                  await mViewModel.addToCartApi(
                                                    variantId: mViewModel
                                                        .productDetailsData![0]
                                                        .variantId
                                                        .toString(),
                                                    type: 'm',
                                                  );
                                                  setState(() {
                                                    mViewModel
                                                        .productDetailsData![0]
                                                        .cartCount = mViewModel
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
                                              mViewModel.productDetailsData![0]
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
                                                if (mViewModel
                                                            .productDetailsData !=
                                                        null &&
                                                    mViewModel
                                                        .productDetailsData!
                                                        .isNotEmpty) {
                                                  int stock = mViewModel
                                                          .productDetailsData![
                                                              0]
                                                          .stock ??
                                                      0; // Provide a default value (e.g., 0)

                                                  if (mViewModel
                                                          .productDetailsData![
                                                              0]
                                                          .cartCount! <
                                                      stock) {
                                                    await mViewModel
                                                        .addToCartApi(
                                                      variantId: mViewModel
                                                          .productDetailsData![
                                                              0]
                                                          .variantId
                                                          .toString(),
                                                      type: 'p',
                                                    );
                                                    setState(() {
                                                      mViewModel
                                                          .productDetailsData![
                                                              0]
                                                          .cartCount = mViewModel
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
                                          await mViewModel.addToCartApi(
                                            variantId: mViewModel
                                                .productDetailsData![0]
                                                .variantId
                                                .toString(),
                                            type: 'p',
                                          );
                                          setState(() {
                                            mViewModel.productDetailsData![0]
                                                .cartCount = 1;
                                          });
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
