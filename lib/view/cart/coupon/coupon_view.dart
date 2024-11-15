import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/cart/coupon/coupon_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/common_appbar.dart';
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
                        bool isApplied = mViewModel.appliedCoupons[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              dashPattern: [5, 5, 5, 5],
                              color: isApplied
                                  ? Colors.green
                                  : CommonColors.mGrey300,
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
                                          Image.network(
                                            mViewModel.couponList[index].icon ??
                                                '',
                                            height: 40,
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
                                                color: CommonColors.primaryColor
                                                    .withOpacity(0.2),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  mViewModel.couponList[index]
                                                          .couponCode ??
                                                      '',
                                                  style: getAppStyle(
                                                    color: CommonColors
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
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                mViewModel
                                                        .appliedCoupons[index] =
                                                    !mViewModel
                                                        .appliedCoupons[index];
                                              });
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
                                                color: isApplied
                                                    ? Colors.red
                                                    : CommonColors.primaryColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  isApplied
                                                      ? "Remove"
                                                      : "Apply",
                                                  style: getAppStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          debugPrint("OnTap Change");
                                        },
                                        child: Text(
                                          "View Details",
                                          style: getAppStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: CommonColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 4, bottom: 12, left: 7),
                              child: Text(
                                "Buy items worth ₹3363.0 to avail this offer",
                                style: getAppStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
}
