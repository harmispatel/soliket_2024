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

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solikat_2024/models/add_to_cart_api.dart';
import 'package:solikat_2024/models/home_master.dart';
import 'package:solikat_2024/models/search_master.dart';

import '../../models/cart_master.dart';
import '../../models/product_details_master.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
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

  List<ProductDetailsData>? productDetailsData = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    loginViewModel = LoginViewModel();
    loginViewModel.getAppVersionApi().then((_) {
      loginViewModel.checkAppVersion();
    });
    notifyListeners();
  }

  // void updateCartCount(int variantId, int newCount) {
  //   for (var product in section4DataList) {
  //     if (product.variantId == variantId) {
  //       product.cartCount = newCount;
  //       notifyListeners();
  //       break;
  //     }
  //   }
  // }

  Future<void> getCartApi() async {
    GetCartMaster? master = await services.api!.getCartApi();
    isInitialLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      cartDataList = master.data?.cartItem ?? [];
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

    if (master == null) {
      CommonUtils.oopsMSG();
      return;
    }

    if (!master.status) {
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

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
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }

    if (master.status == true) {
      log("Success :: true");
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Provider.of<CartViewModel>(context, listen: false).getCartApi();
      // });
      cartDataList = master.data?.product ?? [];
      cartTotalPrice = master.data?.total?.totalAmount.toString() ?? '';
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
      CommonUtils.showSnackBar(master.message, color: CommonColors.mRed);
      return;
    }
    if (master.status == true) {
      log("Success :: true");
      productDetailsData = master.data;
    }
    notifyListeners();
  }

  void resetPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }
}
