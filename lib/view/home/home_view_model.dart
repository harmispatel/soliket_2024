// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:solikat_2024/models/home_master.dart';
//
// import '../../services/api_para.dart';
// import '../../services/index.dart';
// import '../../utils/common_colors.dart';
// import '../../utils/common_utils.dart';
//
// class HomeViewModel with ChangeNotifier {
//   late BuildContext context;
//   final services = Services();
//   bool isPageFinish = false;
//   int currentPage = 1;
//   bool isLoadingMore = false;
//   bool isInitialLoading = true;
//   List<Section> homePageData = [];
//
//   // Section titles
//   String section10Text = '';
//   String section1Title = '';
//   String section2Title = '';
//   String section3Title = '';
//   String section4Title = '';
//   String section5Title = '';
//   String section6Title = '';
//   String section7Title = '';
//   String section8Title = '';
//
//   // Section data lists
//   List<Section1Data> section1DataList = [];
//   List<Section2Data> section2DataList = [];
//   List<Section3Data> section3DataList = [];
//   List<Section4Data> section4DataList = [];
//   List<Section5Data> section5DataList = [];
//   List<Section6Data> section6DataList = [];
//   List<Section7Data> section7DataList = [];
//   List<Section8Data> section8DataList = [];
//   List<Section9Data> section9DataList = [];
//
//   void attachedContext(BuildContext context) {
//     this.context = context;
//     notifyListeners();
//   }
//
//   Future<void> getHomePageApi({
//     required String latitude,
//     required String longitude,
//   }) async {
//     // Handle loading indicators (initial vs paginated loading)
//     if (currentPage == 1) {
//       isInitialLoading = true; // Show loading indicator for the first page
//     } else {
//       isLoadingMore = true; // Show loading indicator for subsequent pages
//     }
//     notifyListeners();
//
//     // Prepare API request parameters
//     Map<String, dynamic> params = <String, dynamic>{
//       ApiParams.latitude: latitude,
//       ApiParams.longitude: longitude,
//       ApiParams.page: currentPage.toString(),
//     };
//
//     // Make the API call
//     HomeMaster? master = await services.api!.getHomePageApi(params: params);
//
//     // Hide loading indicators after the API response
//     isInitialLoading = false;
//     isLoadingMore = false;
//     notifyListeners();
//
//     // Handle the response
//     if (master == null) {
//       CommonUtils.oopsMSG(); // Show error if response is null
//       return;
//     }
//
//     if (!master.status) {
//       CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
//       return; // Exit if the API returns an error
//     }
//
//     log("API Success: Page $currentPage");
//
//     // Add the new data from the API to the list
//     homePageData.addAll(master.data);
//
//     // Populate section-specific data
//     for (var section in master.data) {
//       switch (section.type) {
//         case 'section_1':
//           section1DataList.addAll(section.data);
//           section1Title = section.sectionTitle;
//           break;
//         case 'section_2':
//           section2DataList.addAll(section.data);
//           section2Title = section.sectionTitle;
//           break;
//         case 'section_3':
//           section3DataList.addAll(section.data);
//           section3Title = section.sectionTitle;
//           break;
//         case 'section_4':
//           section4DataList.addAll(section.data);
//           section4Title = section.sectionTitle;
//           break;
//         case 'section_5':
//           section5DataList.addAll(section.data);
//           section5Title = section.sectionTitle;
//           break;
//         case 'section_6':
//           section6DataList.add(section.data);
//           section6Title = section.sectionTitle;
//           break;
//         case 'section_7':
//           section7DataList.addAll(section.data);
//           section7Title = section.sectionTitle;
//           break;
//         case 'section_8':
//           section8DataList.addAll(section.data);
//           section8Title = section.sectionTitle;
//           break;
//         case 'section_9':
//           section9DataList.add(section.data);
//           break;
//         case 'section_10':
//           section10Text =
//               '🎁Free Delivery on first 3 orders! Use Code : FREEDEL🚚';
//           break;
//         default:
//           break;
//       }
//     }
//
//     // Check if more pages are available
//     currentPage++;
//     if (currentPage > master.totalPage!) {
//       isPageFinish = true; // No more pages to load
//     }
//
//     notifyListeners(); // Notify UI to reflect the changes
//   }
//
//   // Reset pagination and clear data
//   void resetPage() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       currentPage = 1;
//       isPageFinish = false;
//       homePageData.clear();
//       section1DataList.clear();
//       section2DataList.clear();
//       section3DataList.clear();
//       section4DataList.clear();
//       section5DataList.clear();
//       section6DataList.clear();
//       section7DataList.clear();
//       section8DataList.clear();
//       section9DataList.clear();
//       notifyListeners();
//     });
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:solikat_2024/models/add_to_cart_api.dart';
import 'package:solikat_2024/models/get_info_master.dart';
import 'package:solikat_2024/models/home_master.dart';
import 'package:solikat_2024/models/search_master.dart';

import '../../database/app_preferences.dart';
import '../../models/cart_master.dart';
import '../../models/product_details_master.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../login/login_view_model.dart';

class HomeViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  String? latestAppVersion;
  bool isPageFinish = false;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool isInitialLoading = true;
  List<Section> homePageData = [];
  List<GetInfoData> infoPopUpData = [];
  late LoginViewModel loginViewModel;

  // Section titles
  String section10Text = '';
  String section1Title = '';
  String section2Title = '';
  String section3Title = '';
  String section4Title = '';
  String section5Title = '';
  String section6Title = '';
  String section7Title = '';
  String section8Title = '';

  // Section data lists
  List<Section1Data> section1DataList = [];
  List<Section2Data> section2DataList = [];
  List<Section3Data> section3DataList = [];
  List<Section4Data> section4DataList = [];
  List<Section5Data> section5DataList = [];
  List<Section6Category> section6DataList = [];
  List<Section7Data> section7DataList = [];
  List<Section8Data> section8DataList = [];
  List<Section9Product> section9DataList = [];
  List<ProductData> cartDataList = [];
  String cartTotalPrice = '';
  bool isFirstTime = true;
  List<ProductDetailsData>? productDetailsData = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    cartTotalPrice = AppPreferences.instance.getCartTotal();
    loginViewModel = LoginViewModel();
    if (currentPage == 1) {
      loginViewModel.getAppVersionApi().then((_) {
        loginViewModel.checkAppVersion();
      });
    }
    notifyListeners();
  }

  Future<void> getCartApi() async {
    GetCartMaster? master = await services.api!.getCartApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      cartDataList = master.data?.cartItem ?? [];
    }
    notifyListeners();
  }

  Future<void> getInfoPopUpApi() async {
    getInfoMaster? master = await services.api!.getInfoPopUp();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showCustomToast(context, master.message);
    } else if (master.status!) {
      log("Success :: true");
      infoPopUpData = master.data ?? [];
    }
    notifyListeners();
  }

  Future<void> getHomePageApi({
    required String latitude,
    required String longitude,
  }) async {
    isInitialLoading = currentPage == 1;
    isLoadingMore = currentPage > 1;
    notifyListeners();

    // Prepare API request parameters
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
      ApiParams.page: currentPage.toString(),
    };

    // Make the API call
    HomeMaster? master = await services.api!.getHomePageApi(params: params);

    isInitialLoading = false;
    isLoadingMore = false;
    notifyListeners();

    print("............. ${master?.statusCode}.............");

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (!master.status) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }
    isFirstTime = AppPreferences.instance.getIsFirstTime();
    if (currentPage == 1 && isFirstTime) {
      getInfoPopUpApi().whenComplete(() {
        if (infoPopUpData[0].isEnabled == "y") {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            enableDrag: false,
            isDismissible: false,
            shape: Border(
                top: BorderSide.none,
                bottom: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none),
            builder: (_) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    height: kDeviceHeight / 2.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text(
                                infoPopUpData[0].title ?? '',
                                style: getAppStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CommonColors.primaryColor,
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
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.close,
                                      color: CommonColors.mWhite,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kCommonSpaceV10,
                        kCommonSpaceV3,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      infoPopUpData[0].image ?? ''),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        if (infoPopUpData[0].isContent == "y") ...[
                          kCommonSpaceV15,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 8),
                            child: Text(
                              infoPopUpData[0].description ?? '',
                              style: getAppStyle(),
                            ),
                          ),
                        ]
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
      });
      await AppPreferences.instance.setIsFirstTime(false);
    }

    // if (currentPage == 1) {
    //   Future<void> showModalIfFirstTime(BuildContext context) async {
    //     bool hasShownModal = await AppPreferences.hasShownModal();
    //     if (!hasShownModal) {
    //       getInfoPopUpApi().whenComplete(() {
    //         if (infoPopUpData[0].isEnabled == "y") {
    //           showModalBottomSheet(
    //             context: context,
    //             backgroundColor: Colors.white,
    //             enableDrag: false,
    //             isDismissible: false,
    //             shape: const Border(
    //               top: BorderSide.none,
    //               bottom: BorderSide.none,
    //               left: BorderSide.none,
    //               right: BorderSide.none,
    //             ),
    //             builder: (_) {
    //               return StatefulBuilder(
    //                 builder: (BuildContext context, StateSetter setState) {
    //                   return SizedBox(
    //                     height: kDeviceHeight / 2.5,
    //                     child: Column(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 15, right: 15, top: 15),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               const Spacer(),
    //                               Text(
    //                                 infoPopUpData[0].title ?? '',
    //                                 style: getAppStyle(
    //                                     color: CommonColors.blackColor,
    //                                     fontSize: 18),
    //                               ),
    //                               const Spacer(),
    //                               InkWell(
    //                                 onTap: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 child: Container(
    //                                   decoration: BoxDecoration(
    //                                     shape: BoxShape.circle,
    //                                     color: CommonColors.primaryColor,
    //                                     boxShadow: const [
    //                                       BoxShadow(
    //                                         color: Colors.grey,
    //                                         offset: Offset(2.0, 2.0),
    //                                         blurRadius: 5.0,
    //                                         spreadRadius: 0.0,
    //                                       ),
    //                                       BoxShadow(
    //                                         color: Colors.white,
    //                                         offset: Offset(0.0, 0.0),
    //                                         blurRadius: 0.0,
    //                                         spreadRadius: 0.0,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   child: const Padding(
    //                                     padding: EdgeInsets.all(8.0),
    //                                     child: Icon(
    //                                       Icons.close,
    //                                       color: CommonColors.mWhite,
    //                                       size: 15,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         kCommonSpaceV10,
    //                         kCommonSpaceV3,
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               image: DecorationImage(
    //                                 image: NetworkImage(
    //                                     infoPopUpData[0].image ?? ''),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         if (infoPopUpData[0].isContent == "y") ...[
    //                           kCommonSpaceV15,
    //                           Padding(
    //                             padding: const EdgeInsets.only(
    //                                 left: 10, right: 10, bottom: 8),
    //                             child: Text(
    //                               infoPopUpData[0].description ?? '',
    //                               style: getAppStyle(),
    //                             ),
    //                           ),
    //                         ]
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               );
    //             },
    //           ).whenComplete(() async {
    //             await AppPreferences.setHasShownModal(true);
    //           });
    //         }
    //       });
    //     }
    //   }
    //
    //   // Call the function
    //   showModalIfFirstTime(context);
    // }

    if (currentPage == master.totalPage!) {
      isPageFinish = true;
      log("...........Page............ $currentPage");
    } else {
      currentPage++;
    }

    homePageData.addAll(master.data);

    final Map<String, Function> sectionHandlers = {
      'section_1': (section) {
        section1DataList.addAll(section.data);
        section1Title = section.sectionTitle;
      },
      'section_2': (section) {
        section2DataList.addAll(section.data);
        section2Title = section.sectionTitle;
      },
      'section_3': (section) {
        section3DataList.addAll(section.data);
        section3Title = section.sectionTitle;
      },
      'section_4': (section) {
        section4DataList.addAll(section.data);
        section4Title = section.sectionTitle;
      },
      'section_5': (section) {
        section5DataList.addAll(section.data);
        section5Title = section.sectionTitle;
      },
      'section_6': (section) {
        section6DataList.addAll(section.data.categories);
        section6Title = section.sectionTitle;
      },
      'section_7': (section) {
        section7DataList.addAll(section.data);
        section7Title = section.sectionTitle;
      },
      'section_8': (section) {
        section8DataList.addAll(section.data);
        section8Title = section.sectionTitle;
      },
      'section_9': (section) {
        section9DataList.addAll(section.data.products);
      },
      'section_10': (section) {
        section10Text = section.data.text;
      },
    };

    for (var section in master.data) {
      if (sectionHandlers.containsKey(section.type)) {
        sectionHandlers[section.type]!(section);
      }
    }

    notifyListeners();
  }

  Future<void> addToCartApi({
    required String variantId,
    required String type,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.variant_id: variantId,
      ApiParams.type: type,
    };

    log("Parameter : ${params}");

    AddToCartMaster? master = await services.api!.addToCartApi(params: params);
    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }

    if (master.status == true) {
      log("Success :: true");
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Provider.of<CartViewModel>(context, listen: false).getCartApi();
      // });
      cartDataList = master.data?.product ?? [];
      cartTotalPrice = master.data?.total?.totalAmount.toString() ?? '';
      String totalAmount = master.data?.total?.totalAmount.toString() ?? "";
      AppPreferences.instance.setCartTotal(totalAmount);
      print("Total Amount: $totalAmount");
      String storedAmount = AppPreferences.instance.getCartTotal();
      print("Stored Total Amount from SharedPreferences: $storedAmount");
    }
    notifyListeners();
  }

  Future<void> getProductDetailsApi({
    required String variantId,
  }) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.variant_id: variantId,
    };

    log("Parameter : ${params}");

    ProductDetailsMaster? master =
        await services.api!.getProductDetailsApi(params: params);
    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }
    if (master.status == false) {
      CommonUtils.showCustomToast(context, master.message);
      return;
    }
    if (master.status == true) {
      log("Success :: true");
      productDetailsData = master.data;
    }
    notifyListeners();
  }

  Future<void> resetPage() async {
    await Future.delayed(Duration.zero);
    currentPage = 1;
    isPageFinish = false;
    homePageData.clear();
    section1DataList.clear();
    section2DataList.clear();
    section3DataList.clear();
    section4DataList.clear();
    section5DataList.clear();
    section6DataList.clear();
    section7DataList.clear();
    section8DataList.clear();
    section9DataList.clear();
    notifyListeners();

    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     currentPage = 1;
    //     isPageFinish = false;
    //     homePageData.clear();
    //     section1DataList.clear();
    //     section2DataList.clear();
    //     section3DataList.clear();
    //     section4DataList.clear();
    //     section5DataList.clear();
    //     section6DataList.clear();
    //     section7DataList.clear();
    //     section8DataList.clear();
    //     section9DataList.clear();
    //     notifyListeners();
    //   });
  }
}
