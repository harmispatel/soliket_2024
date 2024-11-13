import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/home/profile/policies/privacy_policy/privacy_policy_view_model.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';


class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  late PrivacyPolicyViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<PrivacyPolicyViewModel>(context);
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Privacy Policy",
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
                  mViewModel.privacyPolicyList[0].description ?? '',
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
