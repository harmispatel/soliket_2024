import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/home/profile/policies/shipping_policy/shipping_policy_view_model.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';

class ShippingPolicyView extends StatefulWidget {
  const ShippingPolicyView({super.key});

  @override
  State<ShippingPolicyView> createState() => _ShippingPolicyViewState();
}

class _ShippingPolicyViewState extends State<ShippingPolicyView> {
  late ShippingPolicyViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ShippingPolicyViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Shipping Policy",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (!mViewModel.isInitialLoading) ...[
                Padding(
                  padding: kCommonScreenPadding,
                  child: HtmlWidget(
                    mViewModel.shippingPolicyList[0].description ?? '',
                    textStyle: getAppStyle(),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
