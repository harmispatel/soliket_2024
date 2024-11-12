import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';
import 'contact_us_view_model.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  late ContactUsViewModel mViewModel;
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
    mViewModel = Provider.of<ContactUsViewModel>(context);
    return Scaffold(
      appBar: CommonAppBar(
        title: "About Us",
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