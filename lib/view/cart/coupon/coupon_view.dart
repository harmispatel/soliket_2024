import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/cart/coupon/coupon_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/common_appbar.dart';
import '../../../widget/primary_button.dart';
import '../../profile/edit_account/edit_account_view.dart';

class CouponsOffersView extends StatefulWidget {
  const CouponsOffersView({super.key});

  @override
  State<CouponsOffersView> createState() => _CouponsOffersViewState();
}

class _CouponsOffersViewState extends State<CouponsOffersView> {
  TextEditingController edCouponApplyController = TextEditingController();

  bool isTextFilled = false;
  late CouponViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  void dispose() {
    mViewModel.couponList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CouponViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Apply Coupon",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: Padding(
        padding: kCommonScreenPadding,
        child: Column(
          children: [
            TextFormFieldCustom(
              // controller: edBuildingController,
              textInputType: TextInputType.text,
              hintText: "Enter Coupon Code",
              labelText: "Enter Coupon Code",
              suffixIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        color: CommonColors.mGrey300,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: getAppStyle(color: CommonColors.mGrey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            kCommonSpaceV15,
            mViewModel.isInitialLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                          ),
                          kCommonSpaceV15,
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                          ),
                          kCommonSpaceV15,
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                          ),
                          kCommonSpaceV15,
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: mViewModel.couponList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              dashPattern: [5, 5, 5, 5],
                              color: mViewModel.couponList[index].isApplied ==
                                      'y'
                                  ? Colors.green
                                  : mViewModel.couponList[index].isEnabled ==
                                          "n"
                                      ? CommonColors.mGrey300
                                      : Colors.black26,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  // border: Border.all(
                                  //   color: isApplied
                                  //       ? Colors.green
                                  //       : CommonColors.mGrey300,
                                  //   width: 1.2,
                                  // ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              if (mViewModel.couponList[index]
                                                      .isEnabled ==
                                                  "y")
                                                Image.network(
                                                  mViewModel.couponList[index]
                                                          .icon ??
                                                      '',
                                                  height: 40,
                                                ),
                                              if (mViewModel.couponList[index]
                                                      .isEnabled ==
                                                  "n")
                                                Center(
                                                  child: ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.white
                                                          .withOpacity(0.5),
                                                      BlendMode
                                                          .srcOver, // Blend mode for overlay
                                                    ),
                                                    child: Image.network(
                                                      mViewModel
                                                              .couponList[index]
                                                              .icon ??
                                                          '',
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint("OnTap Apply");
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 6,
                                                  top: 6,
                                                  bottom: 6),
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(08),
                                                color: mViewModel
                                                            .couponList[index]
                                                            .isEnabled ==
                                                        "n"
                                                    ? CommonColors.mGrey500
                                                        .withOpacity(0.1)
                                                    : CommonColors.primaryColor
                                                        .withOpacity(0.2),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  mViewModel.couponList[index]
                                                          .couponCode ??
                                                      '',
                                                  style: getAppStyle(
                                                    color: mViewModel
                                                                .couponList[
                                                                    index]
                                                                .isEnabled ==
                                                            "n"
                                                        ? CommonColors.black45
                                                        : CommonColors
                                                            .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              mViewModel.couponList[index]
                                                      .message ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: getAppStyle(
                                                color: mViewModel
                                                            .couponList[index]
                                                            .isEnabled ==
                                                        "n"
                                                    ? CommonColors.black45
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   mViewModel.appliedCoupons[index] = !mViewModel.appliedCoupons[index];
                                              // });
                                              if (mViewModel.couponList[index]
                                                          .isApplied ==
                                                      'n' &&
                                                  mViewModel.couponList[index]
                                                          .isEnabled ==
                                                      "y") {
                                                mViewModel
                                                    .applyCouponApi(
                                                        couponId: mViewModel
                                                            .couponList[index]
                                                            .couponId
                                                            .toString())
                                                    .whenComplete(() {
                                                  Navigator.pop(context);
                                                  _showApplyCouponDialog(
                                                    context,
                                                    mViewModel.couponList[index]
                                                            .couponCode ??
                                                        '',
                                                    mViewModel.couponList[index]
                                                            .message ??
                                                        '',
                                                  );
                                                });
                                              }

                                              if (mViewModel.couponList[index]
                                                      .isApplied ==
                                                  'y') {
                                                mViewModel.removeCouponApi(
                                                    couponId: mViewModel
                                                        .couponList[index]
                                                        .couponId
                                                        .toString());
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 6,
                                                  top: 6,
                                                  bottom: 6),
                                              height: 36,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(08),
                                                color: mViewModel
                                                            .couponList[index]
                                                            .isApplied ==
                                                        'y'
                                                    ? Colors.red
                                                    : mViewModel
                                                                .couponList[
                                                                    index]
                                                                .isEnabled ==
                                                            "n"
                                                        ? CommonColors.mGrey300
                                                        : CommonColors
                                                            .primaryColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  mViewModel.couponList[index]
                                                              .isApplied ==
                                                          'y'
                                                      ? "Remove"
                                                      : "Apply",
                                                  style: getAppStyle(
                                                    color: mViewModel
                                                                .couponList[
                                                                    index]
                                                                .isEnabled ==
                                                            "n"
                                                        ? CommonColors.black45
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            kCommonSpaceV15,
                            // Padding(
                            //   padding:
                            //       EdgeInsets.only(top: 4, bottom: 12, left: 7),
                            //   child: Text(
                            //     "Buy items worth ₹3363.0 to avail this offer",
                            //     style: getAppStyle(
                            //       color: Colors.red,
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _showApplyCouponDialog(
      BuildContext context, String coupon, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.close,
                          size: 15,
                          color: CommonColors.mWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "$coupon applied",
                  style: getAppStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0a5d00),
                      fontSize: 18),
                ),
                kCommonSpaceV10,
                Image.network(
                    height: 80,
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaysv5S3umspA7i8mwLxeDL7ZtZF9jtgAmHkBUpQOHI63iNGb7H5jENnmMtO-DIIrCD1k&usqp=CAU"),
                kCommonSpaceV20,
                Text(
                  "$message",
                  style: getAppStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0a5d00),
                      fontSize: 22),
                ),
                Text(
                  "with this coupon",
                  style: getAppStyle(color: Color(0xff0a5d00), fontSize: 18),
                ),
                kCommonSpaceV20,
                PrimaryButton(
                  height: 50,
                  width: 220,
                  label: "Yay! Thanks",
                  buttonColor: CommonColors.greenColor.withOpacity(0.2),
                  labelColor: Color(0xff0a5d00),
                  borderRadius: BorderRadius.circular(8),
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
