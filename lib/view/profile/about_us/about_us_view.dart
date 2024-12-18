import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';
import 'about_us_view_model.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  late AboutUsViewModel mViewModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAboutUsApi();
    });
  }

  @override
  void dispose() {
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AboutUsViewModel>(context);
    return Scaffold(
      appBar: CommonAppBar(
        title: "About Us",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (mViewModel.isInitialLoading)
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  padding: kCommonScreenPadding,
                  child: Column(
                    children: [
                      Container(
                        height: 260.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: 25,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              height: 16.0,
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
              // Image.network(mViewModel.aboutUsList[0].image ?? ''),
              FancyShimmerImage(
                width: kDeviceWidth,
                shimmerBaseColor: Colors.white30,
                imageUrl: mViewModel.aboutUsList[0].image ?? '',
              ),
              kCommonSpaceV20,
              Padding(
                padding: kCommonScreenPadding,
                child: HtmlWidget(
                  mViewModel.aboutUsList[0].description ?? '',
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
