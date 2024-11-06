import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/view/cart/coupon/coupon_view_model.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/common_appbar.dart';
import '../../home/profile/edit_account/edit_account_view.dart';

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
      body: SingleChildScrollView(
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
            const CouponListView(),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only()),
            )
          ],
        ),
      ),
    );
  }
}

// * Coupon List View * //

class CouponListView extends StatefulWidget {
  const CouponListView({super.key});

  @override
  State<CouponListView> createState() => _CouponListViewState();
}

class _CouponListViewState extends State<CouponListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  LocalImages.img_coupon_bg,
                  height: 150,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 20, left: 7),
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
            ),
            Padding(
              padding: const EdgeInsets.all(10) +
                  const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "https://newadmin.soliket.com/upload/coupon/coupon_icon.png",
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          debugPrint("OnTap Apply");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 6, top: 6, bottom: 6),
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(08),
                            color: Colors.blueAccent.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              "FREEDEL",
                              style: getAppStyle(
                                color: Colors.blueAccent,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Free Delivery",
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
                          debugPrint("OnTap Apply");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 6, top: 6, bottom: 6),
                          height: 36,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(08),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              "Remove",
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
                          color: Colors.indigoAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
