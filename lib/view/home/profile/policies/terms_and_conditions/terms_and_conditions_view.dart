import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/home/profile/policies/terms_and_conditions/terms_and_conditions_view_model.dart';
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
        child: Column(
          children: [
            if (!mViewModel.isInitialLoading) ...[
              Padding(
                padding: kCommonScreenPadding,
                child: HtmlWidget(
                  mViewModel.termsAndConditionsList[0].description ?? '',
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
