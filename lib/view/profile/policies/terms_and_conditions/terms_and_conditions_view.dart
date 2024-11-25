import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/profile/policies/terms_and_conditions/terms_and_conditions_view_model.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  late TermsAndConditionsViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  void dispose() {
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<TermsAndConditionsViewModel>(context);
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Terms & Conditions",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: SingleChildScrollView(
        padding: kCommonScreenPadding,
        child: Column(
          children: [
            if (mViewModel.isInitialLoading)
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            if (!mViewModel.isInitialLoading) ...[
              HtmlWidget(
                mViewModel.termsAndConditionsList[0].description ?? '',
                textStyle: getAppStyle(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}