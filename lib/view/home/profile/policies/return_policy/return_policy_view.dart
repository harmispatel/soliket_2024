import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/home/profile/policies/return_policy/return_policy_view_model.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';


class ReturnPolicyView extends StatefulWidget {
  const ReturnPolicyView({super.key});

  @override
  State<ReturnPolicyView> createState() => _ReturnPolicyViewState();
}

class _ReturnPolicyViewState extends State<ReturnPolicyView> {
  late ReturnPolicyViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ReturnPolicyViewModel>(context);
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Return & Exchanges Policy",
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
                  mViewModel.returnPolicyList[0].description ?? '',
                  textStyle: getAppStyle(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
