import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widget/common_appbar.dart';
import '../../../widget/primary_button.dart';
import '../../profile/add_address/select_address/select_address_map_view.dart';
import '../../profile/save_address/saved_address_view_model.dart';
import 'check_out_view_model.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late SavedAddressViewModel mSavedAddressViewModel;
  late CheckOutViewModel mViewModel;
  int? selectedIndex;
  String selectedPayment = 'cod';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mSavedAddressViewModel.attachedContext(context);
      mSavedAddressViewModel.getAddressApi().whenComplete(() {
        selectedIndex = mSavedAddressViewModel.addressList
            .indexWhere((item) => item.isDefault == "y");
        if (selectedIndex != -1) {
          print('Selected index: $selectedIndex');
        } else {
          print('No item with isDefault "y" found');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CheckOutViewModel>(context);
    mSavedAddressViewModel = Provider.of<SavedAddressViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(
        title: "Check out",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: Padding(
        padding: kCommonScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [5, 5, 5, 5],
              color: CommonColors.mGrey300,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address Detail",
                        style: getAppStyle(),
                      ),
                      kCommonSpaceV10,
                      selectedIndex == null
                          ? Center(
                              child: Text(
                                "No delivery address selected",
                                style: getAppStyle(
                                    color: CommonColors.mRed, fontSize: 18),
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        mSavedAddressViewModel
                                                .addressList[selectedIndex!]
                                                .type ??
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
                                          mSavedAddressViewModel
                                                  .addressList[selectedIndex!]
                                                  .address ??
                                              '',
                                          style: getAppStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "+91-${mSavedAddressViewModel.addressList[selectedIndex!].mobile ?? ''}",
                                        style: getAppStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      kCommonSpaceV15,
                      Center(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(5),
                          dashPattern: [5, 5, 5, 5],
                          color: CommonColors.primaryColor.withOpacity(0.5),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    body: Container(
                                      color: CommonColors.mGrey200
                                          .withOpacity(0.5),
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Select address",
                                              style: getAppStyle(),
                                            ),
                                            kCommonSpaceV10,
                                            Expanded(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    mSavedAddressViewModel
                                                        .addressList.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIndex = index;
                                                      });
                                                      mViewModel.setDefaultAddressApi(
                                                          addressId:
                                                              mSavedAddressViewModel
                                                                  .addressList[
                                                                      index]
                                                                  .addressId
                                                                  .toString());
                                                      Navigator.pop(context);
                                                    },
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Radio<int>(
                                                              value: index,
                                                              groupValue:
                                                                  selectedIndex,
                                                              onChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                                mViewModel.setDefaultAddressApi(
                                                                    addressId: mSavedAddressViewModel
                                                                        .addressList[
                                                                            index!]
                                                                        .addressId
                                                                        .toString());
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    mSavedAddressViewModel
                                                                            .addressList[index]
                                                                            .type ??
                                                                        '',
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        getAppStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            02),
                                                                    child: Text(
                                                                      mSavedAddressViewModel
                                                                              .addressList[index]
                                                                              .address ??
                                                                          '',
                                                                      style:
                                                                          getAppStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "+91-${mSavedAddressViewModel.addressList[index].mobile ?? ''}",
                                                                    style:
                                                                        getAppStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ],
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
                                    bottomNavigationBar: GestureDetector(
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
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        height: 48,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: CommonColors.primaryColor,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    CommonColors.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: kDeviceWidth / 2,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  selectedIndex == null
                                      ? "Select delivery address"
                                      : "Change delivery address",
                                  style: getAppStyle(
                                      fontSize: 13,
                                      color: CommonColors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kCommonSpaceV15,
            Text(
              "Payment Method",
              style: getAppStyle(),
            ),
            kCommonSpaceV10,
            _buildPaymentOption(
              image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlmfDWOz_NvovSs7fMIVtGOluFu7ul-9EMhA&s",
              title: 'Cash On Delivery',
              value: 'cod',
            ),
            kCommonSpaceV10,
            _buildPaymentOption(
              image:
                  "https://images.saasworthy.com/tr:w-160,h-0,c-at_max,e-sharpen-1/razorpay_3762_logo_1603891770_dtlfw.jpg",
              title: 'UPI / Online / Card Payment',
              value: 'onlinepayment',
            ),
            kCommonSpaceV20,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bill Details",
                    style: getAppStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 14),
                    child: Row(
                      children: [
                        Text(
                          "Item Total",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹${"1000"}",
                          style: getAppStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₹${"1000"}",
                          style: getAppStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Text(
                          "Delivery Charge",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹${"9"}",
                          style: getAppStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₹${"0"}",
                          style: getAppStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Text(
                          "Offer Discount",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        // Text(
                        //   "₹${"9"}",
                        //   style: getAppStyle(
                        //     color: Colors.grey,
                        //     decoration: TextDecoration.lineThrough,
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 13,
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Text(
                          "₹${"-50"}",
                          style: getAppStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To Pay",
                        style: getAppStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "₹${"1000"}",
                        style: getAppStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  kCommonSpaceV10,
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.green.withOpacity(0.3),
                      image: DecorationImage(
                          image: AssetImage(LocalImages.img_total_saving_bg),
                          fit: BoxFit.fill),
                    ),
                    child: Center(
                      child: RichText(
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        softWrap: true,
                        maxLines: 1,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Saving ',
                              style: getAppStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: "₹${"250.0"}",
                              style: getAppStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: " on this order.",
                              style: getAppStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.green,
                              ),
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.star_rate_outlined,
                                size: 17,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          height: 45,
          label: "Place Order",
          buttonColor: CommonColors.primaryColor,
          labelColor: CommonColors.mWhite,
          onPress: () {},
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      {required String image, required String title, required String value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPayment == value
                ? CommonColors.primaryColor
                : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: .0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(height: 20, image),
            kCommonSpaceH10,
            Text(
              title,
              style: getAppStyle(fontSize: 13.0),
            ),
            Spacer(),
            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPayment = newValue!;
                });
              },
              activeColor: CommonColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
