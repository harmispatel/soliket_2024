import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widget/common_appbar.dart';
import '../../../widget/primary_button.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view_model.dart';
import '../../profile/add_address/select_address/select_address_map_view.dart';
import '../../profile/profile_view_model.dart';
import '../../profile/save_address/saved_address_view_model.dart';
import 'check_out_view_model.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView>
    with SingleTickerProviderStateMixin {
  late SavedAddressViewModel mSavedAddressViewModel;
  late ProfileViewModel mProfileViewModel;
  late CheckOutViewModel mViewModel;
  int? selectedIndex;
  String selectedPayment = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mSavedAddressViewModel.attachedContext(context);
      mSavedAddressViewModel.getAddressApi().whenComplete(() {
        mViewModel.getCheckOutDetailsApi().whenComplete(() {
          if (mViewModel.isCodAvailable == "y" &&
              mViewModel.isOnlineAvailable == "y") {
            selectedPayment = 'cod';
          } else if (mViewModel.isOnlineAvailable == "y" &&
              mViewModel.isCodAvailable == "n") {
            selectedPayment = 'online';
          } else if (mViewModel.isOnlineAvailable == "n" &&
              mViewModel.isCodAvailable == "y") {
            selectedPayment = 'cod';
          }

          if (mSavedAddressViewModel.addressList.isNotEmpty) {
            for (int i = 0;
                i < mSavedAddressViewModel.addressList.length;
                i++) {
              if (mSavedAddressViewModel.addressList[i].addressId ==
                  mViewModel.addressId) {
                selectedIndex = i;
                break;
              }
            }

            if (selectedIndex != -1) {
              print("Selected Index: $selectedIndex");
            } else {
              print("Address ID not found in the list.");
            }
          }
        });
      });
      mProfileViewModel.getProfileApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CheckOutViewModel>(context);
    mSavedAddressViewModel = Provider.of<SavedAddressViewModel>(context);
    mProfileViewModel = Provider.of<ProfileViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        mainNavKey.currentContext!
            .read<BottomNavbarViewModel>()
            .onMenuTapped(3);
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
        appBar: CommonAppBar(
          title: "Checkout",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 0.8),
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
                      if (selectedIndex == null || selectedIndex == -1) ...[
                        Center(
                          child: Text(
                            "No delivery address selected",
                            style: getAppStyle(
                                color: CommonColors.mRed, fontSize: 16),
                          ),
                        )
                      ],
                      if (mViewModel.addressId != 0)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    mViewModel.addressType,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getAppStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 02),
                                    child: Text(
                                      mViewModel.address,
                                      style: getAppStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    mViewModel.mobile,
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
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Scaffold(
                                  backgroundColor: Color(0xFFFFF4E8),
                                  body: Container(
                                    color:
                                        CommonColors.mGrey200.withOpacity(0.5),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (mSavedAddressViewModel
                                              .addressList.isNotEmpty)
                                            Text(
                                              "Select address :",
                                              style: getAppStyle(),
                                            ),
                                          kCommonSpaceV10,
                                          if (mSavedAddressViewModel
                                              .addressList.isNotEmpty)
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
                                                      mViewModel
                                                          .setDefaultAddressApi(
                                                              addressId:
                                                                  mSavedAddressViewModel
                                                                      .addressList[
                                                                          index]
                                                                      .addressId
                                                                      .toString())
                                                          .whenComplete(() {
                                                        mViewModel
                                                            .getCheckOutDetailsApi()
                                                            .whenComplete(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      });
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
                                                              activeColor:
                                                                  CommonColors
                                                                      .primaryColor,
                                                              groupValue:
                                                                  selectedIndex,
                                                              onChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                                mViewModel
                                                                    .setDefaultAddressApi(
                                                                        addressId: mSavedAddressViewModel
                                                                            .addressList[
                                                                                selectedIndex!]
                                                                            .addressId
                                                                            .toString())
                                                                    .whenComplete(
                                                                        () {
                                                                  mViewModel
                                                                      .getCheckOutDetailsApi()
                                                                      .whenComplete(
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                });
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
                                                                  mSavedAddressViewModel
                                                                              .addressList[
                                                                                  index]
                                                                              .mobile ==
                                                                          ""
                                                                      ? const SizedBox
                                                                          .shrink()
                                                                      : Text(
                                                                          mSavedAddressViewModel.addressList[index].mobile ??
                                                                              '',
                                                                          style:
                                                                              getAppStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.w500,
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
                                          if (mSavedAddressViewModel
                                              .addressList.isEmpty)
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        height: 150,
                                                        LocalImages
                                                            .img_delivery_boy),
                                                    kCommonSpaceV10,
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 60),
                                                      child: Text(
                                                        "Where do you want us to deliver?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: getAppStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                        isFromCart: true,
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
                                        borderRadius: BorderRadius.circular(6),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color:
                                                  Colors.white.withOpacity(0.8),
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
                                );
                              },
                            );
                          },
                          child: Container(
                            width: kDeviceWidth / 2,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.8),
                            ),
                            child: Center(
                              child: Text(
                                selectedIndex == null
                                    ? "Select delivery address"
                                    : "Change delivery address",
                                style: getAppStyle(
                                    fontSize: 13, color: CommonColors.black54),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV15,
              if (mViewModel.isErrorMsg.isNotEmpty) ...[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      // border: Border.all(color: Colors.red, width: 0.8),
                      // borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Text(
                        mViewModel.isErrorMsg,
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                kCommonSpaceV15,
              ],
              Text(
                "Payment Method",
                style: getAppStyle(),
              ),
              if (mViewModel.isCodAvailable == "y") ...[
                kCommonSpaceV10,
                _buildPaymentOption(
                  image: LocalImages.img_cash_on_del,
                  title: 'Cash On Delivery',
                  value: 'cod',
                ),
              ],
              if (mViewModel.isOnlineAvailable == "y") ...[
                kCommonSpaceV15,
                _buildPaymentOption(
                  image: LocalImages.img_razor_pay,
                  title: 'UPI / Online / Card Payment',
                  value: 'online',
                ),
              ],
              kCommonSpaceV20,
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 0.8),
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
                            "₹${mViewModel.discountAmount}",
                            style: getAppStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "₹${mViewModel.itemTotal}",
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
                            "Delivery Charge ${mViewModel.isFreeDelivery == "y" ? "(Free Delivery)" : ""}",
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
                          SizedBox(width: 10),
                          Text(
                            "+ ₹${mViewModel.deliveryCharge}",
                            style: getAppStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              decoration: mViewModel.isFreeDelivery == "y"
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontSize: 16,
                              textDecorationColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 14),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "Tax",
                    //         style: getAppStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //       Spacer(),
                    //       // Text(
                    //       //   "₹${"9"}",
                    //       //   style: getAppStyle(
                    //       //     color: Colors.grey,
                    //       //     decoration: TextDecoration.lineThrough,
                    //       //     fontWeight: FontWeight.w600,
                    //       //     fontSize: 13,
                    //       //   ),
                    //       // ),
                    //       SizedBox(width: 10),
                    //       Text(
                    //         "+ ₹${mViewModel.tax}",
                    //         style: getAppStyle(
                    //           color: Colors.green,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //           textDecorationColor: Colors.black,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          Text(
                            "Coupon Discount",
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
                            "- ₹${mViewModel.couponDiscount}",
                            style: getAppStyle(
                              color: Colors.red,
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
                          "₹${mViewModel.total}",
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
                                text: "₹${mViewModel.savingAmount}",
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            height: 45,
            label: "Place Order",
            buttonColor: mViewModel.isErrorMsg.isEmpty
                ? CommonColors.primaryColor
                : CommonColors.mGrey500,
            labelColor: CommonColors.mWhite,
            onPress: () {
              if (mViewModel.isErrorMsg.isEmpty) {
                if (selectedPayment == "online") {
                  mViewModel.placeOrderApi(
                    addressId: mSavedAddressViewModel
                        .addressList[selectedIndex!].addressId
                        .toString(),
                    paymentMethod: "online",
                    transactionId: "null",
                  );
                  Razorpay razorpay = Razorpay();
                  double totalAmount = double.parse(mViewModel.total ?? '');
                  var options = {
                    //'key': 'rzp_test_gdFvpbKhIrcbLc',
                    'key': razorpayKey,
                    'amount': (totalAmount * 100).toInt(),
                    'name': 'Soliket',
                    'description': 'Online Payment',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': mProfileViewModel.profileData?.mobile,
                      'email': mProfileViewModel.profileData?.email
                    },
                    'external': {
                      'wallets': ['paytm']
                    },
                    'theme': {
                      'color': appColor.replaceAll('0xff', '#'),
                    },
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorpay.open(options);
                } else if (selectedPayment == "cod") {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    width: kDeviceWidth,
                    buttonsBorderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                    dismissOnTouchOutside: false,
                    dismissOnBackKeyPress: false,
                    headerAnimationLoop: false,
                    animType: AnimType.topSlide,
                    title: 'Confirm Your Order',
                    desc: 'Are you sure you want to place this order?',
                    buttonsTextStyle: getAppStyle(),
                    descTextStyle: getAppStyle(fontSize: 15),
                    titleTextStyle:
                        getAppStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    showCloseIcon: false,
                    btnOk: PrimaryButton(
                      label: "Confirm",
                      buttonColor: CommonColors.primaryColor,
                      labelColor: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      onPress: () {
                        mViewModel.placeOrderApi(
                            addressId: mSavedAddressViewModel
                                .addressList[selectedIndex!].addressId
                                .toString(),
                            paymentMethod: "cod",
                            transactionId: "null");
                      },
                    ),
                    btnCancel: PrimaryButton(
                      label: "Cancel",
                      buttonColor: CommonColors.mRed,
                      labelColor: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ).show();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    // showAlertDialog(context, "Payment Failed",
    //     "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");

    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: false,
      title: 'Payment Failed',
      desc: 'Payment failed please try again',
      autoHide: Duration(seconds: 2),
    ).show();
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");

    // AwesomeDialog(
    //         context: context,
    //         animType: AnimType.topSlide,
    //         headerAnimationLoop: false,
    //         dialogType: DialogType.success,
    //         showCloseIcon: false,
    //         title: 'Payment Successful',
    //         desc: 'Congratulation order placed successfully',
    //         autoHide: Duration(seconds: 2))
    //     .show();

    mViewModel.confirmOrderApi(
        orderId: mViewModel.orderId, transactionId: response.paymentId ?? '');
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                  : Colors.grey.withOpacity(0.5),
              width: 0.8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(height: 20, image),
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
