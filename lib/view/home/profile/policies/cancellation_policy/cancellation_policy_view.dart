import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';
import 'cancellation_policy_view_model.dart';

class CancellationPolicyView extends StatefulWidget {
  const CancellationPolicyView({super.key});

  @override
  State<CancellationPolicyView> createState() => _CancellationPolicyViewState();
}

class _CancellationPolicyViewState extends State<CancellationPolicyView> {
  late CancellationPolicyViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CancellationPolicyViewModel>(context);
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
                  mViewModel.cancellationPolicyList[0].description ?? '',
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
