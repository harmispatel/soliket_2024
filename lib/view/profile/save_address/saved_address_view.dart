import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/global_variables.dart';
import 'package:solikat_2024/view/profile/save_address/saved_address_view_model.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../add_address/edit_address/edit_address_view.dart';
import '../add_address/select_address/select_address_map_view.dart';

class SaveAddressView extends StatefulWidget {
  const SaveAddressView({super.key});

  @override
  State<SaveAddressView> createState() => _SaveAddressViewState();
}

class _SaveAddressViewState extends State<SaveAddressView> {
  late SavedAddressViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAddressApi();
    });
  }

  @override
  void dispose() {
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SavedAddressViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        mainNavKey.currentContext!
            .read<BottomNavbarViewModel>()
            .onMenuTapped(4);

        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BottomNavBarView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
          (Route<dynamic> route) => false,
        );

        return false;
      },
      child: Scaffold(
        backgroundColor: CommonColors.mGrey200,
        appBar: CommonAppBar(
          title: "Saved Addresses",
          isShowShadow: true,
          isTitleBold: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CommonColors.blackColor),
            onPressed: () {
              mainNavKey.currentContext!
                  .read<BottomNavbarViewModel>()
                  .onMenuTapped(4);
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavBarView(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Start from the left
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: mViewModel.isInitialLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  padding: kCommonScreenPadding,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : mViewModel.addressList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          "Where do you want us to deliver?",
                          textAlign: TextAlign.center,
                          style: getAppStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      kCommonSpaceV5,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "You don't have any addresses saved. Saving addresses helps you checkout faster.",
                          textAlign: TextAlign.center,
                          style: getAppStyle(fontSize: 16, height: 1.2),
                        ),
                      ),
                      kCommonSpaceV10,
                      GestureDetector(
                        onTap: () {
                          final latLng = LatLng(
                            double.parse(gUserLat),
                            double.parse(gUserLong),
                          );
                          print(latLng.latitude);
                          print(latLng.longitude);
                          push(SelectAddressMapView(
                            selectedPlace: latLng,
                            isFromEdit: false,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: CommonColors.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            child: Text(
                              "ADD NEW ADDRESS",
                              style: getAppStyle(
                                  color: CommonColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: mViewModel.addressList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        mViewModel.addressList[index].type ??
                                            '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 02),
                                        child: Text(
                                          mViewModel
                                                  .addressList[index].address ??
                                              '',
                                          style: getAppStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "+91-${mViewModel.addressList[index].mobile ?? ''}",
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        push(
                                          EditAddressView(
                                            latitude: double.parse(mViewModel
                                                    .addressList[index]
                                                    .latitude ??
                                                ''),
                                            longitude: double.parse(mViewModel
                                                    .addressList[index]
                                                    .longitude ??
                                                ''),
                                            currentAddress: mViewModel
                                                    .addressList[index]
                                                    .address ??
                                                '',
                                            addressType: mViewModel
                                                    .addressList[index].type ??
                                                '',
                                            houseNo: mViewModel
                                                    .addressList[index]
                                                    .houseName ??
                                                '',
                                            roadName: mViewModel
                                                    .addressList[index].area ??
                                                '',
                                            addressId: mViewModel
                                                .addressList[index].addressId
                                                .toString(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 4),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        height: 30,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: CommonColors.primaryColor
                                                  .withOpacity(0.2)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Edit",
                                            style: getAppStyle(
                                              color: CommonColors.primaryColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        mViewModel.deleteAddressApi(
                                            addressId: mViewModel
                                                .addressList[index].addressId
                                                .toString());
                                      },
                                      child: Text(
                                        "Remove",
                                        style: getAppStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
        bottomNavigationBar: mViewModel.addressList.isEmpty
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  final latLng = LatLng(
                    double.parse(gUserLat),
                    double.parse(gUserLong),
                  );
                  print(latLng.latitude);
                  print(latLng.longitude);
                  push(SelectAddressMapView(
                    selectedPlace: latLng,
                    isFromEdit: false,
                  ));

                  // push(
                  //   SelectAddressMapView(
                  //       selectedPlace: latLng,
                  //       ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: CommonColors.primaryColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Address",
                        style: getAppStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: CommonColors.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// * My Cart List View * //
//
// class AddressListView extends StatefulWidget {
//   const AddressListView({super.key});
//
//   @override
//   State<AddressListView> createState() => _AddressListViewState();
// }
//
// class _AddressListViewState extends State<AddressListView> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.only(top: 15),
//       physics: const ClampingScrollPhysics(),
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: 2,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           margin: const EdgeInsets.only(bottom: 6),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12), color: Colors.white),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Work",
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: getAppStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 02),
//                           child: Text(
//                             "abc",
//                             style: getAppStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "+91-1234567890",
//                           style: getAppStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           print("OnTap Edit Button");
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 4, vertical: 4),
//                           margin: const EdgeInsets.only(bottom: 10),
//                           height: 30,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6),
//                             border: Border.all(
//                                 color:
//                                     CommonColors.primaryColor.withOpacity(0.2)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Edit",
//                               style: getAppStyle(
//                                 color: CommonColors.primaryColor,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           print("OnTap Remove Text Button");
//                         },
//                         child: Text(
//                           "Remove",
//                           style: getAppStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
