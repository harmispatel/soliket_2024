import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../../utils/common_colors.dart';
import '../../../../widget/common_appbar.dart';
import 'help_&_support_view_model.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  late HelpSupportViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getContactUsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HelpSupportViewModel>(context);
    return Scaffold(
      appBar: CommonAppBar(
        title: "Help & Support",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: SingleChildScrollView(
        padding: kCommonScreenPadding,
        child: Column(
          children: [
            if (!mViewModel.isInitialLoading) ...[
              HtmlWidget(mViewModel.contactUsList[0].description ?? ''),
              kCommonSpaceV20,
              Image.network(mViewModel.contactUsList[0].image ?? ''),
            ]
          ],
        ),
      ),
    );
  }
}
